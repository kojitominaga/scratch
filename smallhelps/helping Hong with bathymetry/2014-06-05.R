require(sp)
require(rgdal)
require(foreign)
require(maptools)

utm33n <- CRS('+proj=utm +zone=33 +ellps=WGS84 +datum=WGS84 +units=m +no_defs')

dirlist <- list.files('SwedishBathymetry')

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

firsttimemod <- TRUE
for (lakeid in dirlist) {
  dirname <- sprintf('SwedishBathymetry/%s', lakeid)
  
  if (file.exists(paste0(dirname, '/', lakeid, 'mod_id.shp'))) {
    p2 <- readOGR(dirname, paste0(lakeid, 'mod_id'))
    if (firsttime) {
      newmod <- p2
      firsttimemod <- FALSE
    } else {
      newmod <- rbind(new, p2, makeUniqueIDs = TRUE) # spRbind(new, p1)
    }
  }
}
writeOGR(newmod, 'SwedishBathymetry', 'merged_mod', 'ESRI Shapefile')
