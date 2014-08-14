require(rgeos)
require(rgdal)
require(maptools)

comsatgeo <- readOGR('comsat.geojson', 'OGRGeoJSON')
geographical <- CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs')
utm33n <- CRS('+proj=utm +zone=33 +ellps=WGS84 +datum=WGS84 +units=m +no_defs')
comsat <- spTransform(comsatgeo, utm33n)

if (!file.exists('buffer_demo')) dir.create('buffer_demo')

getfetch <- function(pol, angle, n=100) {  ## angle in degrees clockwise
  polr <- elide(pol, rotate=angle)
  proj4string(polr) <- utm33n
  bb <- bbox(polr)
  xx <- as.list(seq(from=bb[1, 1], to=bb[1, 2], length.out=102)[2:101])
  ll <- lapply(xx, function(x) {
    Lines(list(Line(matrix(c(x, bb[2, 1], x, bb[2, 2]),
                           byrow=TRUE, ncol=2, nrow=2))),
          ID=as.character(x))
  })
  spl <- SpatialLines(ll, proj4string=CRS(proj4string(polr)))
  inters <- gIntersection(polr, spl, byid=TRUE)
  maxlengths <- unlist(lapply(inters@lines, function(x) {
     max(unlist(lapply(x@Lines, function(y) {
       LineLength(y, sum=FALSE)
     })))
   }))
  maxlength <- max(maxlengths)
  maxline <- ll[[which(maxlengths == max(maxlengths))]]
  return(list(maxlength=maxlength, maxline=maxline))
}

for (ri in 1:nrow(comsat)) {
  thislake <- comsat[ri, ]
  fetch0 <- getfetch(thislake, 0)
  fetch30 <- getfetch(thislake, 330)
  fetch60 <- getfetch(thislake, 300)
  fetch90 <- getfetch(thislake, 270)
  fetch120 <- getfetch(thislake, 240)
  fetch150 <- getfetch(thislake, 210)
  thislake@data <- data.frame(fetch0=round(fetch0[['maxlength']]),
                              fetch30=round(fetch30[['maxlength']]),
                              fetch60=round(fetch60[['maxlength']]),
                              fetch90=round(fetch90[['maxlength']]),
                              fetch120=round(fetch120[['maxlength']]),
                              fetch150=round(fetch150[['maxlength']]),
                              thislake@data)
  name <- thislake@data[['comsat.Lake']]
  writeOGR(spTransform(thislake, geographical),
           sprintf('fetch/%s.geojson', name),
           'comsat', 'GeoJSON')
}

  ## spl <- rbind(SpatialLines(list(fetch0[['maxline']])),
  ##                elide(SpatialLines(list(fetch30[['maxline']])),
  ##                      rotate=30),
  ##                elide(SpatialLines(list(fetch60[['maxline']])),
  ##                      rotate=60),
  ##                elide(SpatialLines(list(fetch90[['maxline']])),
  ##                      rotate=90),
  ##                elide(SpatialLines(list(fetch120[['maxline']])),
  ##                      rotate=120),
  ##                elide(SpatialLines(list(fetch150[['maxline']])),
  ##                      rotate=150))
  ## proj4string(spl) <- utm33n
  ## sldf <-
  ##   SpatialLinesDataFrame(spl,
  ##                         data=data.frame(fetchangle=c(0, 30, 60,
  ##                                           90, 120, 150)),
  ##                         match.ID=FALSE)
  ## writeOGR(spTransform(sldf, geographical),
  ##          sprintf('fetch/%s_fetchlines.geojson', name),
  ##          'comsat', 'GeoJSON')


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
               
