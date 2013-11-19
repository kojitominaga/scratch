require(dream)
source('flakeinitialise.R')
theparameters <- parameters
theoptic <- optic

flakedreamready <- function(pars, depths) {
  parameters <- theparameters
  optic <- theoptic
  parameters[['depth_w']] <- pars[1]
  parameters[['fetch']] <- pars[2]
  optic[['extincoef_water']] <- pars[3]
  result <- runflake(ts.input, parameters, init.state, optic)[-initiali, ]
  fieldseason <- (165 * m + 1):(210 * m)
  tds <- TemperatureAtDepths(result[fieldseason, ], parameters, depths)
  tdsdaily <- apply(tds, 2, tapply, INDEX = rep(166:210, each = m), mean)
  return(c(tdsdaily))
}

pars.gs.range <- data.frame(
  row.names = c('depth', 'fetch', 'atten'),
  min = c(20, 300, 2),
  max = c(20, 10000, 2)
  )
parlist <- as.list(data.frame(t(as.matrix(pars.gs.range))))
if (!file.exists('dream/')) dir.create('dream')


