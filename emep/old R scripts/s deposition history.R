require(sp)
require(gstat)
require(rgdal)
require(rgeos)

emepgrid <- '+ellps=sphere +a=127.4 +e=0 +proj=stere +lat_0=90 +lon_0=-32 +lat_ts=60 +x_0=8 +y_0=110' ## http://www.emep.int/grid/index.html
wgs84 <- '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'
utm33n <- '+proj=utm +zone=33 +ellps=WGS84 +datum=WGS84 +units=m +no_defs'
## utm does not work with polar points! frame it to exclude polar points

emep <- read.table('data/S.txt.gz', skip = 2, header = FALSE, sep = ';')
names(emep) <- c('V1', 'year', 'V3', 'variable', 'i', 'j', 'unit', 'value')

years <- unique(emep[['year']])
vlist <- list()
sdeplist <- list()

for (yi in 1:length(years)) {
  y <- years[yi]
  cat(y) ; cat('\n')
  ysub <- subset(emep, (year == y) & (variable == 'total ox. sulphur'))
  coordinates(ysub) <- ~i + j
  proj4string(ysub) <- emepgrid
  subgeo <- spTransform(ysub, CRS(wgs84))
  framed <-
    (coordinates(subgeo)[, 1] > 0) & (coordinates(subgeo)[, 1] < 35) &
      (coordinates(subgeo)[ , 2] > 50) & (coordinates(subgeo)[ , 2] < 75)
  subgeof <- subgeo[framed, ]
  sub33n <- spTransform(subgeof, CRS(utm33n))
  sdeplist[[yi]] <- sub33n
  vlist[[yi]] <- variogram(value ~ 1, sub33n)
}
names(vlist) <- years

pdf('variograms (many pages).pdf')
for (yi in 1:length(years)) {
  y <- years[yi]
  print(plot(vlist[[yi]], ylab = sprintf('variogram %s', y)))
}
dev.off()

fvlist <- list()
for (yi in 1:length(years)) {
  v <- vlist[[yi]]
  n <- nrow(v)
  ## assuming linear variogram model, starting
  ## with initial slope at last distance
  ## check graphs that it did not reach partial sill
  v1 <- vgm(v[['gamma']][n] / v[['dist']][n], 'Lin', 0)
  fvlist[[yi]] <- fit.variogram(v, v1)
}
names(fvlist) <- years

n1k <- readOGR('catchments', 'N1000_poly_Final0210Copy')
n1kutm33n <- spTransform(n1k, CRS(utm33n))
n1kc <- gCentroid(n1kutm33n, byid = TRUE)
n1kcdf <- SpatialPointsDataFrame(n1kc, data = n1k@data)

kpointlist <- list()
kpolygonlist <- list()

for (yi in 1:length(years)) {
  cat(yi) ; cat ('\n')
  v <- vlist[[yi]]
  ## renaming for ease in reading script
  catchpoints <- n1kcdf
  catchpolygons <- n1kutm33n
  sdep <- sdeplist[[yi]]
  ## use fv1 variogram model

  k1 <- krige(value ~ 1, sdep, newdata = catchpoints, model = fvlist[[yi]])
  kpointlist[[yi]] <- data.frame(k1[['var1.pred']], k1[['var1.var']])
  
  k2 <- krige(value ~ 1, sdep, newdata = catchpolygons, model = fvlist[[yi]])
  kpolygonlist[[yi]] <- data.frame(k2[['var1.pred']], k2[['var1.var']])
}
names(kpointlist) <- years
names(kpolygonlist) <- years
for (yi in 1:length(years)) {
  y <- years[yi]
  names(kpointlist[[yi]]) <- paste0(c('pred', 'var'), '_', y)
  names(kpolygonlist[[yi]]) <- paste0(c('pred', 'var'), '_', y) 
}

catchpoints@data <- do.call(cbind,
                            list(catchpoints@data, kpointlist))
write.csv(catchpoints@data, file = 'csv/s dep all years centroid.csv')
writeOGR(catchpoints, 'spatialite', 's dep all years centroid', 'SQLite')
catchpolygons@data <- do.call(cbind,
                              list(catchpolygons@data, kpolygonlist))
write.csv(catchpolygons@data, file = 'csv/s dep all years.csv')  



