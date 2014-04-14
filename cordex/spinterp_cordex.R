## usage: Rscript spinterp_cordex.R --args
##          geogdir nctxtgzpath outdir x(nlon) y(nlat) llon llat lalt

nlocal <- 50
ncutoff <- 100
ninterpmethods <- 9
nmetadata <- 33

cat('====\n====\n====\n====\nThis is Rscript\n')
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat('current working directory is:\n')
cat(getwd())
cat('\n====\n====\n====\n====\n')

geogdir <- commandArgs(trailingOnly = TRUE)[2]
cat(sprintf('[R] geogdir is %s\n', varname))
nctxtgzpath <- commandArgs(trailingOnly = TRUE)[3]
cat(sprintf('[R] nctxtgzpath is %s\n', year))
outdir <- commandArgs(trailingOnly = TRUE)[4]
cat(sprintf('[R] outdir is %s\n', year))
nx <- as.numeric(commandArgs(trailingOnly = TRUE)[5])
ny <- as.numeric(commandArgs(trailingOnly = TRUE)[6])
cat(sprintf('[R] shape is (%s, %s)', nx, ny))
llon <- as.numeric(commandArgs(trailingOnly = TRUE)[7])
llat <- as.numerid(commandArgs(trailingOnly = TRUE)[8])
lalt <- as.numeric(commandArgs(trailingOnly = TRUE)[9])
cat(sprintf('[R] longitude: %s, latitude: %s, altitude %s', lon, lat, alt))

require(intervals)
require(sp)
require(gstat)
## require(intervals, lib.loc = 'R')
## require(sp, lib.loc = 'R')
## require(gstat, lib.loc = 'R')

llCRS <- CRS('+proj=longlat +ellps=WGS84 +datum=WGS84')

lon <- scan(paste0(geogdir, 'longitude.txt.bz2'), quiet = TRUE)
lat <- scan(paste0(geogdir, 'latitude.txt.bz2'), quiet = TRUE)
alt <- scan(paste0(geogdir, 'altitude.txt.bz2'), quiet = TRUE)
x <- rep(1:nx, times = ny)
y <- rep(1:ny, each = nx)
orogdf <- data.frame(x, y, lat, lon, orog = alt)

require(gstat)
## require(gstat, lib.loc = 'R')

newloc <- data.frame(lon = llon, lat = llat, orog = lalt)
coordinates(newloc) <- c('lon', 'lat')
proj4string(newloc) <- llCRS

## read raw data
raw <- scan(nctxtgzpath, quiet = TRUE)
n <- len(raw) / nrow(orogdf)

interpolated <- matrix(nrow = n, ncol = ninterpmethods)
metadata <- matrix(nrow = n, ncol = nmetadata)

