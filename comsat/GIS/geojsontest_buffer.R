require(rgeos)
require(rgdal)
require(maptools)

comsatgeo <- readOGR('comsat.geojson', 'OGRGeoJSON')
geographical <- CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs')
utm33n <- CRS('+proj=utm +zone=33 +ellps=WGS84 +datum=WGS84 +units=m +no_defs')
comsat <- spTransform(comsatgeo, utm33n)

if (!file.exists('buffer_demo')) dir.create('buffer_demo')

getfetch <- function(pol, angle) {  ## angle in degrees clockwise
  polr <- elide(pol, rotate=angle)
  proj4string(polr) <- utm33n
  bb <- bbox(polr)
  xx <- as.list(ceiling(bb[1, 1]):floor(bb[1, 2]))
  ll <- lapply(xx, function(x) {
    Lines(list(Line(matrix(c(x, bb[2, 1], x, bb[2, 2]),
                           byrow=TRUE, ncol=2, nrow=2))),
          ID=as.character(x))
  })
  spl <- SpatialLines(ll, proj4string=CRS(proj4string(polr)))
  inters <- gIntersection(polr, spl, byid=TRUE)
  maxlength <- max(unlist(lapply(inters@lines, function(x) {
     max(unlist(lapply(x@Lines, function(y) {
       LineLength(y, sum=FALSE)
     })))
   })))
  return(maxlength)
}

for (ri in 1:nrow(comsat)) {
  thislake <- comsat[ri, ]
  thislake@data <- data.frame(thislake@data,
                              fetch0=getfetch(thislake, 0),
                              fetch30=getfetch(thislake, 30),
                              fetch60=getfetch(thislake, 60),
                              fetch90=getfetch(thislake, 90),
                              fetch120=getfetch(thislake, 120),
                              fetch150=getfetch(thislake, 150))
  name <- thislake@data[['comsat.Lake']]
  writeOGR(spTransform(thislake, geographical),
           sprintf('fetch/%s.geojson', name),
           'comsat', 'GeoJSON')
}

## for (ri in 1:nrow(comsat)) {
##   thislake <- comsat[ri, ]
##   buffer1 <- gBuffer(thislake, width=1000)
##   buffer1spdf <-
##     SpatialPolygonsDataFrame(buffer1, 
##                              data=data.frame(thislake@data, buffer=1000),
##                              match.ID=FALSE)
##   row.names(buffer1spdf@data) <- buffer1spdf@polygons[[1]]@ID
##   thislake@data <- data.frame(thislake@data, buffer=0)
##   thisbuffer <- spRbind(thislake, buffer1spdf)
##   name <- thislake@data[['comsat.Lake']]
##   writeOGR(spTransform(thisbuffer, geographical),
##            sprintf('buffer_demo/%s.geojson', name),
##            'comsat', 'GeoJSON')
## }
               
