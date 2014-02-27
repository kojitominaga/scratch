## usage: Rscript sample_variogram_abel.R --args varname year ti rawpath outdir ncfn locations.csv
##        ncfn actually not read - just used as part of the name for the output

cat('-----\n')
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat('\n')
varname <- commandArgs(trailingOnly = TRUE)[2]
cat(sprintf('in R: varname is %s\n', varname))
year <- commandArgs(trailingOnly = TRUE)[3]
cat(sprintf('in R: year is %s\n', year))

nis <- commandArgs(trailingOnly = TRUE)[4]
if (grep(',', nis)) {
  nis <- as.integer(strsplit(nis, ',')[[1]])
} else {
  nis <- int(nis)
}
nna <- length(nis)
print(nis)
print(nna)
  
rawpaths <- commandArgs(trailingOnly = TRUE)[5]
if (grep(',', rawpaths)) {
  rawpaths <- strsplit(rawpaths, ',')[[1]]
} 
nnb <- length(rawpaths)
print(rawpaths)
print(nnb)

if (nna != nnb) {
  stop('check your argument length')
} else {
  nn <- nna
}

outdir <- commandArgs(trailingOnly = TRUE)[6]
ncfn <- commandArgs(trailingOnly = TRUE)[7]
locationsfn <- commandArgs(trailingOnly = TRUE)[8]

ncfn2 <- strsplit(ncfn, '.nc')[[1]][1]

signifdigit <- switch(varname,
                      'ta_2m' = 2,
                      'pr' = 8,
                      'psl' = 2,
                      'rss' = 9,
                      'rls' = 9,
                      'wss_10m' = 3,
                      'hur_2m' = 2,
                      'albedo' = 3,
                      'ps' = 2,
                      'ts_0m' = 2)

require(intervals, lib.loc = 'R')
require(sp, lib.loc = 'R')
require(gstat, lib.loc = 'R')

nx = 248
ny = 400
## below x (lon, 248) moves faster than y (lat, 400)
lat = scan('NORA10_11km_lat.txt.bz2')
lon = scan('NORA10_11km_lon.txt.bz2')
orograw = scan('NORA10_11km_orog.txt.bz2')
x = rep(1:nx, times = ny)
y = rep(1:ny, each = nx)

llCRS <- CRS('+proj=longlat +ellps=WGS84 +datum=WGS84')

orogdf = data.frame(x, y, lat, lon, orograw)
coordinates(orogdf) <- c('lon', 'lat')
## promotes orodf to SpatialPointsDataFrame
proj4string(orogdf) <- llCRS

oroglat <- orogdf@coords[, 2]
oroglon <- orogdf@coords[, 1]

if (!('temp' %in% list.files('.'))) dir.create('temp')
if (!('interpolated' %in% list.files('.'))) dir.create('interpolated')

## ndays <- sum(grepl(nora10,
##                    list.files(sprintf('temp/%s/%s/', varname, year)))
##              ) ## index starts with 0


require(gstat, lib.loc = 'R') ## for some reason I have to call this again

nmax <- 10

lakes <- read.csv(locationsfn)
coordinates(lakes) <- c('longitude', 'latitude')
proj4string(lakes) <- llCRS

nlocal <- 50
ncutoff <- 100

nlakes <- nrow(lakes)

ninterpmethods <- 9
interpolated <- lapply(1:nlakes, function(x) rep(NA, times = ninterpmethods))

nmetadata <- 33
metadata <- lapply(1:nlakes, function(x) rep(NA, times = nmetadata))

## if (!file.exists('interpolated')) dir.create('interpolated')
## if (!file.exists('interpolated/vario')) dir.create('interpolated/vario')
## if (!file.exists('interpolated/pred')) dir.create('interpolated/pred')
## if (!file.exists(paste0('interpolated/vario/', varname))) {
##   dir.create(paste0('interpolated/vario/', varname))
## }
## if (!file.exists(paste0('interpolated/pred/', varname))) {
##   dir.create(paste0('interpolated/pred/', varname))
## }
## if (!file.exists(paste0('interpolated/vario/', varname, '/', year))) {
##   dir.create(paste0('interpolated/vario/', varname, '/', year))
## }


