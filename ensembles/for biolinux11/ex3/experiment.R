source('flakedream2.R')
require(caTools) ## needed for the function combs

## ## the following chunk has random issue so seed it, or do not repeat

## singular <- as.list(0:20) ## depth combinations
## names(singular) <- sprintf('singular%02d', 0:20)
## choose5size <- choose(21, 5)
## pick100 <- sample(1:choose5size, 100)
## choose5 <- as.list(as.data.frame(t(combs(0:20, 5)[pick100, ])))
## names(choose5) <- sprintf('choosefive%03d', 1:100)
## choose10size <- choose(21, 10)
## pick100 <- sample(1:choose10size, 100)
## choose10 <- as.list(as.data.frame(t(combs(0:20, 10)[pick100, ])))
## names(choose10) <- sprintf('chooseten%03d', 1:100)
## dcs <- c(singular, choose5, choose10)

if (!file.exists('meta/')) dir.create('meta')
## f = file('meta/depthcombinations.txt', open = 'w')
## for (li in 1:length(dcs)) {
##   cat(names(dcs)[li], file = f)
##   cat(' ', file = f)
##   cat(paste(dcs[[li]]), file = f)
##   cat('\n', file = f)
## }
## close(f)
## save(dcs, file = 'meta/dcs.RData')
load('meta/dcs.RData')

## ## this can be improved because we don't need to redo the FLake run
## ## but I'm lazy for the moment
## defaults <- lapply(dcs,
##                    function(x) flakedreamready(c(pars, recursive = TRUE), x))
## save(defaults, file = 'meta/defaults.RData')
load('meta/defaults.RData')

control1 <- list(ndim = 1,
                 nseq = 4,
                 maxtime = 60,  # seconds
                 parallel = "multicore")

if (!file.exists('dream/')) dir.create('dream')

savepaths <- sprintf('dream/%s.RData', names(dcs))

flakedreamreadydepth <- function(pars, depths) {
  cat(pars)
  cat('\n')
  thepars <- c(20, c(pars), 2)
  return(flakedreamready(thepars, depths))
}
parlistdepth <- parlist['fetch'] ## still a list with length 1

## for (dci in 1:length(dcs)) {
for (dci in 1:3) {
  dc <- dcs[[dci]]
  default <- defaults[[dci]]
  dcname <- names(dcs)[dci]
  savepath <- savepaths[dci]
  cat('\n\n')
  cat(c(dcname, dc))
  cat('\n\n')
  measurement1 <- list(data = c(default))
  d <- dream(flakedreamreadydepth, "calc.rmse", parlistdepth,
             FUN.pars = list(depths = dc),
             control = control1,
             measurement = measurement1)
  print(d)
  print(summary(d))
  save(d, file = savepath)
}  
       
