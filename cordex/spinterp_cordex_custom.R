dbglv <- 0 # debug.level

nlocal <- 400 # number of points 
cutoff <- 200 # max distance
ninterpmethods <- 9
nmetadata <- 33
boundaries <- c(15, 20, 25.8, 30, 35.2, 37.7, 42, 46, 53, 62, 71, 80, 90, 101)

require(intervals)
require(sp)
require(gstat)
require(raster)
require(ncdf)
require(rgdal)
require(rgeos)

llCRS <- CRS('+proj=longlat +ellps=WGS84 +datum=WGS84')
utm33n <- CRS('+proj=utm +zone=33 +ellps=WGS84 +datum=WGS84 +units=m +no_defs')
utm32n <- CRS('+proj=utm +zone=32 +ellps=WGS84 +datum=WGS84 +units=m +no_defs')


target1 <- readOGR('shp', 'N1000_poly_Final0210Copy')
proj4string(target1) <- utm32n
target1 <- spTransform(target1, utm33n)
target2 <- spTransform(readOGR('shp', 'Regin_coast_clip_33N_Project'), utm33n)

## Norway <- gUnaryUnion(target2)
## NorwayBuffer <- gBuffer(Norway, width=10000)
## writeOGR(SpatialPolygonsDataFrame(NorwayBuffer,
##                                   data = data.frame(country='Norway'),
##                                   match.ID=FALSE),
##          'shp', 'NorwayBuffer', 'ESRI Shapefile')


orogncf <- 'ncAugustSoren/orog_EUR-11_ICHEC-EC-EARTH_historical_r0i0p0_CLMcom-CCLM4-8-17_v1_fx.nc'
orognc <- open.ncdf(orogncf)
orog <- get.var.ncdf(orognc, 'orog')


ncf <- 'ncAugustSoren/mrros_EUR-11_ICHEC-EC-EARTH_historical_r12i1p1_CLMcom-CCLM4-8-17_v1_mon_194912-195012.nc'
nc <- open.ncdf(ncf)
v <- get.var.ncdf(nc, 'mrros')
lon <- get.var.ncdf(nc, 'lon')
lat <- get.var.ncdf(nc, 'lat')

vtest <- v[ , , 1]
tabgeo <- data.frame(v=c(vtest), lon=c(lon), lat=c(lat), orog=c(orog))
coordinates(tabgeo) <- c('lon', 'lat')
proj4string(tabgeo) <- llCRS
tab <- spTransform(tabgeo, utm33n)

## NorwayBuffer <- spTransform(readOGR('shp', 'NorwayBuffer'), utm33n)
## include <- gContains(NorwayBuffer, tab, byid=TRUE)
## write.table(ifelse(c(include), 1, 0), file='include', col.names=FALSE, row.names=FALSE)
include <- as.logical(scan('include'))
tabn <- tab[c(include), ]



dem <- raster('../../../../GIS_DATA/Koji_GIS/dem/NO_SE_DEM25m_250m.tif') #,
              # proj4string = CRS("+init=EPSG:32633"))

target1e <- extract(dem, target1, small=TRUE, fun=mean, na.rm=TRUE, sp=TRUE)
writeOGR(target1e, 'shp', 'n1k_elevation', 'ESRI Shapefile')
target2e <- extract(dem, target2, small=TRUE, fun=mean, na.rm=TRUE, sp=TRUE)
writeOGR(target2e, 'shp', 'regin_elevation', 'ESRI Shapefile')

target1 <- readOGR('shp', 'n1k_elevation')
target2 <- readOGR('shp', 'regin_elevation')

v <- variogram(v ~ orog, tabn, cutoff=200)

mg <- max(v[['gamma']])
md <- max(v[['dist']]) 
vf <- fit.variogram(v, vgm(mg, 'Lin', md),
                    fit.sills=TRUE, fit.ranges=FALSE)
vfe <- fit.variogram(v,
                     vgm(mg / 2, 'Sph', md * 0.25,
                         add.to = vgm(mg / 2, 'Sph', md * 0.50,
                           add.to = vgm(mg / 2, 'Exp', md,
                             add.to = vgm(mg / 2, 'Gau', md,
                               add.to = vgm(mg / 2, 'Lin', md,
                                 mg / 2))))),
                     fit.sills = TRUE, fit.ranges = FALSE)

k <- krige(v ~ orog, tabn, target1, vf, nmax=200, cutoff=200)
ke <- krige(v ~ orog, tabn, target1, vfe, nmax=200, cutoff=200)




