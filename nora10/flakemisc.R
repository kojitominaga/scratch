require(flaker)
require(flakeutil)
require(rootSolve)

ip <- 9

readN10 <- function(prefix, years, interp) {
  fnames <- as.list(paste0(sprintf('%s%s.txt.gz', prefix, years)))
  L1 <- lapply(fnames, function(x) { read.table(x)[, interp] } )
  out <- do.call(c, L1)
}
  
g173 <-
  read.table('astmg173/ASTMG173.csv', skip = 2, sep = ',', 
             col.names = c('wavelength', 'etr', 'globaltilt', 'directcircum'))
usethiscolumn <- 'globaltilt'
ir <- g173[[usethiscolumn]]
wl <- g173[['wavelength']]
n <- nrow(g173)
cumulative <- cumsum((wl[2:n] - wl[1:(n - 1)]) * ir[2:n])
cumfun <- approxfun((wl[1:(n - 1)] + wl[2:n]) / 2, cumulative / cumulative[n-1])
g173fun <- approxfun(wl, ir)

breakcumsum <- seq(from = 0.1, to = 0.9, length.out = 9)
breakwl <- numeric(length = length(breakcumsum))
for (i in 1:length(breakcumsum)) {
  breakwl[i] <- uniroot(function(x) {cumfun(x) - breakcumsum[i]},
                        range(wl[3:(n - 3)]))[['root']]
                        ## 3, just to avoiding being out of domain
}
limitwl <- c(range(wl)[1], breakwl, range(wl)[2])

H2O <- read.table('comsat/Tom on attenuation/H2O spectrum.txt', header = TRUE)
H2Ofun <- approxfun(H2O[['lambda.nm']], H2O[['absorbance.cm']] * 100,
                    rule = c(1, 2))
DOMfun <- function(a400) {
  ## TOM's work unpublished
  ## Estimate, SE for the ln(alpha): -4.31, 0.016
  ## a(lambda) = a_at_400 * exp(-alpha * (lambda - 400))
  return(function(x) { a400 * exp(-1 * exp(-4.31) * (x - 400)) })
}
  
## x <- 280:2000
## y1 <- H2Ofun(x)
## y2 <- DOMfun(1)(x)
## plot(x, y1, type = 'l', ylim=c(0,2), xlim=c(280, 1000))
## lines(x, y2, col = 'blue')

effectiveattn <-
  function(a400, irfun, H2Ofun, limitwl, resolution = 100, depth = 1) {
    ## how much light is attenuated at the depth 
    nbands <- length(limitwl) - 1
    out <- numeric(length = nbands)
    for (i in 1:nbands) {
      wl <- seq(from = limitwl[i], to = limitwl[i + 1],
                 length.out = resolution)
      a <- H2Ofun(wl) + DOMfun(a400)(wl)
      ir <- irfun(wl)
      irwater <- ir * exp(-1 * depth * a)
      a.effective <- - log(sum(irwater) / sum(ir))
      out[i] <- a.effective
    }
    return(out)
  }

## > effectiveattn(1, g173fun, H2Ofun, limitwl)
##  [1]  1.1064167  0.3921197  0.1993012  0.2872562  0.5402856  2.1244457
##  [7]  3.6169920 16.8266403 36.0000245 36.0000001


