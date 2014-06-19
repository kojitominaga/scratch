## Rscript extractSeNorge.R --args year

require(raster)
require(rgdal)
require(RSAGA)
require(sp)
require(rgeos)

year <- as.integer(commandArgs(trailingOnly = TRUE)[1])
cat('year is ') ; cat(sprintf('%s', year)) ; cat('\n')


dir <- sprintf('/work/users/kojito/senorge/gwb_ascii_%s', year)
dates <- seq(from=as.Date(sprintf('%s-01-01', year)),
             to=as.Date(ifelse(year == 2014,
               sprintf('%s-06-10', year),
               sprintf('%s-12-31', year))),
             by='day')

nbf.sub <- readOGR('catchments', 'nbf.sub')
nbf.sub.data <- slot(nbf.sub, 'data')

corina <- readOGR('CORINE2006-20140618-79dc87',
                  'CORINE2006_Norge_79dc87_411_412')
corina <- spTransform(corina, CRS(proj4string(nbf.sub)))

bogs <- numeric(length = nrow(nbf.sub))
for (i in 1:nrow(nbf.sub)) {
  cat(i) ; cat('\n')
  intersection <- gIntersection(nbf.sub[i, ], corina)
  if (is.null(intersection)) {
    bogs[i] <- 0
  } else {
    bogs[i] <- gArea(intersection) / gArea(nbf.sub[i, ])
  }
}
df <- nbf.sub@data
df[['bogs']] <- bogs
write.csv(df, file = 'bogs.csv')


    
