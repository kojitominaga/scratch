require(sp)

source('readorog.R')
## will use llCRS

comsat <- read.table('comsat/NSD/COMSAT 2011 lakes.txt', sep = '\t', header = TRUE)
names(comsat)[which(names(comsat) == "Altitude")] <- 'orog'
coordinates(comsat) <- c('Longitude', 'Latitude')
## promotes orodf to SpatialPointsDataFrame
proj4string(comsat) <- llCRS

comsatwraplon <- c(4, 20)
comsatwraplat <- c(58, 65)