####### looping for individual interpolation #######
for (theindex in 1:nn) {

cat('==================\n')
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' -- starting new i in main loop now\n')
  
  rawpath <- rawpaths[theindex]
  ni <- nis[theindex]





####### not indenting for now

n10raw <- scan(rawpath, quiet = TRUE)
n10df <- data.frame(lat, lon, v = n10raw, orog = orograw)
coordinates(n10df) <- c('lon', 'lat')
## promotes orodf to SpatialPointsDataFrame
proj4string(n10df) <- llCRS

## primer: ranks for distances from NORA10 points to each lake
ranks <- lapply(as.list(1:nlakes),
                function(lakei) {
                  rank(spDistsN1(n10df, lakes[lakei,], longlat = TRUE))
                })
## ## scope 2 SEE bb1
## n10pan <- n10df[bb1, ]

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
cat(sprintf('%s %s %s: %s out %s locally homogeneous.\n',
            varname, year, ni,
            sum(unlist(locallyhomog3)),
            length(locallyhomog3)))
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat('\n')

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

## ## scope 2 variogram (pan regional) SEE bb1
## if (completelyhomog2) {
##   v2 <- NA
##   v2o <- NA
## } else {
##   v2 <- variogram(v ~ 1, n10pan, cutoff = ncutoff)
##   v2o <- variogram(v ~ orog, n10pan, cutoff = ncutoff)
## }
## scope 3 variogram
n10sub <- lapply(as.list(1:nlakes),
                 function(lakei) {
                   return(n10df[ranks[[lakei]] <= ncutoff, ])
                 })
cat('starting v3\n')
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat('\n')
v3 <- lapply(as.list(1:nlakes),
             function(lakei) {
               if (locallyhomog3[[lakei]]) {
                 out <- NA
               } else {
                 out <- variogram(v ~ 1, n10sub[[lakei]], cutoff = ncutoff)
               }
               return <- out
             })
cat('done v3, now starting v3o\n')
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat('\n')
v3o <- lapply(as.list(1:nlakes),
              function(lakei) {
                if (locallyhomog3[[lakei]]) {
                  out <- NA
                } else {
                  out <- variogram(v ~ orog, n10sub[[lakei]], cutoff = ncutoff)
                }
                return <- out
              })
cat('done v3o\n')
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat('\n')

