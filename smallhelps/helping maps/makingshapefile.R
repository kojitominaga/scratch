require(sp)
## install.packages('sp')
require(rgdal)
require(rgeos)



names <- paste('location', 1:10)
## names <- c('LSI', etc.)

longitude <- c(20 + 23 / 60,
               19 + 43 / 60,
               -102 - 43 / 60,
               11 + 30 / 60,
               -21 - 39 / 60,
               10 + 42 / 60,
               10 + 48 / 60,
               10 + 9 / 60,
               2 + 6 / 60,
               2 + 3 / 60)
latitude <- c(80 + 50 / 60,
              80 + 30 / 60,
              79,
              78 + 56 / 60,
              74 + 30 / 60,
              59 + 50 / 60,
              59 + 40 / 60,
              56 + 8 / 60,
              48 + 51 / 60,
              43)
zone <- rep(c('high arctic', 'temperate'), each = 5)

df <- data.frame(name = names,
                 longitude = longitude,
                 latitude = latitude,
                 zone = zone)

coordinates(df) <- ~ longitude + latitude
proj4string(df) <- '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'
writeOGR(df, '.', 'sample sites', 'ESRI Shapefile')

           
