require(flakeutil)
require(FME)

## parameters, default
pars <- list()
pars[['depth']] <- 20
pars[['fetch']] <- 1000
pars[['atten']] <- 2

## prepare data

dirname <- '041-068'

firstday <- as.Date('1991-01-01')
lastday <- as.Date('1991-12-31')
dayseq <- seq(from = firstday, to = lastday, by = 'day')
dayseqP <- as.POSIXlt(dayseq)

pr <- scan(paste0(dirname, '/', 'pr.csv.gz'))
rlds <- scan(paste0(dirname, '/', 'rlds.csv.gz'))
wss <- scan(paste0(dirname, '/', 'wss.csv.gz'))
huss <- scan(paste0(dirname, '/', 'huss.csv.gz'))
ps <- scan(paste0(dirname, '/', 'ps.csv.gz'))

rootpath24 <- './'
rsds24 <- scan(paste0(dirname, '/', 'rsds24.csv.gz'))
tas24 <- scan(paste0(dirname, '/', 'tas24.csv.gz'))
  
height_u <- 10
height_tq <- 2

n <- length(pr)
n0 <- length(dayseq)
m <- 24
initialrepeat <- 1
  
ts.input00 <- data.frame(dMsnowdt_in = rep(pr, each = m),
                         I_atm_in = rsds24,
                         Q_atm_lw_in = rep(rlds, each = m),
                         height_u_in = rep(rep(height_u, times = n),
                           each = m),
                         height_tq_in = rep(rep(height_tq, times = n),
                           each = m),
                         U_a_in = rep(wss, each = m),
                         T_a_in = tas24,
                         q_a_in = rep(huss, each = m),
                         P_a_in = rep(ps, each = m)
                         )
ts.input0 <- ts.input00[1:(m * n0), ]
if(any(is.na(as.matrix(ts.input0)))) {
  skippedf <- file("skipped", open = 'a')
  cat(c("skipped:", dirname, '\n'), file = skippedf)
  close(skippedf)
  next
  ## this is necessary when something went wrong with the input
  ## meteorological data. Just skip it. 
}
ts.input <- ts.input0[c(rep(1:(m * 365), times = initialrepeat), 1:(n0 * m)), ]
initiali <- 1:(m * 365 * initialrepeat)

parameters <- c(pars[['depth']], pars[['fetch']], 0.5,
                mean(ts.input[['T_a_in']]),
                sin(60 / 180 * pi) * 2 * 7.29e-5,
                60 * 60 * 24 / m,
                0, 0.8, 0.8)
names(parameters) <-
  c('depth_w', 'fetch', 'depth_bs', 'T_bs', 'par_Coriolis', 'del_time',
    'albedo_water', 'albedo_ice', 'albedo_snow')

init.state <-
  c(0 + 273.15, 0 + 273.15, 4 + 273.15, 4 + 273.15, 4 + 273.15, 5 + 273.15,
    0.5, 0, 0, parameters[['depth_w']], 0.4, 4 + 273.15)
names(init.state) <-
  c('T_snow', 'T_ice', 'T_mnw', 'T_wML', 'T_bot', 'T_B1',
    'C_T', 'h_snow', 'h_ice', 'h_ML', 'H_B1', 'T_sfc')

optic <- c(pars[['atten']], 20, 20)
names(optic) <- paste('extincoef_', c('water', 'ice', 'snow'), sep = '')

flakeFMEready <- function(pars) {
  parameters[['depth_w']] <- pars[['depth']]
  parameters[['fetch']] <- pars[['fetch']]
  optic[['extincoef_water']] <- pars[['atten']]
  result <- data.frame(ts.input,
                       runflake(ts.input, parameters, init.state, optic)
                       )[-initiali, ]
  surfaceT <- tapply(result[['T_wML']],
                     rep(1:n0, each = m, length.out = nrow(result)),
                     mean)
  return(matrix(surfaceT, ncol = 1, dimnames = list(NULL, 'twml')))
}

pars.gs.range <- data.frame(
  row.names = c('depth', 'fetch', 'atten'),
  min = c(3, 300, 0.5),
  max = c(30, 10000, 20)
  )

sR <- sensRange(func = flakeFMEready, parRange = pars.gs.range,
                map = NULL, num = 100)
sF <- sensFun(flakeFMEready, parms = pars, map = NULL)

flakeFMEreadyday240 <- function(pars){
  flakeFMEready(pars)[240, ]
}

## mc <- modCRL(flakeFMEreadyday240, parRange = pars.gs.range)

## make observation data for MCMC
## here assume the default parameters and we try to let MCMC find the values

## in the case where we have all the daily values

default <- flakeFMEready(pars)

## make this the __observations__
observations <- data.frame(name = rep('twml', times = nrow(default)),
                           time = 1:nrow(default),
                           val = as.vector(default),
                           err = rep(0.5, times = nrow(default))
                           )
## objective function
objective <- function(x, parset = names(x)) {
  pars[parset] <- x
  out <- flakeFMEready(pars)
  mod <- data.frame(time = 1:nrow(default),
                    twml = as.vector(out))
  return(modCost(obs = observations, model = mod, y = 'val', err = 'err'))
}

Coll <- collin(sF <- sensFun(func = objective, parms = pars, map = NULL))