flakeinputs <- function(lakename, years, interp, atten) {
  pf <- sprintf('interpolated/%s/interpolated-%s_NORA10', lakename, lakename)
  pr <- readN10(sprintf('%s_1H_11km_pr_', pf), years, interp)
  pr <- pmax(pr, 0)
  albedo <- readN10(sprintf('%s_1H_11km_albedo_', pf), years, interp)
  rss <- readN10(sprintf('%s_1H_11km_rss_', pf), years, interp)
  rss <- rss / 3.6
  rls <- readN10(sprintf('%s_1H_11km_rls_', pf), years, interp)
  rls <- rls / 3.6
  wss <- readN10(sprintf('%s_1H_11km_wss_10m_', pf), years, interp)
  wss <- pmax(wss, 0)
  ta <- readN10(sprintf('%s_1H_11km_ta_2m_', pf), years, interp)
  ts <- readN10(sprintf('%s_1H_11km_ts_0m_', pf), years, interp)
  hur <- readN10(sprintf('%s_1H_11km_hur_2m_', pf), years, interp)
  hur <- pmin(pmax(hur, 0), 100)
  ps <- readN10(sprintf('%s_3H_11km_ps_', pf), years, interp)
  rsds <- rss * 100 / (100 - albedo)
  hurs <- hurr2hurs(hur, ta, ps)
  rlus <- 5.6704e-8 * (ts ^ 4)
  rlds <- rls + rlus
  ts.input <- data.frame(dMsnowdt_in=pr, I_atm_in=rsds, Q_atm_lw_in=rlds,
                         height_u_in=rep(10, times=length(pr)),
                         height_tq_in=rep(2, times=length(pr)),
                         U_a_in=wss, T_a_in=ta, q_a_in=hurs, P_a_in=ps)
  parameters <- c(depth_w=20, fetch=1000, depth_bs=3, T_bs=mean(ta),
                  par_Coriolis=sin(60 / 180 * pi) * 2 * 7.29e-5,
                  del_time=60 * 60 * 24,
                  albedo_water=0.9, albedo_ice=0.5, albedo_snow=0.3)
  init.state <- c(T_snow=273.15, T_ice=273.15, T_mnw=275, T_wML=273.20,
                  T_bot=273.15 + 3.98, T_B1=273.15 + 6, C_T=0.5,
                  h_snow=0, h_ice=0, h_ML=10, H_B1=1.5, T_sfc=273.15)
  optic <- list(opticpar_nband_water=1,
                opticpar_frac_water=rep(0.1, times=10),
                opticpar_extincoef_water=atten,
                opticpar_nband_ice=1,
                opticpar_frac_ice=c(1, rep(0, times=9)),
                opticpar_extincoef_ice=c(20, rep(100, times=9)),
                opticpar_nband_snow=1,
                opticpar_frac_snow=c(1, rep(0, times=9)),
                opticpar_extincoef_snow=c(20, rep(100, times=9)))
  list(ts.input=ts.input, parameters=parameters,
       init.state=init.state, optic=optic, simpleoptic=FALSE)
}

i170 <- flakeinputs('COMSAT170', 2007:2012, 9,
                    effectiveattn(1, g173fun, H2Ofun, limitwl))
result <- do.call(runflake, i170)
dates <- seq(from = as.Date('2007-01-01'), to = as.Date('2012-12-31'),
             by = 'day')
in.2011 <- (dates >= as.Date('2011-01-01')) & (dates <= as.Date('2011-12-31'))
warm <- result[['T_bot']] >= (273.15 + 3.98) &
  result[['T_wML']] >= (273.15 + 3.98) &
  result[['T_mnw']] >= (273.15 + 3.98)

springturnover <- dates[warm & in.2011][1]
i170short <- i170
observationdate <- as.Date('2011-08-08')
i170short[['ts.input']] <-
  i170short[['ts.input']][((dates >= springturnover) &
                           (dates <= observationdate)), ]
r <- result[which(dates == springturnover), ]
i170short[['init.state']] <- c(T_snow = r[['T_snow']],
                               T_ice = r[['T_ice']],
                               T_mnw = r[['T_mnw']],
                               T_wML = r[['T_wML']],
                               T_bot = r[['T_bot']],
                               T_B1 = r[['T_B1']],
                               C_T = r[['C_T']],
                               h_snow = r[['h_snow']],
                               h_ice = r[['h_ice']],
                               h_ML = r[['h_ML']],
                               H_B1 = r[['H_B1']],
                               T_sfc = r[['T_sfc']])