## fitted variograms (scopes 2 and 3)
## maxgamma2 <- ifelse(completelyhomog2, NA, max(v2[['gamma']]))
## maxgamma2o <- ifelse(completelyhomog2, NA, max(v2o[['gamma']]))
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
## maxdist2 <- ifelse(completelyhomog2, NA, max(v2[['dist']]))
## maxdist2o <- ifelse(completelyhomog2, NA, max(v2o[['dist']]))
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
## if (completelyhomog2) {
##   vfl2 <- NA
##   vfl2o <- NA
## } else {
##   vfl2 <- fit.variogram(v2, vgm(maxgamma2, 'Lin', maxdist2),
##                         fit.sills = TRUE, fit.ranges = FALSE)
##   vfl2o <- fit.variogram(v2o, vgm(maxgamma2o, 'Lin', maxdist2),
##                          fit.sills = TRUE, fit.ranges = FALSE)
## }
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
## if (completelyhomog2) {
##   vfe2 <- NA
##   vfe2o <- NA
## } else {
##   vfe2 <-
##     fit.variogram(v2,
##                   vgm(maxgamma2 / 2, 'Sph', maxdist2 * 0.5,
##                       add.to = vgm(maxgamma2 / 2, 'Sph', maxdist2 * 0.75, 
##                         add.to = vgm(maxgamma2 / 2, 'Exp', maxdist2,
##                           add.to = vgm(maxgamma2 / 2, 'Gau', maxdist2,
##                             add.to = vgm(maxgamma2 / 2, 'Lin', maxdist2,
##                               maxgamma2 / 2))))),
##                   fit.sills = TRUE, fit.ranges = FALSE)
##   vfe2o <- 
##     fit.variogram(v2o,
##                   vgm(maxgamma2o / 2, 'Sph', maxdist2o * 0.5,
##                       add.to = vgm(maxgamma2o / 2, 'Sph', maxdist2o * 0.75, 
##                         add.to = vgm(maxgamma2o / 2, 'Exp', maxdist2o,
##                           add.to = vgm(maxgamma2o / 2, 'Gau', maxdist2o,
##                             add.to = vgm(maxgamma2o / 2, 'Lin', maxdist2o,
##                               maxgamma2o / 2))))),
##                   fit.sills = TRUE, fit.ranges = FALSE)
## }
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
## 2an*, 3an* : inverse distance
## if (completelyhomog2) {
##   k2an <- NA
##   i2an <- homog2
##   i2an.var <- rep(NA, times = nlakes)
## } else {
##   k2an <- krige(v ~ 1, n10pan, lakes, nmax = nlocal)
##   i2an <- k2an[['var1.pred']]
##   i2an.var <- k2an[['var1.var']]
## }
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
## 2ao*, 3ao* : inverse distance with weighting by orog
## if (completelyhomog2) {
##   k2ao <- NA
##   i2ao <- homog2
##   i2ao.var <- rep(NA, times = nlakes)
## } else {
##   k2ao <- krige(v ~ orog, n10pan, lakes, nmax = nlocal)
##   i2ao <- k2ao[['var1.pred']]
##   i2ao.var <- k2ao[['var1.var']]
## }
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
## 2bn*, 3bn* : kriging (linear variogram model), ordinary
## if (completelyhomog2) {
##   k2bn <- NA
##   i2bn <- homog2
##   i2bn.var <- rep(NA, times = nlakes)
## } else {
##   k2bn <- krige(v ~ 1, n10pan, lakes, vfl2, nmax = nlocal)
##   i2bn <- k2bn[['var1.pred']]
##   i2bn.var <- k2bn[['var1.var']]
## }
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
## 2bo*, 3bo* : kriging (linear variogram model), universal
## if (completelyhomog2) {
##   k2bo <- NA
##   i2bo <- homog2
##   i2bo.var <- rep(NA, times = nlakes)
## } else {
##   k2bo <- krige(v ~ orog, n10pan, lakes, vfl2o, nmax = nlocal)
##   i2bo <- k2bo[['var1.pred']]
##   i2bo.var <- k2bo[['var1.var']]
## } 
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
## 2cn*, 3cn* : kriging (complex variogram model), ordinary
## if (completelyhomog2) {
##   k2cn <- NA
##   i2cn <- homog2
##   i2cn.var <- rep(NA, times = nlakes)
## } else {
##   k2cn <- krige(v ~ 1, n10pan, lakes, vfe2, nmax = nlocal)
##   i2cn <- k2cn[['var1.pred']]
##   i2cn.var <- k2cn[['var1.var']]
## }
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
## 2co*, 3co* : kriging (complex variogram model), universal
## if (completelyhomog2) {
##   k2co <- NA
##   i2co <- homog2
##   i2co.var <- rep(NA, times = nlakes)
## } else {
##   k2co <- krige(v ~ orog, n10pan, lakes, vfe2o, nmax = nlocal)
##   i2co <- k2co[['var1.pred']]
##   i2co.var <- k2co[['var1.var']]
## }
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
cat('\n')
## finally putting the calculated values in container
for (lakei in 1:nlakes) {
  lakename <- lakes[['name']][lakei]
  ## if (!file.exists(sprintf('%s/%s', outdir, lakename))) {
  ##   dir.create(sprintf('%s/%s', outdir, lakename))
  ## }
  ## if (!file.exists(sprintf('%s/%s/%s', outdir, lakename, varname))) {
  ##   dir.create(sprintf('%s/%s/%s', outdir, lakename, varname))
  ## }
  ## if (!file.exists(sprintf('%s/%s/%s/pred', outdir, lakename, varname))) {
  ##   dir.create(sprintf('%s/%s/%s/pred', outdir, lakename, varname))
  ## }
  ## if (!file.exists(sprintf('%s/%s/%s/meta', outdir, lakename, varname))) {
  ##   dir.create(sprintf('%s/%s/%s/meta', outdir, lakename, varname))
  ## }
  ## if (!file.exists(sprintf('%s/%s/%s/vario', outdir, lakename, varname))) {
  ##   dir.create(sprintf('%s/%s/%s/vario', outdir, lakename, varname))
  ## }
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
                    ## i2an[lakei],
                    ## i2ao[lakei],
                    ## i2bn[lakei],
                    ## i2bo[lakei],
                    ## i2cn[lakei],
                    ## i2co[lakei],
                    i3an[lakei],
                    i3ao[lakei],
                    i3bn[lakei],
                    i3bo[lakei],
                    i3cn[lakei],
                    i3co[lakei])
  cat(interpolated, file = predfn)
  cat('\n', file = predfn, append = TRUE)
  metadata <-
    c(
      ## completelyhomog2 * 1,
      locallyhomog3[[lakei]] * 1,
      ## maxgamma2,
      ## maxgamma2o,
      maxgamma3[[lakei]],
      maxgamma3o[[lakei]],
      ## maxdist2,
      ## maxdist2o,
      maxdist3[[lakei]],
      maxdist3o[[lakei]],
      ## round(ifelse(completelyhomog2, NA, vfl2[['psill']]) /
      ##       maxgamma2, digits = 3),
      ## round(ifelse(completelyhomog2, NA, vfl2o[['psill']]) /
      ##       maxgamma2o, digits = 3),
      round(ifelse(locallyhomog3[[lakei]], NA, vfl3[[lakei]][['psill']]) /
            maxgamma3[[lakei]], digits = 3),
      round(ifelse(locallyhomog3[[lakei]], NA, vfl3o[[lakei]][['psill']]) /
            maxgamma3o[[lakei]], digits = 3),
      ## round(ifelse(rep(completelyhomog2, times = 6),
      ##              rep(NA, times = 6), vfe2[['psill']]) /
      ##       maxgamma2, digits = 3), ## 6 elements
      ## round(ifelse(rep(completelyhomog2, times = 6),
      ##              rep(NA, times = 6), vfe2o[['psill']]) /
      ##       maxgamma2o, digits = 3), ## 6 elements
      round(ifelse(rep(locallyhomog3[[lakei]], times = 6),
                   rep(NA, times = 6), vfe3[[lakei]][['psill']]) /
            maxgamma3[[lakei]], digits = 3), ## 6 elements
      round(ifelse(rep(locallyhomog3[[lakei]], times = 6),
                   rep(NA, times = 6), vfe3o[[lakei]][['psill']]) /
            maxgamma3o[[lakei]], digits = 3),  ## 6 elements
      ## ifelse(completelyhomog2, NA, attr(vfl2, 'SSErr')),
      ## ifelse(completelyhomog2, NA, attr(vfl2o, 'SSErr')),
      ifelse(locallyhomog3[[lakei]], NA, attr(vfl3[[lakei]], 'SSErr')),
      ifelse(locallyhomog3[[lakei]], NA, attr(vfl3o[[lakei]], 'SSErr')),
      ## ifelse(completelyhomog2, NA, attr(vfe2, 'SSErr')),
      ## ifelse(completelyhomog2, NA, attr(vfe2o, 'SSErr')),
      ifelse(locallyhomog3[[lakei]], NA, attr(vfe3[[lakei]], 'SSErr')),
      ifelse(locallyhomog3[[lakei]], NA, attr(vfe3o[[lakei]], 'SSErr')),
      ## ifelse(completelyhomog2, NA,
      ##        sqrt(attr(vfl2, 'SSErr') / nrow(vfl2)) / maxgamma2), 
      ## ifelse(completelyhomog2, NA,
      ##        sqrt(attr(vfl2o, 'SSErr') / nrow(vfl2o)) / maxgamma2o),
      ifelse(locallyhomog3[[lakei]], NA,
             sqrt(attr(vfl3[[lakei]], 'SSErr') /
                  nrow(vfl3[[lakei]])) / maxgamma3[[lakei]]),
      ifelse(locallyhomog3[[lakei]], NA,
             sqrt(attr(vfl3o[[lakei]], 'SSErr') /
                  nrow(vfl3o[[lakei]])) / maxgamma3o[[lakei]]),
      ## ifelse(completelyhomog2, NA,
      ##        sqrt(attr(vfe2, 'SSErr') / nrow(vfe2)) / maxgamma2),
      ## ifelse(completelyhomog2, NA,
      ##        sqrt(attr(vfe2o, 'SSErr') / nrow(vfe2o)) / maxgamma2o),
      ifelse(locallyhomog3[[lakei]], NA,
             sqrt(attr(vfe3[[lakei]], 'SSErr') /
                  nrow(vfe3[[lakei]])) / maxgamma3[[lakei]]),
      ifelse(locallyhomog3[[lakei]], NA,
             sqrt(attr(vfe3o[[lakei]], 'SSErr') /
                  nrow(vfe3o[[lakei]])) / maxgamma3o[[lakei]]),
      ## i2an.var[lakei],
      ## i2ao.var[lakei],
      ## i2bn.var[lakei],
      ## i2bo.var[lakei],
      ## i2cn.var[lakei],
      ## i2co.var[lakei],
      i3an.var[lakei],
      i3ao.var[lakei],
      i3bn.var[lakei],
      i3bo.var[lakei],
      i3cn.var[lakei],
      i3co.var[lakei])
  cat(metadata, file = metafn)
  cat('\n', file = metafn, append = TRUE)
  ## save(list = c('v2', 'v2o', 'v3', 'v3o'), file = variofn)
  v3l <- v3[[lakei]]
  v3ol <- v3[[lakei]]
  save(list = c('v3l', 'v3ol'), file = variofn)
}
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat('\n')

