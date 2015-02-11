plorequire(rgdal)
require(rgeos)
require(gstat)
require(raster)
## lakes <- readOGR('../../../../../GIS_DATA/FENOSCAN lakes', 'FENOSCAND_lakes')
bath <- readOGR('.', 'vatn_lnr_0003')
bath0 <- subset(bath, dypde == 0)
lcoordinates <- lapply(bath0@lines, function(x) x@Lines[[1]]@coords)
lPolygons <- lapply(lcoordinates, Polygon)
lPolygons[[9]]@hole <- FALSE
pols <- Polygons(lPolygons, 1)



points <- spsample(pols, n=10, type='random')


pol <- Polygons(apply(coordinates(bath0))

bath0pol <- SpatialPolygons(list(bath0))


buf <- gBuffer(bath0, width = 500)
whichlake <- gIntersects(lakes, buf, byid=TRUE)
lakesnearby <- lakes[c(whichlake), ]
thelake <- subset(lakesnearby, vatn_lnr == 3)  ## the number 3 is different for each lake
## > plot(thelake)
## > plot(bath, col='blue', add=TRUE)


## here 'bath' is the bathymetric contour lines
## 'thelake' is the lake polygon from FENOSCAN_lakes

## convert to points
bathpoints <- as(bath, "SpatialPointsDataFrame")

## get variogram/semivariogram
v <- variogram(dypde ~ 1, bathpoints, cutoff=500)

## create a variogram model
## v.fit0 <- fit.variogram(v, vgm(150, 'Exp', 400))
## avoid directly specifying numbers
vgm.initial <- vgm(max(v[['gamma']]), 'Exp', max(v[['dist']]))
v.fit <- fit.variogram(v, vgm.initial)
if (attr(v.fit, 'singular')) stop('singular fit') ## page 226
## check that warning does not happen


## targets to random points in the lake
randompoints <- spsample(thelake, n=10000, type='random')

# put some number for sparsing the polyline points. If the points are too close for the variogram model, it will raise an error. If too sparse (e.g., 10000) then the interpolation  will not be accurate. 


## kriging
k <- krige(dypde ~ 1,
           bathpoints[sample(1:nrow(bathpoints),
                             size=ceiling(nrow(bathpoints))/putsomenumber), ],
           ## need to take sparse numbers of points
           randompoints, v.fit,
           maxdist=400)
## hist(k[['var1.pred']])

## > colfactor <- floor(k[['var1.pred']])
## > plot(k, cex=(k[['var1.pred']] / max(k[['var1.pred']], rm.na=TRUE)), pch=19)
## > plot(k, cex=(k[['var1.pred']] / max(k[['var1.pred']], rm.na=TRUE)), pch=19)
## > str(colfactor)
##  num [1:1000] 0 24 NA 5 4 16 10 17 27 25 ...
## > unique(colfactor)
##  [1]  0 24 NA  5  4 16 10 17 27 25  9 26 15 31 22  7 21  2 19 11 14 36 12  8 20
## [26]  3 29 13  1 57 32 58 35 18 52 37 39 43 34 28 30 62  6 23 48 38 50 33 44 40
## [51] 46 47 42 49 -1 51 41 55 56
## > colfactor <- pmax(0, colfactor)
## > nfactors <- max(colfactor) + 1
## > nfactors
## [1] NA
## > nfactors <- max(colfactor, na.rm=TRUE) + 1
## > nfactors
## [1] 63
## > colours <- rainbow(nfactors)
## > plot(k, col=colours[colfactor+1])
## > plot(k, col=colours[colfactor+1], pch=19)
## > plot(k, col=colours[colfactor+1], pch=19, cex=0.1)
## > plot(k, col=colours[colfactor+1], pch=19, cex=0.3)
## > par(mfrow=c(1, 2))
## > plot(k, col=colours[colfactor+1], pch=19, cex=0.3)
## > plot(bath, col=rainbow(64)[floor(bath[['dypde']]) + 1])
## > 
