require(rgeos)
require(rgdal)
require(maptools)

comsatgeo <- readOGR('comsat.geojson', 'OGRGeoJSON')
geographical <- CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs')
utm33n <- CRS('+proj=utm +zone=33 +ellps=WGS84 +datum=WGS84 +units=m +no_defs')
comsat <- spTransform(comsatgeo, utm33n)

if (!file.exists('buffer_demo')) dir.create('buffer_demo')

for (ri in 1:nrow(comsat)) {
  thislake <- comsat[ri, ]
  buffer1 <- gBuffer(thislake, width=1000)
  buffer1spdf <-
    SpatialPolygonsDataFrame(buffer1, 
                             data=data.frame(thislake@data, buffer=1000),
                             match.ID=FALSE)
  row.names(buffer1spdf@data) <- buffer1spdf@polygons[[1]]@ID
  thislake@data <- data.frame(thislake@data, buffer=0)
  thisbuffer <- spRbind(thislake, buffer1spdf)
  writeOGR(spTransform(thisbuffer, geographical),
           sprintf('buffer_demo/%s.geojson', ri),
           'comsat', 'GeoJSON')
}

  
                             