## for (lakei in 1:nlakes) {
##   dimnames(interpolated[[lakei]])[[2]] <-
##     c('i1a', 'i1b', 'i1c',
##       'i2an', 'i2ao', 'i2bn', 'i2bo', 'i2cn', 'i2co',
##       'i3an', 'i3ao', 'i3bn', 'i3bo', 'i3cn', 'i3co')
##   dimnames(metadata[[lakei]])[[2]] <-
##     c('panhomog', 'localhomog',
##       paste0('maxgamma', c('2', '2o', '3', '3o')), 
##       paste0('maxdist', c('2', '2o', '3', '3o')), 
##       paste0('vfl', c('2', '2o', '3', '3o'), '.Lin'),
##       paste0('vfe', rep(c('2', '2o', '3', '3o'), each = 6), '.',
##              rep(c('Nug', 'Lin', 'Gau', 'Exp', 'Sph75', 'Sph50'), times = 4)),
##       paste0('vfl', c('2', '2o', '3', '3o'), '.SSE'), 
##       paste0('vfe', c('2', '2o', '3', '3o'), '.SSE'), 
##       paste0('vfl', c('2', '2o', '3', '3o'), '.PartialRMSE'),
##       paste0('vfe', c('2', '2o', '3', '3o'), '.PartialRMSE'),
##       paste0('i', rep(c(2, 3), each = 6),
##              rep(rep(c('a', 'b', 'c'), each = 2), times = 2),
##              rep(c('n', 'o'), times = 6), '.var')) 
  
}

  

  
