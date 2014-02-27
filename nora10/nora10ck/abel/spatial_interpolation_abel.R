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


if (testingflag) {
  rawdata <- scan(rawpaths, quiet = TRUE)
}

####### looping for individual interpolation #######
for (theindex in 1:nn) {

cat('==================\n')
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat(' -- starting new i in main loop now\n')

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
cat('-- krigin done \n')
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
  v3ol <- v3[[lakei]]
  save(list = c('v3l', 'v3ol'), file = variofn)
}
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat('-- writing output to file done, end of loop\n')


}

  

  
