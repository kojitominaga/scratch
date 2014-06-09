setwd ("C:/Hong Yang/Work01/SWEDEN/BathymetryMaps/bathymetry.tar/bathymetry/helping Hong with bathymetry/helping Hong with bathymetry-20140604")
getwd()

require(sp)
require(rgdal)
require(foreign)
require(maptools)
require(rgeos)
require(adehabitat)
require(ade4)

utm33n <- CRS('+proj=utm +zone=33 +ellps=WGS84 +datum=WGS84 +units=m +no_defs')

dirlist.extra <- list.files('SwedishBathymetry')
deletei <- grep('.', dirlist.extra, fixed=TRUE)
dirlist <- dirlist.extra[-deletei]

for (lakeid in dirlist) {
  dirname <- sprintf('SwedishBathymetry/%s', lakeid)
  
  if (!file.exists(paste0(dirname, '/', lakeid, '_id.shp'))) {
    dbf <- read.dbf(paste0(dirname, '/', lakeid, '.dbf'))
    if ((nrow(dbf) > 0) & (ncol(dbf) == 5)) {
      original <- readOGR(dirname, lakeid)
      original.utm <- spTransform(original, utm33n)
      df <- original.utm@data
      names(df)[3] <- 'A'
      names(df)[4] <- 'A_ID'
      df[['B']] <- paste0('S', lakeid, '_', df[['A']])
      df[['B_ID']] <- paste0('S', lakeid, '_', df[['A_ID']])
      original.utm@data <- df
      writeOGR(original.utm, dirname, paste0(lakeid, '_id'), 'ESRI Shapefile')
    }
  }
  if (!file.exists(paste0(dirname, '/', lakeid, 'mod_id.shp'))) {
    dbf <- read.dbf(paste0(dirname, '/', lakeid, 'mod.dbf'))
    if ((nrow(dbf) > 0) & (ncol(dbf) == 5)) {
      originalmod <- readOGR(dirname, sprintf('%smod', lakeid))
      originalmod.utm <- spTransform(originalmod, utm33n)
      df <- originalmod.utm@data
      names(df)[3] <- 'A'
      names(df)[4] <- 'A_ID'
      df[['B']] <- paste0('S', lakeid, '_', df[['A']])
      df[['B_ID']] <- paste0('S', lakeid, '_', df[['A_ID']])
      originalmod.utm@data <- df
      writeOGR(originalmod.utm, dirname, paste0(lakeid, 'mod_id'), 'ESRI Shapefile')
    }
  }
}

### now merging
firsttime <- TRUE
for (lakeid in dirlist) {
  dirname <- sprintf('SwedishBathymetry/%s', lakeid)
  
  if (file.exists(paste0(dirname, '/', lakeid, '_id.shp'))) {
    p1 <- readOGR(dirname, paste0(lakeid, '_id'))
    if (firsttime) {
      new <- p1
      firsttime <- FALSE
    } else {
      new <- rbind(new, p1, makeUniqueIDs = TRUE) # spRbind(new, p1)
    }
  }
}
writeOGR(new, 'SwedishBathymetry', 'merged', 'ESRI Shapefile')

for (lakeid in dirlist) {
  dirname <- sprintf('SwedishBathymetry/%s', lakeid) 
  filelist <- list.files(dirname)
  ii <- grep('mod_id', filelist, fixed=TRUE)
  fnames2delete <- filelist[ii]
  fpaths2delete <- paste0(dirname, '/', fnames2delete)
  unlink(fpaths2delete)
}
 
firsttimemod <- TRUE
for (lakeid in dirlist) {
#   if (lakeid == '3-1315') { next }
#   if (lakeid == '3-1327') { next }
#  if (lakeid == '2-0085') { next }
#  if (as.numeric(sub('-', '', lakeid)) < 36331) { next }
  dirname <- sprintf('SwedishBathymetry/%s', lakeid)
 
  if (file.exists(paste0(dirname, '/', lakeid, 'mod_id.shp'))) {
    cat(dirname) ; cat('\n')
    p2 <- readOGR(dirname, paste0(lakeid, 'mod_id'))
    outerarea <- p2[p2@data[['A_ID']] == 1, ]
    p <- outerarea@polygons[[1]]@Polygons  
    p3 <- outerarea
    p3@polygons[[1]]@Polygons <- p[!unlist(lapply(p, function(x) x @ hole))]  
    centre <- gCentroid(p3)
    centreSPDF <- SpatialPointsDataFrame(centre, 
                       data = data.frame(lakeid = lakeid))
    if (firsttimemod) {
      newmod <- p2
      # shores <- p3
      centres <- centreSPDF
      firsttimemod <- FALSE
    } else {
      newmod <- rbind(newmod, p2, makeUniqueIDs = TRUE) 
      # spRbind(new, p1)
      # shores <- rbind(shores, p3, makeUniqueIDs = TRUE)
      centres <- rbind(centres, centreSPDF)
    }
  }
}
writeOGR(newmod, 'SwedishBathymetry', 'merged_mod4', 'ESRI Shapefile')
writeOGR(centres, 'SwedishBathymetry', 'centres', 'ESRI Shapefile')
# writeOGR(shores, 'SwedishBathymetry', 'shores', 'ESRI Shapefile')



library(maptools)

SWbathymap3 <- readOGR ("SwedishBathymetry", "merged_mod3")
Fenoscanlake <- readOGR ("SwedishBathymetry", "FENOSCAND_lakes")

overlaySW <-over (SWbathymap3, Fenoscanlake, returnList=TRUE)
write.csv(overlaySW, file = 'overlaySW.csv', row.names = FALSE)

#buffer zone, package adehabitat
bufferzone<-buffer.line(gc[,2:3], sa, 300)

# clip the DEM
plot (r)
plot (ne, add=TRUE)
rr <- mask (r, ne)
plot (rr)

# calculate the slope
