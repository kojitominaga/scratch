require(rgdal)
require(rgeos)
require(sp)


main <- readOGR('shapefiles', 'FENOSCAN_lakes_Sweden2')
## the database as reference
ctr <- readOGR('shapefiles', 'centres')
## centres of the lakes to be identified
pol <- readOGR('shapefiles', 'merged_mod4')

stats <-
  read.csv('../helping Hong with bathymetry/SW lake basin slope parameters.csv')

lid <- rep(NA, times = nrow(ctr))
for (ci in 1:10) {
# for (ci in 1:nrow(ctr)) {
  cat('unidentified number: ') ; cat(ci) ; cat('\n')
  ct <- ctr[ci, ]
  found <- FALSE
  mi <- 0
  while ((!found) & (mi < nrow(main))) {
    mi <- mi + 1
    if (mi %% 1000 == 0) {
      cat(mi) ; cat(' ')
    }
    found <- gIntersects(ct, main[mi, ])
  }
  if (found) {
    lid[ci] <- mi
  } else {
    lid[ci] <- NA
  }
  cat('\n----\n')
}

mainc <- gCentroid(main, byid = TRUE)
maincspdf <- SpatialPointsDataFrame(mainc, data = main@data)
writeOGR(maincspdf, 'shapefiles', 'FENOSCAN_lakes_Sweden2_centroids',
         'ESRI Shapefile')


distances <- gDistance(ctr, mainc, byid = TRUE)
## save(distances, file = 'distances.RData')  ## 300 MB
## load('distances.RData')

names <- ctr[['lakeid']]
names2 <- unlist(lapply(strsplit(as.character(pol[['B']]),
                                 split = '_', fixed = TRUE),
                        function(x) x[1]))
names2 <- unlist(lapply(strsplit(names2, split = 'S'), function(x) x[2]))
names3 <- main[['lake_id']]
areas <- main[['F_AREA']]
near10ids <- list()
for (ci in 1:nrow(ctr)) {
  cat('unidentified number: ') ; cat(ci) ; cat('\n')
  d <- distances[ , ci]
  ord <- order(d)
  near10ids[[ci]] <- ord[1:10]
}
near10areas <- lapply(near10ids, function(x) areas[x])
unknownareas <- stats[['surfacearea']]
near10areasp <- list()
for (ci in 1:nrow(ctr)) {
  near10areasp[[ci]] <- pmin(abs(near10areas[[ci]] / unknownareas[[ci]] - 1), 1)
}
write.table(data.frame(near10areasp), file = 'absolute difference.csv',
            sep = ',',
            col.names = ctr[['lakeid']], row.names = FALSE)


pdf('test.pdf', height = 7, width = 11)
par(mfrow = c(5, 12), mar = rep(0, times = 4))
for (ci in 1:435) {
  name <- names[ci]
  plot(0, 0, type = 'n',
       xlim = c(0, 1), ylim = c(0, 1), frame.plot = FALSE, axes = FALSE)
  text(0.1, 0.9, ci)
  text(0.7, 0.9 , name)
  text(0.5, seq(from = 0.8, to = 0.1, length.out = 10), cex = 0.5,
       paste(1:10, ':', near10ids[[ci]]))
  pols <- pol['AREA'][names2 == name, ]
  print(plot(pols))
  ## # trellis.focus('toplevel') ## has coordinate system [0,1] x [0,1]
  ## panel.text(0.5, 0.2, "Hello, world", cex = 1.2, font = 2)
  ## # trellis.unfocus()
#   ylab = sprintf('%s : %s', ci, names[ci])))
  for (ri in 1:10) {
    print(plot(main['F_AREA'][near10ids[[ci]][ri], ]))
    ## trellis.focus("toplevel") ## has coordinate system [0,1] x [0,1]
    ## panel.text(0.5, 0.2, "Hello, world", cex = 1.2, font = 2)
    ## trellis.unfocus()
    ##      ## xlab = sprintf('%s : %s',
    ##      ##              round(near10areasp[[ci]][ri], digits = 2),
    ##      ##              names3[near10ids[[ci]][ri]]
    ##      ##              ))
    ## print()
  }
}
dev.off()



  
