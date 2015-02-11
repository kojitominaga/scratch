## usage: Rscript dephistory --args data/S.txt.gz "total ox. sulphur" 
## if changing years:
## - remove the file ppt.RData ; move all the .csv and .pdf files
## - change the line years <- years[c(28, 32)]  #######################
## - change the files names for 2 instances of write.csv()
## - run one variable; this should create new ppt.RData
## - do the rest of variables

require(sp)
require(gstat)
require(rgdal)
require(rgeos)

deppath <- commandArgs(trailingOnly = TRUE)[1]
vname <- commandArgs(trailingOnly = TRUE)[2]

## deppath <- 'data/S.txt.gz'
## vname <- "total ox. sulphur"
## deppath <- 'data/ppt.txt.gz'
## vname <- 'precipitation'

if (vname == 'precipitation') {
  doppt <- TRUE
} else {
  load('ppt 80.RData')
  doppt <- FALSE
}

emepgrid <- '+ellps=sphere +a=127.4 +e=0 +proj=stere +lat_0=90 +lon_0=-32 +lat_ts=60 +x_0=8 +y_0=110' ## http://www.emep.int/grid/index.html
wgs84 <- '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'
utm33n <- '+proj=utm +zone=33 +ellps=WGS84 +datum=WGS84 +units=m +no_defs'
## utm does not work with polar points! frame it to exclude polar points

emep <- read.table(deppath, skip = 2, header = FALSE, sep = ';')
names(emep) <- c('V1', 'year', 'V3', 'variable', 'i', 'j', 'unit', 'value')
if (doppt) {
  ppt <- read.table('data/ppt.txt.gz', skip = 2, header = FALSE, sep = ';')
  names(ppt) <- c('V1', 'year', 'V3', 'variable', 'i', 'j', 'unit', 'value')
}

years <- unique(emep[['year']])
## years <- years[c(28, 32)]  #######################
if (doppt) {
  vlistppt <- list()
} else {
  vlist <- list()
  vlist0 <- list()
}
deplist <- list()

for (yi in 1:length(years)) {
  y <- years[yi]
  cat(y) ; cat('\n')
  ysub <- subset(emep, (year == y) & (variable == vname))
  ysub[['ppt']] <- subset(ppt, (year == y))[['value']]
  coordinates(ysub) <- ~i + j
  proj4string(ysub) <- emepgrid
  subgeo <- spTransform(ysub, CRS(wgs84))
  framed <-
    (coordinates(subgeo)[, 1] > 0) & (coordinates(subgeo)[, 1] < 35) &
      (coordinates(subgeo)[ , 2] > 50) & (coordinates(subgeo)[ , 2] < 75)
  subgeof <- subgeo[framed, ]
  sub33n <- spTransform(subgeof, CRS(utm33n))
  print(summary(subgeof))
  deplist[[yi]] <- sub33n
  if (doppt) {
    vlistppt[[yi]] <- variogram(ppt ~ 1, sub33n)
  } else {
    vlist[[yi]] <- variogram(value ~ ppt, sub33n)
    vlist0[[yi]] <- variogram(value ~ 1, sub33n)
  }
}
if (doppt) {
  names(vlistppt) <- years
  fvlistppt <- list()
} else {
  names(vlist) <- years
  names(vlist0) <- years
  fvlist <- list()
  fvlist0 <- list()
}

if (!doppt) {
  pdf('vlist.pdf')
  for (yi in 1:length(years)) {
    print(plot(vlist[[yi]]))
  }
  dev.off()
  pdf('vlist0.pdf')
  for (yi in 1:length(years)) {
    print(plot(vlist0[[yi]]))
  }
  dev.off()
}


for (yi in 1:length(years)) {
  ## assuming linear variogram model, starting
  ## with initial slope at last distance
  ## check graphs that it did not reach partial sill
  if (doppt) {
    ## exponential model for precipitation 
    vppt <- vlistppt[[yi]]
    nppt <- nrow(vppt)
    v1ppt <- vgm(vppt[['gamma']][nppt] * 1.5, 'Exp', vppt[['dist']][nppt])
    fvlistppt[[yi]] <- fit.variogram(vppt, v1ppt)
  } else {
    v <- vlist[[yi]]
    v0 <- vlist0[[yi]]
    n <- nrow(v)
    n0 <- nrow(v0)
    if (vname == 'total red. nitrogen') {
      v1 <- vgm(v[['gamma']][n] * 1.5, 'Exp', v[['dist']][n])
      v10 <- vgm(v0[['gamma']][n] * 1.5, 'Exp', v0[['dist']][n])
    } else if (vname == 'dry red. nitrogen') {
      v1 <- vgm(v[['gamma']][n] * 1.5, 'Exp', v[['dist']][n])
      v10 <- vgm(v0[['gamma']][n] * 1.5, 'Exp', v0[['dist']][n])
    } else if (vname == 'wet red. nitrogen') {
      v1 <- vgm(v[['gamma']][n] * 1.5, 'Exp', v[['dist']][n])
      v10 <- vgm(v0[['gamma']][n] * 1.5, 'Exp', v0[['dist']][n])
    } else if (vname == 'dry ox. nitrogen') {
      v1 <- vgm(v[['gamma']][n] * 1.5, 'Exp', v[['dist']][n])
      v10 <- vgm(v0[['gamma']][n] * 1.5, 'Exp', v0[['dist']][n])
    } else {
      v1 <- vgm(v[['gamma']][n] / v[['dist']][n], 'Lin', 0)
      v10 <- vgm(v0[['gamma']][n] / v0[['dist']][n], 'Lin', 0)
    }
    fvlist[[yi]] <- fit.variogram(v, v1)
    fvlist0[[yi]] <- fit.variogram(v0, v10)
  }
}



