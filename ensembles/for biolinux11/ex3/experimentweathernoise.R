source('flakedream2.R')

if (!file.exists('meta/')) dir.create('meta')

## ## wind:             bias and noise
## ## temperature:      bias and noise
## ## global radiation: noise
## ## back radiation:   noise
## ts.input.noise <- ts.input
## ndays <- nrow(ts.input.noise) / m
## windnoise <- pmax(0, rnorm(ndays, m = 1.2, sd = 0.2))
## ts.input.noise[['U_a_in']] =
##   ts.input[['U_a_in']] * rep(windnoise, each = m)
## tnoise <- rnorm(ndays, m = 0.2, sd = 1)
## ts.input.noise[['T_a_in']] =
##   ts.input[['T_a_in']] + rep(tnoise, each = m)
## ccnoise <- rnorm(ndays, m = 1, sd = 0.1)
## ts.input.noise[['I_atm_in']] =
##   ts.input[['I_atm_in']] * rep(ccnoise, each = m)
## ts.input.noise[['Q_atm_lw_in']] =
##   ts.input[['Q_atm_lw_in']] * rep(ccnoise, each = m)
## save(ts.input.noise, file = 'meta/ts.input.noise.RData')
load('meta/ts.input.noise.RData')

flakedreamreadyweathernoise <- function(pars, depths) {
  parameters <- theparameters
  optic <- theoptic
  parameters[['depth_w']] <- pars[1]
  parameters[['fetch']] <- pars[2]
  optic[['extincoef_water']] <- pars[3]
  result <- runflake(ts.input.noise, parameters, init.state, optic)[-initiali, ]
  fieldseason <- (165 * m + 1):(210 * m)
  tds <- TemperatureAtDepths(result[fieldseason, ], parameters, depths)
  tdsdaily <- apply(tds, 2, tapply, INDEX = rep(166:210, each = m), mean)
  return(c(tdsdaily))
}

load('meta/dcs.RData')
dcsshort <- dcs[c(1:21, 22:71, 122:171)]
savepathsshort <- savepaths[c(1:21, 22:71, 122:171)]
save(dcsshort, file = 'meta/dcsshort.RData')
save(savepathsshort, file = 'meta/savepathsshort.RData')

control1 <- list(ndim = 1,
                 nseq = 4,
                 maxtime = 60 * 4,  # seconds
                 parallel = "multicore")

if (!file.exists('dream/')) dir.create('dream')

savepathsshort <- sprintf('dreamweathernoise/%s.RData', names(dcsshort))

flakedreamreadyweathernoisedepth <- function(pars, depths) {
  cat(pars)
  cat('\n')
  thepars <- c(20, c(pars), 2)
  return(flakedreamreadyweathernoise(thepars, depths))
}
parlistdepth <- parlist['fetch'] ## still a list with length 1

## for (dci in 1:length(dcsshort)) {
for (dci in 1:2) {
  dc <- dcsshort[[dci]]
  default <- defaults[[dci]]
  ## still targeting the defaults made with the original weather
  dcname <- names(dcsshort)[dci]
  savepath <- savepathsshort[dci]
  cat('\n\n')
  cat(c(dcname, dc))
  cat('\n\n')
  measurement1 <- list(data = c(default))
  d <- dream(flakedreamreadyweathernoisedepth, "calc.rmse", parlistdepth,
             FUN.pars = list(depths = dc),
             control = control1,
             measurement = measurement1)
  print(d)
  print(summary(d))
  save(d, file = savepath)
}  
       
