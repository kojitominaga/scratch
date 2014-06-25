require(sp)
require(gstat)
require(rgdal)
require(rgeos)

emepgrid <- '+ellps=sphere +a=127.4 +e=0 +proj=stere +lat_0=90 +lon_0=-32 +lat_ts=60 +x_0=8 +y_0=110' ## http://www.emep.int/grid/index.html
wgs84 <- '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'
utm33n <- '+proj=utm +zone=33 +ellps=WGS84 +datum=WGS84 +units=m +no_defs'
## utm does not work with polar points! frame it to exclude polar points

emep <- read.table('data/webdabData135929.txt.gz', skip = 2,
                   header = FALSE, sep = ';')
names(emep) <- c('V1', 'year', 'V3', 'variable', 'i', 'j', 'unit', 'value')
ts95 <- subset(emep, (year == 1995) & (variable == 'total ox. sulphur'))
coordinates(ts95) <- ~i + j
proj4string(ts95) <- emepgrid
ts95geo <- spTransform(ts95, CRS(wgs84))

framed <-
  (coordinates(ts95geo)[, 1] > 0) & (coordinates(ts95geo)[, 1] < 35) &
  (coordinates(ts95geo)[ , 2] > 50) & (coordinates(ts95geo)[ , 2] < 75)
ts95geof <- ts95geo[framed, ]
ts95NOutm33n <- spTransform(ts95geof, CRS(utm33n))
writeOGR(ts95NOutm33n, 'other shapefiles', 'total S Norway-frame UTM33N',
         'ESRI Shapefile')

v <- variogram(value ~ 1, ts95NOutm33n)
v1 <- vgm(0.275, 'Lin', 0)
fv1 <- fit.variogram(v, v1)

n1k <- readOGR('catchments', 'N1000_poly_Final0210Copy')
n1kutm33n <- spTransform(n1k, CRS(utm33n))
n1kc <- gCentroid(n1kutm33n, byid = TRUE)
n1kcdf <- SpatialPointsDataFrame(n1kc, data = n1k@data)
writeOGR(n1kcdf, 'other shapefiles', 'centroid n1k UTM33N', 'ESRI Shapefile')

## renaming for ease in reading script
catchpoints <- n1kcdf
catchpolygons <- n1kutm33n
sdep <- ts95NOutm33n
## use fv1 variogram model

k1 <- krige(value ~ 1, sdep, newdata = catchpoints, model = fv1)
catchpoints@data <- data.frame(catchpoints@data, k1@data)
writeOGR(catchpoints, 'other shapefiles',
         'total S dep EMEP 1995 careless KT centroids',
         'ESRI Shapefile')
write.csv(catchpoints@data,
          file = 'csv/total S dep EMEP 1995 careless KT centroids.csv')

k2 <- krige(value ~ 1, sdep, newdata = catchpolygons, model = fv1)
catchpolygons@data <- data.frame(catchpolygons@data, k2@data)
writeOGR(catchpolygons, 'other shapefiles',
         'total S dep EMEP 1995 careless KT',
         'ESRI Shapefile')
write.csv(catchpolygons@data,
          file = 'csv/total S dep EMEP 1995 careless KT.csv')






