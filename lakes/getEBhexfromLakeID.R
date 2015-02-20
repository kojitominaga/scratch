require(foreign)
require(rgdal)
require(rgeos)

dbffn <- '../../../../GIS_DATA/fenoscand_lakes/v.0.2/ecco-biwa_lakes_v.0.2.dbf'
dsn <- '../../../../GIS_DATA/fenoscand_lakes/v.0.2'
layer <- 'ecco-biwa_lakes_v.0.2'

lakes <- readOGR(dsn, layer)

goran <- read.csv('Feb2015GoranList0.csv')
names(goran)[1] <- 'lake_id'


merged <- merge(goran, lakes@data, by='lake_id', sort=FALSE)
## removing the duplicate Vanern 54 is wrong 55 is correct
merged <- subset(merged, EBint != 664068)

ebhlist <- merged[['EBhex']]

## WRONG sub <- subset(lakes, EBhex %in% ebhlist)

## CORRECT
ii <- match(ebhlist, lakes[['EBhex']])
sub <- lakes[ii, ]


ctr <- gCentroid(sub, byid=TRUE)

out <- data.frame(lake_id=merged[['lake_id']],
                  name=as.character(merged[['Name']]),
                  ebhex=merged[['EBhex']],
                  ebint=merged[['EBint']],
                  area=merged[['Area']],
                  depth=merged[['Depth']],
                  secchi=merged[['Secchi']],
                  longitude=coordinates(ctr)[ , 1],
                  latitude=coordinates(ctr)[ , 2])
write.csv(out, file='Feb2015GoranList.csv', row.names=FALSE)

                  
