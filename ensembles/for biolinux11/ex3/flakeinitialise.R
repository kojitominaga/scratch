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
lastday <- as.Date('1991-07-31')
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
## initialrepeat <- 1
  
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
ts.input <- ts.input00[c((m * 120 + 1):(m * 365), 1:(n0 * m)), ]
initiali <- 1:(m * (365 - 120))

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
