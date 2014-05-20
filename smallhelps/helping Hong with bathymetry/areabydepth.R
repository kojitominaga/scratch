require(sp)
require(rgdal)
require(foreign)

utm33n <- CRS('+proj=utm +zone=33 +ellps=WGS84 +datum=WGS84 +units=m +no_defs')

lakenames <- list.files('SwedishBathymetry')]
paths <- paste0('SwedishBathymetry/', lakenames, '/', lakenames, 'mod.dbf')
dirs <- paste0('SwedishBathymetry/', lakenames)
layers <- paste0(lakenames, 'mod')

p.list <- list()

for (pi in 1:length(paths)) {
  dir <- dirs[pi]
  name <- lakenames[pi]
  layer <- layers[pi]
  if (nrow(read.dbf(paste0(dir, '/', layer, '.dbf'))) == 0) {
    next
  }
  p <- readOGR(dir, layer)
  p.utm33n <- spTransform(p, utm33n)
  p.list[[pi]] <- p.utm33n
  names(p.list)[pi] <- name
}

p.list.valid <- p.list[!unlist(lapply(p.list, function(x) {
  !(class(x) == 'SpatialPolygonsDataFrame')}))]

f2 <- function(P) { ## Polygons
  h <- unlist(lapply(P@Polygons, function(x) { x@hole }))
  a <- unlist(lapply(P@Polygons, function(x) { x@area }))
  sum(a * ifelse(h, -1, 1))  ## add if hole = FALSE, subtract if hole = TRUE
}


arealists <- lapply(p.list.valid, function(x) {
  unlist(lapply(x@polygons, f2))})
  
## am <- readOGR('SwedishBathymetry/0-0001', '0-0001mod')
## am_utm33n <- spTransform(a, utm33n)

sumarea <- unlist(lapply(arealists, sum))

suminterval <- list()
for (li in 1:length(p.list.valid)) {
  suminterval[[li]] <-
    tapply(arealists[[li]], p.list.valid[[li]]@data[['INTERVALL']], sum)
  names(suminterval)[li] <- names(arealists)[li]
}

fractionlist <- list()
for (li in 1:length(p.list.valid)) {
  fractions <- suminterval[[li]] / sumarea[li]
  intervals <- names(fractions)
  boundary1 <- unlist(lapply(strsplit(intervals, '-'), 
                             function(x) { as.numeric(x[1]) }))
  boundary2 <- unlist(lapply(strsplit(intervals, '-'),
                             function(x) { as.numeric(x[2]) }))
  dm <- (boundary1 + boundary2) / 2
  thisdf <- data.frame(lakeid=paste0('SW', names(arealists)[li]),
                       d1=boundary1,
                       d2=boundary2,
                       dm=dm,
                       area=suminterval[[li]],
                       fractionalarea=fractions
                       )
  thisdf <- thisdf[order(thisdf[['dm']]), ]
  thisdf <-
    data.frame(thisdf, 
               cumsumarea=rev(cumsum(rev(thisdf[['area']]))),
               cumsumfraction=rev(cumsum(rev(thisdf[['fractionalarea']]))),
               intervals.string=row.names(thisdf),
               oneminusZdmdivZmaxdm=1 - (thisdf[['dm']] / max(thisdf[['dm']]))
               )
  fractionlist[[li]] <- thisdf
  names(fractionlist)[li] <- names(arealists)[li]
}

out <- do.call(rbind, fractionlist)
write.csv(out, file = 'SwedishBathymetryCollated.csv', row.names = FALSE)

  
