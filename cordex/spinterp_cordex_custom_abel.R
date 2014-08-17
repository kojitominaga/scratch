ncf <- commandArgs(trailingOnly=TRUE)[2]
orogncf <- commandArgs(trailingOnly=TRUE)[3]
fnp1 <- commandArgs(trailingOnly=TRUE)[4]
fnp2 <- commandArgs(trailingOnly=TRUE)[5]
fnv1 <- commandArgs(trailingOnly=TRUE)[6]
fnv2 <- commandArgs(trailingOnly=TRUE)[7]
varname <- commandArgs(trailingOnly=TRUE)[8]

## ncf <- 'ncAugustSoren/mrros_EUR-11_ICHEC-EC-EARTH_historical_r12i1p1_CLMcom-CCLM4-8-17_v1_mon_194912-195012.nc'
## orogncf <- 'ncAugustSoren/orog_EUR-11_ICHEC-EC-EARTH_historical_r0i0p0_CLMcom-CCLM4-8-17_v1_fx.nc'
## fnp1 <- 'mrros_194912-195012_pred_n1k.csv'
## fnp2 <- 'mrros_194912-195012_pred_regin.csv'
## fnv1 <- 'mrros_194912-195012_var_n1k.csv'
## fnv2 <- 'mrros_194912-195012_var_regin.csv'

dbglv <- 0 # debug.level

nlocal <- 400 # number of points 
cutoff <- 2e5 # max distance
ninterpmethods <- 9
nmetadata <- 33
boundaries <- c(15, 20, 25.8, 30, 35.2, 37.7, 42, 46, 53, 62, 71, 80, 90, 101)

require(sp)
require(gstat)
require(raster)
require(ncdf)
require(rgdal)
require(rgeos)

llCRS <- CRS('+proj=longlat +ellps=WGS84 +datum=WGS84')
utm33n <- CRS('+proj=utm +zone=33 +ellps=WGS84 +datum=WGS84 +units=m +no_defs')

orognc <- open.ncdf(orogncf)
orog <- get.var.ncdf(orognc, 'orog')
close.ncdf(orognc)

nc <- open.ncdf(ncf)
vall <- get.var.ncdf(nc, varname)
lon <- get.var.ncdf(nc, 'lon')
lat <- get.var.ncdf(nc, 'lat')
close.ncdf(nc)

include <- as.logical(scan('include'))

tabgeo <- data.frame(lon=c(lon), lat=c(lat), orog=c(orog))[include, ]
coordinates(tabgeo) <- c('lon', 'lat')
proj4string(tabgeo) <- llCRS
tab <- spTransform(tabgeo, utm33n)
target1 <- spTransform(readOGR('shp', 'n1k_elevation'), utm33n)
names(target1)[4] <- 'orog'
target2 <- spTransform(readOGR('shp', 'regin_elevation'), utm33n)
names(target2)[36] <- 'orog'

outputp1 <- matrix(NA, nrow=nrow(target1), ncol=dim(vall)[3])
outputp2 <- matrix(NA, nrow=nrow(target2), ncol=dim(vall)[3])
outputv1 <- matrix(NA, nrow=nrow(target1), ncol=dim(vall)[3])
outputv2 <- matrix(NA, nrow=nrow(target2), ncol=dim(vall)[3])

for (vi in 1:(dim(vall)[3])) {
  cat(sprintf('%s\n', vi))
  tabn <- tab
  tabn[['v']] <- c(vall[ , , vi])[include]
  tabn <- subset(tabn, !is.na(v))
  va <- variogram(v ~ orog, tabn, cutoff=cutoff)
  mg <- max(va[['gamma']])
  md <- max(va[['dist']]) 
  ## vf <- fit.variogram(va, vgm(mg, 'Lin', md),
  ##                     fit.sills=TRUE, fit.ranges=FALSE)
  vfe <- fit.variogram(va,
                       vgm(mg / 2, 'Sph', md * 0.25,
                           add.to = vgm(mg / 2, 'Sph', md * 0.50,
                             add.to = vgm(mg / 2, 'Exp', md,
                               add.to = vgm(mg / 2, 'Gau', md,
                                 add.to = vgm(mg / 2, 'Lin', md,
                                   mg / 2))))),
                       fit.sills = TRUE, fit.ranges = FALSE)
  ## k <- krige(v ~ orog, tabn, target1, vf, nmax=nlocal, maxdist=cutoff)
  ke1 <- krige(v ~ orog, tabn, target1, vfe, nmax=nlocal, maxdist=cutoff)
  ke2 <- krige(v ~ orog, tabn, target2, vfe, nmax=nlocal, maxdist=cutoff)
  outputp1[ , vi] <- ke1[['var1.pred']]
  outputp2[ , vi] <- ke2[['var1.pred']]
  outputv1[ , vi] <- ke1[['var1.var']]
  outputv2[ , vi] <- ke2[['var1.var']]
}
write.csv(outputp1, fnp1)
write.csv(outputp2, fnp2)
write.csv(outputv1, fnv1)
write.csv(outputv2, fnv2)