if (doppt) {
  names(fvlistppt) <- years
  if (!file.exists('variograms ppt 80.pdf')) {
    pdf('variograms ppt 80.pdf')
    for (yi in 1:length(years)) {
      y <- years[yi]
      print(plot(vlistppt[[yi]], fvlistppt[[yi]],
                 ylab = sprintf('variogram %s', y)))
    }
    dev.off()
  }
} else {
  names(fvlist) <- years
  names(fvlist0) <- years
  pdf(sprintf('residual variograms %s by ppt 80.pdf', vname))
  for (yi in 1:length(years)) {
    y <- years[yi]
    print(plot(vlist[[yi]], fvlist[[yi]],
             ylab = sprintf('variogram %s', y)))
  }
  dev.off()
  pdf(sprintf('NON-residual variograms %s NOT by ppt 80.pdf', vname))
  for (yi in 1:length(years)) {
    y <- years[yi]
    print(plot(vlist0[[yi]], fvlist0[[yi]],
               ylab = sprintf('variogram %s', y)))
  }
  dev.off()
} 

n1k <- readOGR('../../../../GIS_DATA/Koji_GIS/catchments', 'nbf.sub')
n1kutm33n <- spTransform(n1k, CRS(utm33n))
n1kc <- gCentroid(n1kutm33n, byid = TRUE)
n1kcdf <- SpatialPointsDataFrame(n1kc, data = n1k@data)

if (doppt) {
  kpptlist <- list()
} else {
  kpolygonlist <- list()
  kpolygonlist0 <- list()
}

for (yi in 1:length(years)) {
  cat(yi) ; cat ('\n')
  y <- years[yi]
  ## renaming for ease in reading script
  ## use fv1 variogram model
  if (doppt) {
    catchpolygons <- n1kutm33n
    dep <- deplist[[yi]]
    kp <-
      krige(ppt ~ 1, dep, newdata = catchpolygons, model = fvlistppt[[yi]])
    kpptlist[[yi]] <- data.frame(var1.pred = kp@data[['var1.pred']],
                                 var1.var = kp@data[['var1.var']])
  } else {
    catchpolygons <- n1kutm33n
    catchpolygons@data <- data.frame(catchpolygons@data,
                                     ppt = kpptlist[[yi]][,1])
    catchpolygons0 <- catchpolygons
    dep <- deplist[[yi]]
    v <- vlist[[yi]]
    k2 <- krige(value ~ ppt, dep, newdata = catchpolygons, model = fvlist[[yi]])
    k20 <- krige(value ~ 1, dep, newdata = catchpolygons0, model = fvlist0[[yi]])
    kpolygonlist[[yi]] <- data.frame(k2[['var1.pred']], k2[['var1.var']])
    kpolygonlist0[[yi]] <- data.frame(k20[['var1.pred']], k20[['var1.var']])
    catchpolygons@data <- data.frame(catchpolygons@data,
                                     ppt = kpptlist[[yi]][[paste0('pred', '_', y)]])
    catchpolygons0@data <- data.frame(catchpolygons0@data,
                                     ppt = kpptlist[[yi]][[paste0('pred', '_', y)]])
  }
}

if (doppt) {
  names(kpptlist) <- years
  for (yi in 1:length(years)) {
    y <- years[yi]
    names(kpptlist[[yi]]) <- paste0(c('pred', 'var'), '_', y) 
  }
} else {
  names(kpolygonlist) <- years
  names(kpolygonlist0) <- years
  for (yi in 1:length(years)) {
    y <- years[yi]
    names(kpolygonlist[[yi]]) <- paste0(c('pred', 'var'), '_', y) 
    names(kpolygonlist0[[yi]]) <- paste0(c('pred', 'var'), '_', y) 
  }
}

if (doppt) {
  pptout <- n1kutm33n
  pptout@data <- do.call(cbind, list(pptout@data, kpptlist))
  print(summary(pptout))
  write.csv(pptout@data,
            file = sprintf('csv80/ppt all years.csv', vname))
  save(ppt, vlistppt, fvlistppt, kpptlist, file = 'ppt 80.RData')
} else {
  out <- n1kutm33n
  out@data <- do.call(cbind, list(out@data, kpolygonlist))
  print(summary(out))
  write.csv(out@data,
            file = sprintf('csv80/%s dep corrected by ppt all years.csv', vname))
  
  out <- n1kutm33n
  out@data <- do.call(cbind, list(out@data, kpolygonlist0))
  print(summary(out))
  write.csv(out@data,
            file = sprintf('csv80/%s dep NOT corrected by ppt all years.csv', vname))
}




