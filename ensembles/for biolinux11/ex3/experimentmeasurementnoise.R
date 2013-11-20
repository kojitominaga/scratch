source('flakedream2.R')

if (!file.exists('meta/')) dir.create('meta')

load('meta/dcs.RData')
load('meta/defaults.RData')
## dcsshort <- dcs[c(1:21, 22:71, 122:171)]
savepathsmeasurementnoiseshort <-
  sprintf('dreammeasurementnoise/%s.RData', names(dcsshort))
## defaultsshort <- defaults[c(1:21, 22:71, 122:171)]
## save(dcsshort, file = 'meta/dcsshort.RData')
## save(savepathsshort, file = 'meta/savepathsshort.RData')
## save(defaultsshort, file = 'meta/defaultsshort.RData')
load('meta/dcsshort.RData')
load('meta/savepathsmeasurementnoiseshort.RData')
load('meta/defaultsshort.RData')


flakedreamreadydepth <- function(pars, depths) {
  cat(pars)
  cat('\n')
  thepars <- c(20, c(pars), 2)
  return(flakedreamready(thepars, depths))
}
parlistdepth <- parlist['fetch'] ## still a list with length 1

if (!file.exists('dreammeasurementnoise/')) dir.create('dreammeasurementnoise')  

control1 <- list(ndim = 1,
                 nseq = 4,
                 maxtime = 60 * 4,  # seconds
                 parallel = "multicore")

parlistdepth <- parlist['fetch'] ## still a list with length 1

## for (dci in 1:length(dcsshort)) {
for (dci in c(1, 3, 21, 22, 72)) {
  dc <- dcsshort[[dci]]
  default <- defaultsshort[[dci]]
  ## still targeting the defaults made with the original weather
  dcname <- names(dcsshort)[dci]
  savepath <- savepathsmeasurementnoiseshort[dci]
  cat('\n\n')
  cat(c(dcname, dc))
  cat('\n\n')
  measurement1 <- list(data = c(default) + 0.5)
  d <- dream(flakedreamreadydepth, "calc.rmse", parlistdepth,
             FUN.pars = list(depths = dc),
             control = control1,
             measurement = measurement1)
  print(d)
  print(summary(d))
  save(d, file = savepath)
}  
       
