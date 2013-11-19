require(dream)
source('flakeFME.R')
theparameters <- parameters
theoptic <- optic

flakedreamready <- function(pars) {
  parameters <- theparameters
  optic <- theoptic
  parameters[['depth_w']] <- pars[1]
  parameters[['fetch']] <- pars[2]
  optic[['extincoef_water']] <- pars[3]
  result <- data.frame(ts.input,
                       runflake(ts.input, parameters, init.state, optic)
                       )[-initiali, ]
  surfaceT <- tapply(result[['T_wML']],
                     rep(1:n0, each = m, length.out = nrow(result)),
                     mean)
  return(matrix(surfaceT, ncol = 1, dimnames = list(NULL, 'twml')))
}

parlist <- as.list(data.frame(t(as.matrix(pars.gs.range))))
if (!file.exists('dream/')) dir.create('dream')

control1 <- list(ndim = 3,
                 nseq = 4,
                 maxtime = 60 * 10)
measurement1 <- list(data = c(default))
dream1 <- dream(flakedreamready, "calc.rmse", parlist, control = control1,
                measurement = measurement1)
save(dream, file = 'dream/dream1.RData')
pdf('dream/dream1.pdf')
plot(dream1)
dev.off()

control2 <- list(ndim = 3,
                 nseq = 8,
                 maxtime = 60 * 10,
                 NULL)
                 # parallel = "multicore")
measurement1 <- list(data = c(default))
dream2 <- dream(flakedreamready, "calc.rmse", parlist, control = control2,
                measurement = measurement1)
save(dream, file = 'dream/dream2.RData')
pdf('dream/dream2.pdf')
plot(dream2)
dev.off()

control3 <- list(ndim = 3,
                 nseq = 10,
                 maxtime = 60 * 20,
                 NULL)
                 # parallel = "multicore")
measurement1 <- list(data = c(default))
dream3 <- dream(flakedreamready, "calc.rmse", parlist, control = control3,
                measurement = measurement1)
save(dream, file = 'dream/dream3.RData')
pdf('dream/dream3.pdf')
plot(dream3)
dev.off()
dev.off()

control4 <- list(ndim = 3,
                 nseq = 4,
                 maxtime = 60 * 20,
                 NULL)
                 # parallel = "multicore")
measurement1 <- list(data = c(default))
dream4 <- dream(flakedreamready, "calc.rmse", parlist, control = control4,
                measurement = measurement1)
save(dream, file = 'dream/dream4.RData')
pdf('dream/dream4.pdf')
plot(dream4)
dev.off()
dev.off()


control5 <- list(ndim = 3,
                 nseq = 4,
                 maxtime = 60 * 20,
                 NULL)
                 parallel = "multicore")
measurement1 <- list(data = c(default))
dream5 <- dream(flakedreamready, "calc.rmse", parlist, control = control5,
                measurement = measurement1)
save(dream, file = 'dream/dream4.RData')
pdf('dream/dream5.pdf')
plot(dream5)
dev.off()
dev.off()

