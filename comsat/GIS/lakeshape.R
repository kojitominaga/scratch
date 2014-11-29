require(rgdal)
require(rgeos)

geographical <- CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs')

fennoscan <- readOGR('../../../../../GIS_DATA/FENOSCAN lakes',
                     'FENOSCAND_lakes')

comsattable <- read.table('../data/NSD/COMSAT 2011 lakes utf8.txt',
                          header=TRUE, encoding='utf-8', sep='\t')
coordinates(comsattable) <- c('Longitude', 'Latitude')
proj4string(comsattable) <- geographical
comsatutm33 <- spTransform(comsattable, CRS(proj4string(fennoscan)))

intersects <- gIntersects(fennoscan, comsatutm33, byid = TRUE)
ii <- apply(intersects, 1, function(x) {return((1:ncol(intersects))[x])})
comsat <- fennoscan[ii, ]
comsat@data <- data.frame(comsat=comsatutm33@data,
                          fennoscan=comsat@data)
writeOGR(spTransform(comsat, geographical), 'comsat.geojson', 'comsat', 'GeoJSON')
writeOGR(spTransform(comsat, geographical), 'comsat.kml', 'comsat', 'KML')
# readOGR('comsat.geojson', 'OGRGeoJSON')

writeOGR(spTransform(fennoscan, geographical), '200k.geojson', '200k', 'GeoJSON')
