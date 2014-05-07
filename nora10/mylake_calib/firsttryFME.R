require(FME)

outdir <- paste0('testing_2014-03-18/', 'COMSAT', '180')
obsraw <- read.table(paste0(outdir, '/', 'COMSAT_field_2011-07-29.txt'))
if (nrow(obs) != max(obsraw) + 1) {
  stop('suspect none-sequence observation data')
}
obs <- obsraw[, 2]
obsdf <-
  data.frame(name = 'temperature',
             depth = 1:length(obs),
             val = obs)

## parameters, default
pars <- list()
pars[['Kz']] <- 0.02
pars[['Cs']] <- 0.9

mlFMEready <- function(pars) {
  command = paste('python engine.py',
    180,
    pars[['Kz']], pars[['Cs']],
    collapse = ' ')
  cat(command) ; cat('\n')
  system(command) 
  raw <- scan(paste0(outdir, '/', 'Tzt.txt'), quiet = TRUE)[1:length(obs)]
  modeldf <- data.frame(depth = 1:length(obs),
                        temperature = raw)
  return(modeldf)
}

pars.gs.range <- data.frame(
  row.names = c('Kz', 'Cs'),
  min = c(0.00001, 0.00001),
  max = c(0.99999, 0.99999)
  )

mlcost <- function(pars) {
  out <- mlFMEready(pars)
  cost <- modCost(out, obsdf, x = 'depth', y = 'val')
}


## sR <- sensRange(func = mlFMEready, parRange = pars.gs.range,
##                 map = NULL, num = 100)
## sF <- sensFun(mlFMEready, parms = pars, map = NULL)

## mc <- modCRL(flakeFMEreadyday240, parRange = pars.gs.range)

## make observation data for MCMC
## here assume the default parameters and we try to let MCMC find the values

## in the case where we have all the daily values

default <- mlFMEready(pars)

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

## Coll <- collin(sF <- sensFun(func = objective, parms = pars, map = NULL))

## modFit next
## the following is easy: starting from the answer
## Fit1 <- modFit(objective, c(pars, recursive = TRUE),
##                lower = pars.gs.range[['min']],
##                upper = pars.gs.range[['max']]
##                )
## ## starting a bit off, takes more iterations
## Fit2 <-  modFit(objective, c(pars, recursive = TRUE) / 2,
##                lower = pars.gs.range[['min']],
##                upper = pars.gs.range[['max']]
##                )
## recording
## if (!file.exists('modFit/')) dir.create('modFit')
## print(summary(Fit1))
## save(Fit1, file = 'modFit/Fit1.RData')
## pdf('modFit/Fit1.pdf')
## plot(Fit1)
## dev.off()
## print(summary(Fit2))
## save(Fit2, file = 'modFit/Fit2.RData')
## pdf('modFit/Fit2.pdf')
## plot(Fit2)
## dev.off()
load('modFit/Fit1.RData')
load('modFit/Fit2.RData')

## MCMC
if (!file.exists('modMCMC/')) dir.create('modMCMC')

## ## the following chunk didn't work

## ## SF <- summary(Fit2)
## ## Var0 <- SF[['modVariance']]
## ## covIni <- SF[['cov.scaled']] * 2.4 ^ 2 / 2
## ## mcmc <- modMCMC(objective, c(pars, recursive = TRUE), 
## ##                 jump = covIni, var0 = Var0, wvar0 = 1)
## ## save(mcmc, file = 'modMCMC/mcmc.RData')

## mcmc3 <- modMCMC(objective, c(pars, recursive = TRUE) / 2, niter = 500,
##                  upper = pars.gs.range[['max']],
##                  lower = pars.gs.range[['min']])
## save(mcmc3, file = 'modMCMC/mcmc3.RData')
## mc3 <- as.mcmc(mcmc3[['pars']])
## pdf('modMCMC/mcmc3.pdf')
## plot(mcmc3, Full = TRUE)
## cumuplot(mc3)
## dev.off()
load('modMCMC/mcmc3.RData')