for (i in 1:n) {
  vi <- raw[(1:(nx * ny)) + (i - 1) * (nx * ny)]
  r <- data.frame(orogdf, v = vi)
  coordinates(r) <- c('lon', 'lat')
  proj4string(r) <- llCRS

  ranks <- rank(spDistsN1(r, newloc, longlat = TRUE))
  lh <- length(unique(r[['v']][ranks <= 5])) == 1 ## locally homogeneous
  homog <- ifelse(lh, r[['v']][ranks == 1], NA)
  ## 1a: nearest value
  i1a <- r[['v']][ranks == 1]
  ## 1b: mean of nearest four
  i1b <- ifelse(lh, homog, mean(r[['v']][ranks <= 4]))
  ## 1c: triangular 2D linear interpolation
  if (lh) {
    i1c <- homog
  } else {
    cx <- coordinates(newloc)[1, 1]
    cy <- coordinates(newloc)[1, 2]
    n1 <- r[ranks == 1, ]
    n1x <- coordinates(n1)[1, 1]
    n1y <- coordinates(n1)[1, 2]
    n2 <- r[ranks == 2, ]
    n2x <- coordinates(n2)[1, 1]
    n2y <- coordinates(n2)[1, 2]
    n3 <- r[ranks == 3, ]
    n3x <- coordinates(n3)[1, 1]
    n3y <- coordinates(n3)[1, 2]
    ## now say,
    ## p1|n2(x, y) - n1(x, y)| +
    ## p2|n3(x, y) - n1(x, y)| = c(x, y)
    p2 <-
      ((cy - n1y) * (n2x - n1x) /
       (n2y - n1y) - (cx - n1x)) /
         ((n3y - n1y) * (n2x - n1x) /
          (n2y - n1y) - (n3x - n1x))
    p1 <- ((cx - n1x) - p2 * (n3x - n1x)) / (n2x - n1x)
    ## p1a <- ((cy - n1y) - p2 * (n3y - n1y)) / (n2y - n1y)
    ## p1a should be the same as p1
    out <- n1[['v']] +
      p1 * (n2[['v']] - n1[['v']]) +
        p2 * (n3[['v']] - n1[['v']])
    attr(out, "names") <- NULL                
    i3c <- out
  }
  rsub <- r[ranks <= ncutoff, ]
  v3 <- ifelse(lh, NA, variogram(v ~ 1, rsub, cutoff = ncutoff))
  v3o <- ifelse(lh, NA, variogram(v ~ orog, rsub, cutoff = ncutoff))
  mg <- ifelse(lh, NA, max(v3[['gamma']]))
  mgo <- ifelse(lh, NA, max(v3o[['gamma']]))
  md <- ifelse(lh, NA, max(v3[['dist']]))
  mdo <- ifelse(lh, NA, max(v3o[['dist']]))
  vfl3 <- ifelse(lh, NA, fit.variogram(v3, vgm(mg, 'Lin', md),
                                       fit.sills = TRUE, fit.ranges = FALSE))
  vfl3o <- ifelse(lh, NA, fit.variogram(v3o, vgm(mgo, 'Lin', mdo),
                                        fit.sills = TRUE, fit.ranges = FALSE))
  vfe3 <- ifelse(lh, NA,
                 fit.variogram(v3,
                               vgm(mg / 2, 'Sph', md * 0.5,
                                   add.to = vgm(mg / 2, 'Sph', md * 0.75,
                                     add.to = vgm(mg / 2, 'Exp', md,
                                       add.to = vgm(mg / 2, 'Gau', md,
                                         add.to = vgm(mg / 2, 'Lin', md,
                                           mg / 2))))),
                               fit.sills = TRUE, fit.ranges = FALSE))
  vfe3o <- ifelse(lh, NA,
                  fit.variogram(v3o,
                                vgm(mgo / 2, 'Sph', mdo * 0.5,
                                    add.to = vgm(mgo / 2, 'Sph', mdo * 0.75,
                                      add.to = vgm(mgo / 2, 'Exp', mdo,
                                        add.to = vgm(mgo / 2, 'Gau', mdo,
                                          add.to = vgm(mgo / 2, 'Lin', mdo,
                                            mgo / 2))))),
                                fit.sills = TRUE, fit.ranges = FALSE))
  ## 3an* : inverse distance
  k3an <- ifelse(lh, NA, krige(v ~ 1, rsub, newloc, nmax = nlocal))
  i3an <- ifelse(lh, homog, k3an[['var1.pred']])
  i3an.var <- ifelse(lh, NA, k3an[['var1.var']])
  ## 3ao* : inverse distance with weighting by orog
  k3ao <- ifelse(lh, NA, krige(v ~ orog, rsub, newloc, nmax = nlocal))
  i3ao <- ifelse(lh, homog, k3ao[['var1.pred']])
  i3ao.var <- ifelse(lh, NA, k3ao[['var1.var']])
  ## 3bn* : kriging (linear variogram model), ordinary
  k3bn <- ifelse(lh, NA, krige(v ~ 1, rsub, newloc, vfl3, nmax = nlocal))
  i3bn <- ifelse(lh, homog, k3bn[['var1.pred']])
  i3bn.var <- ifelse(lh, NA, k3bn[['var1.var']])
  ## 3bo* : kriging (linear variogram model), universal
  k3bo <- ifelse(lh, NA, krige(v ~ orog, rsub, newloc, vfl3o, nmax = nlocal))
  i3bo <- ifelse(lh, homog, k3bo[['var1.pred']])
  i3bo.var <- ifelse(lh, NA, k3bo[['var1.var']])
  ## 3cn* : kriging (complex variogram model), ordinary
  k3cn <- ifelse(lh, NA, krige(v ~ 1, rsub, newloc, vfe3, nmax = nlocal))
  i3cn <- ifelse(lh, homog, k3cn[['var1.pred']])
  i3cn.var <- ifelse(lh, NA, k3cn[['var1.var']])
  ## 3co* : kriging (complex variogram model), universal
  k3co <- ifelse(lh, NA, krige(v ~ orog, rsub, newloc, vfe3o, nmax = nlocal))
  i3co <- ifelse(lh, homog, k3co[['var1.pred']])
  i3co.var <- ifelse(lh, NA, k3co[['var1.var']])

  interpolated[i, ] <- c(i1a, i1b, i1c, i3an, i3ao, i3bn, i3bo, i3cn, i3co)
  metadata[i, ] <-
    c(lh * 1, mg, mgo, md, mdo,
      round(ifelse(lh, NA, vfl3[['psill']]) / mg, digits = 3),
      round(ifelse(lh, NA, vfl3o[['psill']]) / mgo, digits = 3),
      round(ifelse(rep(lh, times = 6),
                   rep(NA, times = 6),
                   vfe3[['psill']]) / mg, digits = 3), ## 6 elements
      round(ifelse(rep(lh, times = 6),
                   rep(NA, times = 6),
                   vfe3o[['psill']]) / mgo, digits = 3), ## 6 elements
      ifelse(locallyhomog3[[lakei]], NA, attr(vfl3[[lakei]], 'SSErr')),
      ifelse(locallyhomog3[[lakei]], NA, attr(vfl3o[[lakei]], 'SSErr')),
      ifelse(locallyhomog3[[lakei]], NA, attr(vfe3[[lakei]], 'SSErr')),
      ifelse(locallyhomog3[[lakei]], NA, attr(vfe3o[[lakei]], 'SSErr')),
      ifelse(locallyhomog3[[lakei]], NA,
             sqrt(attr(vfl3[[lakei]], 'SSErr') /
                  nrow(vfl3[[lakei]])) / maxgamma3[[lakei]]),
      ifelse(locallyhomog3[[lakei]], NA,
             sqrt(attr(vfl3o[[lakei]], 'SSErr') /
                  nrow(vfl3o[[lakei]])) / maxgamma3o[[lakei]]),
      ifelse(locallyhomog3[[lakei]], NA,
             sqrt(attr(vfe3[[lakei]], 'SSErr') /
                  nrow(vfe3[[lakei]])) / maxgamma3[[lakei]]),
      ifelse(locallyhomog3[[lakei]], NA,
             sqrt(attr(vfe3o[[lakei]], 'SSErr') /
                  nrow(vfe3o[[lakei]])) / maxgamma3o[[lakei]]),
      i3an.var[lakei],
      i3ao.var[lakei],
      i3bn.var[lakei],
      i3bo.var[lakei],
      i3cn.var[lakei],
      i3co.var[lakei])

  

  

if (grep(',', nis)) {
  nis <- as.integer(strsplit(nis, ',')[[1]])
} else {
  nis <- int(nis)
}
nna <- length(nis)
print(nis)
print(nna)

testingflag <- FALSE
rawpaths <- commandArgs(trailingOnly = TRUE)[5]
print(rawpaths)
if (length(grep(',', rawpaths)) > 0) {
  print('debug1')
  rawpaths <- strsplit(rawpaths, ',')[[1]]
  nnb <- length(rawpaths)
} else if (length(grep('.txt.gz', rawpaths)) > 0) {
  print('debug2')
  testingflag <- TRUE
  xx <- strsplit(rawpaths, '/', fixed = TRUE)[[1]]
  ra <- as.integer(strsplit(strsplit(xx[length(xx)],
                                     '.', fixed = TRUE)[[1]][1],
                            '-', fixed = TRUE)[[1]])
  nnb <- ra[2] - ra[1] + 1
} else {
  print('debug3')
  nnb <- 1
}
print('debug4')
print(rawpaths)
print(nnb)

if (nna != nnb) {
  stop('check your argument length')
} else {
  nn <- nna
}


ncfn2 <- strsplit(ncfn, '.nc')[[1]][1]

signifdigit <- switch(varname,
                      'ta_2m' = 2,
                      'pr' = 8,
                      'psl' = 2,
                      'rss' = 9,
                      'rls' = 3,
                      'wss_10m' = 3,
                      'wfds_10m' = 1,
                      'hur_2m' = 2,
                      'albedo' = 3,
                      'ps' = 2,
                      'ts_0m' = 2,
                      'clt' = 4)

cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- R libraries\n')
require(intervals, lib.loc = 'R')
require(sp, lib.loc = 'R')
require(gstat, lib.loc = 'R')
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- done\n')

nx = 248
ny = 400
## below x (lon, 248) moves faster than y (lat, 400)

cat('====\n====\n')

cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- reading NORA10_11km_lat.txt.bz2\n')
lat = scan('NORA10_11km_lat.txt.bz2')
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- done\n')

cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- reading NORA10_11km_lon.txt.bz2\n')
lon = scan('NORA10_11km_lon.txt.bz2')
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- done\n')

cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- reading NORA10_11km_orog.txt.bz2\n')
orograw = scan('NORA10_11km_orog.txt.bz2')
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- done\n')

cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- gstat operations\n')
x = rep(1:nx, times = ny)
y = rep(1:ny, each = nx)
llCRS <- CRS('+proj=longlat +ellps=WGS84 +datum=WGS84')
orogdf = data.frame(x, y, lat, lon, orograw)
coordinates(orogdf) <- c('lon', 'lat')
## promotes orodf to SpatialPointsDataFrame
proj4string(orogdf) <- llCRS
oroglat <- orogdf@coords[, 2]
oroglon <- orogdf@coords[, 1]
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- done\n')

if (!('temp' %in% list.files('.'))) dir.create('temp')
if (!('interpolated' %in% list.files('.'))) dir.create('interpolated')

## ndays <- sum(grepl(nora10,
##                    list.files(sprintf('temp/%s/%s/', varname, year)))
##              ) ## index starts with 0


cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- R libraries (second time)\n')
require(gstat, lib.loc = 'R') ## for some reason I have to call this again
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- done\n')

cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- reading the locations .csv file\n')
lakes <- read.csv(locationsfn)
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- done\n')

coordinates(lakes) <- c('longitude', 'latitude')
proj4string(lakes) <- llCRS

nlocal <- 50
ncutoff <- 100

nlakes <- nrow(lakes)

ninterpmethods <- 9
interpolated <- lapply(1:nlakes, function(x) rep(NA, times = ninterpmethods))

nmetadata <- 33
metadata <- lapply(1:nlakes, function(x) rep(NA, times = nmetadata))


if (testingflag) {
  cat('====\n====\n')
  cat(format(Sys.time(), "%a %b %d %X %Y"))
  cat(' --- reading a .txt.gz file\n')
  rawdata <- scan(rawpaths, quiet = TRUE)
  cat(format(Sys.time(), "%a %b %d %X %Y"))
  cat(' --- reading done\n')
  cat('====\n====\n')
}

####### looping for individual interpolation #######
for (theindex in 1:nn) {

cat('==================\n')
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- starting new i in main loop now\n')

if (!testingflag) {
  rawpath <- rawpaths[theindex]
}

ni <- nis[theindex]



####### not indenting for now

if (testingflag) {
  n10raw <- rawdata[(1:(248 * 400)) + ((theindex - 1) * 248 * 400)]
} else {
  n10raw <- scan(rawpath, quiet = TRUE)
}
n10df <- data.frame(lat, lon, v = n10raw, orog = orograw)
coordinates(n10df) <- c('lon', 'lat')
## promotes orodf to SpatialPointsDataFrame
proj4string(n10df) <- llCRS

## primer: ranks for distances from NORA10 points to each lake
ranks <- lapply(as.list(1:nlakes),
                function(lakei) {
                  rank(spDistsN1(n10df, lakes[lakei,], longlat = TRUE))
                })

## if the nearest 5 has the same value:
##    i1a, i1b, i1c, i3an, i3ao, i3bn, i3bo, i3cn, i3co 
## will have the same value as the estimate (i1a is the same anyway).
## first three will be just about saving computation time
## (numerically will be the same), but the rest can fail when kriging
## so it's important to avoid it.
## NEW!! actually scope 2 can get completely homogeneous (e.g., rss)
## completelyhomog2 <- (length(unique(n10pan[['v']])) == 1)
## homog2 <- unique(n10pan[['v']])
locallyhomog3 <-
  lapply(as.list(1:nlakes),
         function(lakei) {
           length(unique(n10df[['v']][ranks[[lakei]] <= 5])) == 1
         })
homog3 <- lapply(as.list(1:nlakes),
                 function(lakei) {
                   ifelse(locallyhomog3[[lakei]],
                          n10df[['v']][ranks[[lakei]] == 1], NA)
                 })
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- ')
cat(sprintf('[[%s %s %s: %s out %s locally homogeneous.]]\n',
            varname, year, ni,
            sum(unlist(locallyhomog3)),
            length(locallyhomog3)))

## interpolation type 1 "simple"
## 1a: nearest value
i1a <-
  unlist(lapply(as.list(1:nlakes),
                function(lakei) {
                  n10df[['v']][ranks[[lakei]] == 1]
                }))
## 1b: mean of nearest four
i1b <-
  unlist(lapply(as.list(1:nlakes),
                function(lakei) {
                  if (locallyhomog3[[lakei]]) {
                    out <- homog3[[lakei]]
                  } else {
                    out <- mean(n10df[['v']][ranks[[lakei]] <= 4])
                  }
                  return(out)
                }))
## 1c: triangular 2D linear interpolation
i1c <-
  unlist(lapply(as.list(1:nlakes),
                function(lakei) {
                  if (locallyhomog3[[lakei]]) {
                    out <- homog3[[lakei]]
                  } else {
                    r <- ranks[[lakei]]
                    cx <- coordinates(lakes[lakei, ])[1, 1]
                    cy <- coordinates(lakes[lakei, ])[1, 2]
                    n1 <- n10df[r == 1, ]
                    n1x <- coordinates(n1)[1, 1]
                    n1y <- coordinates(n1)[1, 2]
                    n2 <- n10df[r == 2, ]
                    n2x <- coordinates(n2)[1, 1]
                    n2y <- coordinates(n2)[1, 2]
                    n3 <- n10df[r == 3, ]
                    n3x <- coordinates(n3)[1, 1]
                    n3y <- coordinates(n3)[1, 2]
                    ## now say,
                    ## p1|n2(x, y) - n1(x, y)| +
                    ## p2|n3(x, y) - n1(x, y)| = c(x, y)
                    p2 <-
                      ((cy - n1y) * (n2x - n1x) /
                       (n2y - n1y) - (cx - n1x)) /
                         ((n3y - n1y) * (n2x - n1x) /
                          (n2y - n1y) - (n3x - n1x))
                    p1 <- ((cx - n1x) - p2 * (n3x - n1x)) / (n2x - n1x)
                    ## p1a <- ((cy - n1y) - p2 * (n3y - n1y)) / (n2y - n1y)
                    ## p1a should be the same as p1
                    out <- n1[['v']] +
                      p1 * (n2[['v']] - n1[['v']]) +
                        p2 * (n3[['v']] - n1[['v']])
                    attr(out, "names") <- NULL
                  }
                  return(out)
                }))

## scope 3 variogram
n10sub <- lapply(as.list(1:nlakes),
                 function(lakei) {
                   return(n10df[ranks[[lakei]] <= ncutoff, ])
                 })
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- starting sample variograms\n')
v3 <- lapply(as.list(1:nlakes),
             function(lakei) {
               if (locallyhomog3[[lakei]]) {
                 out <- NA
               } else {
                 out <- variogram(v ~ 1, n10sub[[lakei]], cutoff = ncutoff)
               }
               return <- out
             })
v3o <- lapply(as.list(1:nlakes),
              function(lakei) {
                if (locallyhomog3[[lakei]]) {
                  out <- NA
                } else {
                  out <- variogram(v ~ orog, n10sub[[lakei]], cutoff = ncutoff)
                }
                return <- out
              })
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- done sample variograms\n')

## fitted variograms
maxgamma3 <- lapply(as.list(1:nlakes),
                    function(lakei) {
                      if (locallyhomog3[[lakei]]) {
                        out <- NA
                      } else {
                          out <- max(v3[[lakei]][['gamma']])
                        }
                      return(out)
                    })
maxgamma3o <- lapply(as.list(1:nlakes),
                     function(lakei) {
                       if (locallyhomog3[[lakei]]) {
                         out <- NA
                       } else {
                         out <- max(v3o[[lakei]][['gamma']])
                       }
                       return(out)
                     })
maxdist3 <- lapply(as.list(1:nlakes),
                   function(lakei) {
                     if (locallyhomog3[[lakei]]) {
                       out <- NA
                     } else {
                       out <- max(v3[[lakei]][['dist']])
                     }
                        return(out)
                   })
maxdist3o <- lapply(as.list(1:nlakes),
                    function(lakei) {
                      if (locallyhomog3[[lakei]]) {
                        out <- NA
                      } else {
                        out <- max(v3o[[lakei]][['dist']])
                      }
                      return(out)
                    })
vfl3 <- lapply(as.list(1:nlakes),
               function(lakei) {
                 if (locallyhomog3[[lakei]]) {
                   out <- NA
                 } else {
                   out <-
                     fit.variogram(v3[[lakei]],
                                   vgm(maxgamma3[[lakei]],
                                       'Lin', maxdist3[[lakei]]),
                                   fit.sills = TRUE, fit.ranges = FALSE)
                 }
                 return(out)
               })
vfl3o <- lapply(as.list(1:nlakes),
                function(lakei) {
                  if (locallyhomog3[[lakei]]) {
                    out <- NA
                  } else {
                    out <-
                      fit.variogram(v3o[[lakei]],
                                    vgm(maxgamma3o[[lakei]],
                                        'Lin', maxdist3o[[lakei]]),
                                    fit.sills = TRUE, fit.ranges = FALSE)
                  }
                  return(out)
                })
vfe3 <-
  lapply(as.list(1:nlakes),
         function(lakei) {
           if (locallyhomog3[[lakei]]) {
             out <- NA
           } else {
             out <-
               fit.variogram(v3[[lakei]],
                             vgm(maxgamma3[[lakei]] / 2,
                                 'Sph', maxdist3[[lakei]] * 0.5,
                                 add.to = vgm(maxgamma3[[lakei]] / 2,
                                   'Sph', maxdist3[[lakei]] * 0.75, 
                                   add.to = vgm(maxgamma3[[lakei]] / 2,
                                     'Exp', maxdist3[[lakei]],
                                     add.to = vgm(maxgamma3[[lakei]] / 2,
                                       'Gau', maxdist3[[lakei]],
                                       add.to = vgm(maxgamma3[[lakei]] / 2,
                                         'Lin', maxdist3[[lakei]],
                                         maxgamma3[[lakei]] / 2))))),
                             fit.sills = TRUE, fit.ranges = FALSE)
           }
           return(out)
         })
vfe3o <-
    lapply(as.list(1:nlakes),
           function(lakei) {
             if (locallyhomog3[[lakei]]) {
               out <- NA
             } else {
               out <-
                 fit.variogram(v3o[[lakei]],
                               vgm(maxgamma3o[[lakei]] / 2,
                                   'Sph', maxdist3o[[lakei]] * 0.5,
                                   add.to = vgm(maxgamma3o[[lakei]] / 2,
                                     'Sph', maxdist3o[[lakei]] * 0.75, 
                                     add.to = vgm(maxgamma3o[[lakei]] / 2,
                                       'Exp', maxdist3o[[lakei]],
                                       add.to = vgm(maxgamma3o[[lakei]] / 2,
                                         'Gau', maxdist3o[[lakei]],
                                         add.to = vgm(maxgamma3o[[lakei]] / 2,
                                           'Lin', maxdist3o[[lakei]],
                                           maxgamma3o[[lakei]] / 2))))),
                               fit.sills = TRUE, fit.ranges = FALSE)
             }
             return(out)
           })
## 3an* : inverse distance
k3an <-
  lapply(as.list(1:nlakes),
           function(lakei) {
             if (locallyhomog3[[lakei]]) {
               out <- NA
             } else {
               out <- krige(v ~ 1, n10sub[[lakei]], lakes[lakei, ],
                            nmax = nlocal)
             }
             return(out)
           })
i3an <- unlist(lapply(as.list(1:nlakes),
                      function(lakei) {
                        if (locallyhomog3[[lakei]]) {
                          out <- homog3[[lakei]]
                        } else {
                          out <- k3an[[lakei]][['var1.pred']]
                        }
                        return(out)
                      }))
i3an.var <- unlist(lapply(as.list(1:nlakes),
                          function(lakei) {
                            if (locallyhomog3[[lakei]]) {
                              out <- NA
                            } else {
                              out <- k3an[[lakei]][['var1.var']]
                            }
                            return(out)
                          }))
## 3ao* : inverse distance with weighting by orog
k3ao <-
  lapply(as.list(1:nlakes),
         function(lakei) {
           if (locallyhomog3[[lakei]]) {
             out <- NA
           } else {
             out <- krige(v ~ orog, n10sub[[lakei]], lakes[lakei, ],
                          nmax = nlocal)
           }
           return(out)
         })
i3ao <- unlist(lapply(as.list(1:nlakes),
                      function(lakei) {
                        if (locallyhomog3[[lakei]]) {
                          out <- homog3[[lakei]]
                        } else {
                          out <- k3ao[[lakei]][['var1.pred']]
                        }
                        return(out)
                      }))
i3ao.var <- unlist(lapply(as.list(1:nlakes),
                          function(lakei) {
                            if (locallyhomog3[[lakei]]) {
                              out <- NA
                            } else {
                              out <- k3ao[[lakei]][['var1.var']]
                            }
                            return(out)
                          }))
## 3bn* : kriging (linear variogram model), ordinary
k3bn <-
  lapply(as.list(1:nlakes),
         function(lakei) {
           if (locallyhomog3[[lakei]]) {
             out <- NA
           } else {
             out <- krige(v ~ 1, n10sub[[lakei]], lakes[lakei, ],
                          vfl3[[lakei]], nmax = nlocal)
           }
           return(out)
         })
i3bn <- unlist(lapply(as.list(1:nlakes),
                      function(lakei) {
                        if (locallyhomog3[[lakei]]) {
                          out <- homog3[[lakei]]
                        } else {
                          out <- k3bn[[lakei]][['var1.pred']]
                        }
                        return(out)
                      }))
i3bn.var <- unlist(lapply(as.list(1:nlakes),
                          function(lakei) {
                            if (locallyhomog3[[lakei]]) {
                              out <- NA
                            } else {
                              out <- k3bn[[lakei]][['var1.var']]
                            }
                            return(out)
                          }))
## 3bo* : kriging (linear variogram model), universal
k3bo <-
  lapply(as.list(1:nlakes),
         function(lakei) {
           if (locallyhomog3[[lakei]]) {
             out <- NA
           } else {
             out <- krige(v ~ orog, n10sub[[lakei]], lakes[lakei, ],
                          vfl3o[[lakei]], nmax = nlocal)
           }
           return(out)
         })
i3bo <- unlist(lapply(as.list(1:nlakes),
                      function(lakei) {
                        if (locallyhomog3[[lakei]]) {
                          out <- homog3[[lakei]]
                        } else {
                          out <- k3bo[[lakei]][['var1.pred']]
                        }
                        return(out)
                      }))
i3bo.var <- unlist(lapply(as.list(1:nlakes),
                          function(lakei) {
                            if (locallyhomog3[[lakei]]) {
                              out <- NA
                            } else {
                              out <- k3bo[[lakei]][['var1.var']]
                            }
                            return(out)
                          }))
## 3cn* : kriging (complex variogram model), ordinary
k3cn <-
  lapply(as.list(1:nlakes),
         function(lakei) {
           if (locallyhomog3[[lakei]]) {
             out <- NA
           } else {
             out <- krige(v ~ 1, n10sub[[lakei]], lakes[lakei, ],
                          vfe3[[lakei]], nmax = nlocal)
           }
           return(out)
         })
i3cn <- unlist(lapply(as.list(1:nlakes),
                      function(lakei) {
                        if (locallyhomog3[[lakei]]) {
                          out <- homog3[[lakei]]
                        } else {
                          out <- k3cn[[lakei]][['var1.pred']]
                        }
                        return(out)
                      }))
i3cn.var <- unlist(lapply(as.list(1:nlakes),
                          function(lakei) {
                            if (locallyhomog3[[lakei]]) {
                              out <- NA
                              } else {
                                out <- k3cn[[lakei]][['var1.var']]
                              }
                            return(out)
                          }))
## 3co* : kriging (complex variogram model), universal
k3co <-
  lapply(as.list(1:nlakes),
         function(lakei) {
           if (locallyhomog3[[lakei]]) {
             out <- NA
           } else {
             out <- krige(v ~ orog, n10sub[[lakei]], lakes[lakei, ],
                          vfe3o[[lakei]], nmax = nlocal)
           }
           return(out)
         })
i3co <- unlist(lapply(as.list(1:nlakes),
                      function(lakei) {
                        if (locallyhomog3[[lakei]]) {
                          out <- homog3[[lakei]]
                        } else {
                          out <- k3co[[lakei]][['var1.pred']]
                        }
                        return(out)
                      }))
i3co.var <- unlist(lapply(as.list(1:nlakes),
                          function(lakei) {
                            if (locallyhomog3[[lakei]]) {
                              out <- NA
                            } else {
                              out <- k3co[[lakei]][['var1.var']]
                            }
                            return(out)
                          }))
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- kriging done \n')
## finally putting the calculated values in container
for (lakei in 1:nlakes) {
  lakename <- lakes[['name']][lakei]
  if (!file.exists(sprintf('%s/pred', outdir))) {
    dir.create(sprintf('%s/pred', outdir))
  }
  if (!file.exists(sprintf('%s/meta', outdir))) {
    dir.create(sprintf('%s/meta', outdir))
  }
  if (!file.exists(sprintf('%s/vario', outdir))) {
    dir.create(sprintf('%s/vario', outdir))
  }
  predfn <- sprintf('%s/pred/%s_%04i_%s_interpolated_cutoff_%s_nlocal_%s.txt',
                    outdir, ncfn2, ni, lakename, ncutoff, nlocal)
  metafn <- sprintf('%s/meta/%s_%04i_%s_metadatainterp_cutoff_%s_nlocal_%s.txt',
                    outdir, ncfn2, ni, lakename, ncutoff, nlocal)
  variofn <- sprintf('%s/vario/%s_%04i_%s_variograms_cutoff_%s.RData',
                    outdir, ncfn2, ni, lakename, ncutoff)
  interpolated <- c(i1a[lakei],
                    i1b[lakei],
                    i1c[lakei],
                    i3an[lakei],
                    i3ao[lakei],
                    i3bn[lakei],
                    i3bo[lakei],
                    i3cn[lakei],
                    i3co[lakei])
  cat(interpolated, file = predfn)
  cat('\n', file = predfn, append = TRUE)
  metadata <-
    c(locallyhomog3[[lakei]] * 1,
      maxgamma3[[lakei]],
      maxgamma3o[[lakei]],
      maxdist3[[lakei]],
      maxdist3o[[lakei]],
      round(ifelse(locallyhomog3[[lakei]], NA, vfl3[[lakei]][['psill']]) /
            maxgamma3[[lakei]], digits = 3),
      round(ifelse(locallyhomog3[[lakei]], NA, vfl3o[[lakei]][['psill']]) /
            maxgamma3o[[lakei]], digits = 3),
      round(ifelse(rep(locallyhomog3[[lakei]], times = 6),
                   rep(NA, times = 6), vfe3[[lakei]][['psill']]) /
            maxgamma3[[lakei]], digits = 3), ## 6 elements
      round(ifelse(rep(locallyhomog3[[lakei]], times = 6),
                   rep(NA, times = 6), vfe3o[[lakei]][['psill']]) /
            maxgamma3o[[lakei]], digits = 3),  ## 6 elements
      ifelse(locallyhomog3[[lakei]], NA, attr(vfl3[[lakei]], 'SSErr')),
      ifelse(locallyhomog3[[lakei]], NA, attr(vfl3o[[lakei]], 'SSErr')),
      ifelse(locallyhomog3[[lakei]], NA, attr(vfe3[[lakei]], 'SSErr')),
      ifelse(locallyhomog3[[lakei]], NA, attr(vfe3o[[lakei]], 'SSErr')),
      ifelse(locallyhomog3[[lakei]], NA,
             sqrt(attr(vfl3[[lakei]], 'SSErr') /
                  nrow(vfl3[[lakei]])) / maxgamma3[[lakei]]),
      ifelse(locallyhomog3[[lakei]], NA,
             sqrt(attr(vfl3o[[lakei]], 'SSErr') /
                  nrow(vfl3o[[lakei]])) / maxgamma3o[[lakei]]),
      ifelse(locallyhomog3[[lakei]], NA,
             sqrt(attr(vfe3[[lakei]], 'SSErr') /
                  nrow(vfe3[[lakei]])) / maxgamma3[[lakei]]),
      ifelse(locallyhomog3[[lakei]], NA,
             sqrt(attr(vfe3o[[lakei]], 'SSErr') /
                  nrow(vfe3o[[lakei]])) / maxgamma3o[[lakei]]),
      i3an.var[lakei],
      i3ao.var[lakei],
      i3bn.var[lakei],
      i3bo.var[lakei],
      i3cn.var[lakei],
      i3co.var[lakei])
  cat(metadata, file = metafn)
  cat('\n', file = metafn, append = TRUE)
  v3l <- v3[[lakei]]
  v3ol <- v3o[[lakei]]
  save(list = c('v3l', 'v3ol'), file = variofn)
}
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' --- writing output to file done, end of loop\n')


}

cat('====\n====\n')
cat('This is Rscript - bye!')
cat('====\n====\n')


  
