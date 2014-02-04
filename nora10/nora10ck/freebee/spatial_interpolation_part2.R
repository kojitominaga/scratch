## usage: Rscript sample_variogram.R --args NORA10file

choosethismany <- 30 ## choose this many hours from the available hours

nora10nc <- commandArgs(trailingOnly = TRUE)[2]
cat(nora10nc)
cat('\n')
nora10 <- strsplit(nora10nc, '.', fixed = TRUE)[[1]][1]
foo <- strsplit(nora10, '_', fixed = TRUE)[[1]]
if (length(foo) == 6) {
  varname <- sprintf('%s_%s', foo[4], foo[5])
  year <- as.integer(foo[6])
}
if (length(foo) == 5) {
  varname <- foo[4]
  year <- as.integer(foo[5])
}

source('signifdigit.R')

require(intervals)
require(sp)
require(gstat)

source('readCOMSAT.R')

oroglat <- orogdf@coords[, 2]
oroglon <- orogdf@coords[, 1]

## boundary box near comsat SCOPE @
bb1 <- (oroglat > comsatwraplat[1]) &
  (oroglat < comsatwraplat[2]) &
  (oroglon > comsatwraplon[1]) &
  (oroglon < comsatwraplon[2])

if (!('temp' %in% list.files('.'))) dir.create('temp')
if (!('interpolated' %in% list.files('.'))) dir.create('interpolated')

ndays <- sum(grepl(nora10,
                   list.files(sprintf('temp/%s/%s/', varname, year)))
             ) ## index starts with 0

chosen <- sample(1:ndays, size = choosethismany, replace = FALSE)

require(gstat)

nmax <- 10


## reading nve data
nve <- read.csv('nve/coordinates.csv')
coordinates(nve) <- c('longitude', 'latitude')
proj4string(nve) <- llCRS

lakes <- nve

nlocal <- 50
ncutoff <- 100

## lakes <- comsat
## we will be using non-COMSAT lakes later so use "lakes" as name
nlakes <- nrow(lakes)

## if (!file.exists('samplevariogram')) dir.create('samplevariogram')
## pdf(sprintf('samplevariogram/%s_%s_sample_variogram_fit.pdf', varname, year))

ninterpmethods <- 15
interpolated <- lapply(1:nlakes,
                       function(whatever) {
                         matrix(NA, nrow = ndays, ncol = ninterpmethods)
                       })
nmetadata <- 66
metadata <- lapply(1:nlakes,
                   function(whatever) {
                     matrix(NA, nrow = ndays, ncol = nmetadata)
                   })

if (!file.exists('interpolated')) dir.create('interpolated')
if (!file.exists('interpolated/vario')) dir.create('interpolated/vario')
if (!file.exists('interpolated/pred')) dir.create('interpolated/pred')
if (!file.exists(paste0('interpolated/vario/', varname))) {
  dir.create(paste0('interpolated/vario/', varname))
}
if (!file.exists(paste0('interpolated/pred/', varname))) {
  dir.create(paste0('interpolated/pred/', varname))
}
if (!file.exists(paste0('interpolated/vario/', varname, '/', year))) {
  dir.create(paste0('interpolated/vario/', varname, '/', year))
}

for (ni in 1:ndays) {
  n10raw <- scan(sprintf('temp/%s/%s/%s_%04i.txt.bz2',
                         varname, year, nora10, ni - 1),
                 quiet = TRUE)
  n10df <- data.frame(lat, lon, v = n10raw, orog = orograw)
  coordinates(n10df) <- c('lon', 'lat')
  ## promotes orodf to SpatialPointsDataFrame
  proj4string(n10df) <- llCRS

  ## primer: ranks for distances from NORA10 points to each lake
  ranks <- lapply(as.list(1:nlakes),
                  function(lakei) {
                    rank(spDistsN1(n10df, lakes[lakei,], longlat = TRUE))
                  })
  ## scope 2 SEE bb1
  n10pan <- n10df[bb1, ]
  
  ## if the nearest 5 has the same value:
  ##    i1a, i1b, i1c, i3an, i3ao, i3bn, i3bo, i3cn, i3co 
  ## will have the same value as the estimate (i1a is the same anyway).
  ## first three will be just about saving computation time
  ## (numerically will be the same), but the rest can fail when kriging
  ## so it's important to avoid it.
  ## NEW!! actually scope 2 can get completely homogeneous (e.g., rss)
  completelyhomog2 <- (length(unique(n10pan[['v']])) == 1)
  homog2 <- unique(n10pan[['v']])
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
  cat(sprintf('%s %s %s: %s out %s locally homogeneous. %s\n',
              varname, year, ni,
              sum(unlist(locallyhomog3)),
              length(locallyhomog3),
              ifelse(completelyhomog2, 'Also completely homogeneous!', '')))  
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

  ## scope 2 variogram (pan regional) SEE bb1
  if (completelyhomog2) {
    v2 <- NA
    v2o <- NA
  } else {
    v2 <- variogram(v ~ 1, n10pan, cutoff = ncutoff)
    v2o <- variogram(v ~ orog, n10pan, cutoff = ncutoff)
  }
  ## scope 3 variogram
  n10sub <- lapply(as.list(1:nlakes),
                   function(lakei) {
                     return(n10df[ranks[[lakei]] <= ncutoff, ])
                   })
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
  ## fitted variograms (scopes 2 and 3)
  maxgamma2 <- ifelse(completelyhomog2, NA, max(v2[['gamma']]))
  maxgamma2o <- ifelse(completelyhomog2, NA, max(v2o[['gamma']]))
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
  maxdist2 <- ifelse(completelyhomog2, NA, max(v2[['dist']]))
  maxdist2o <- ifelse(completelyhomog2, NA, max(v2o[['dist']]))
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
  if (completelyhomog2) {
    vfl2 <- NA
    vfl2o <- NA
  } else {
    vfl2 <- fit.variogram(v2, vgm(maxgamma2, 'Lin', maxdist2),
                          fit.sills = TRUE, fit.ranges = FALSE)
    vfl2o <- fit.variogram(v2o, vgm(maxgamma2o, 'Lin', maxdist2),
                           fit.sills = TRUE, fit.ranges = FALSE)
  }
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
  if (completelyhomog2) {
    vfe2 <- NA
    vfe2o <- NA
  } else {
    vfe2 <-
      fit.variogram(v2,
                    vgm(maxgamma2 / 2, 'Sph', maxdist2 * 0.5,
                        add.to = vgm(maxgamma2 / 2, 'Sph', maxdist2 * 0.75, 
                          add.to = vgm(maxgamma2 / 2, 'Exp', maxdist2,
                            add.to = vgm(maxgamma2 / 2, 'Gau', maxdist2,
                              add.to = vgm(maxgamma2 / 2, 'Lin', maxdist2,
                                maxgamma2 / 2))))),
                    fit.sills = TRUE, fit.ranges = FALSE)
    vfe2o <- 
      fit.variogram(v2o,
                    vgm(maxgamma2o / 2, 'Sph', maxdist2o * 0.5,
                        add.to = vgm(maxgamma2o / 2, 'Sph', maxdist2o * 0.75, 
                          add.to = vgm(maxgamma2o / 2, 'Exp', maxdist2o,
                            add.to = vgm(maxgamma2o / 2, 'Gau', maxdist2o,
                              add.to = vgm(maxgamma2o / 2, 'Lin', maxdist2o,
                                maxgamma2o / 2))))),
                    fit.sills = TRUE, fit.ranges = FALSE)
  }
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
  if (completelyhomog2) {
    k2an <- NA
    i2an <- homog2
    i2an.var <- rep(NA, times = nlakes)
  } else {
    k2an <- krige(v ~ 1, n10pan, lakes, nmax = nlocal)
    i2an <- k2an[['var1.pred']]
    i2an.var <- k2an[['var1.var']]
  }
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
  if (completelyhomog2) {
    k2ao <- NA
    i2ao <- homog2
    i2ao.var <- rep(NA, times = nlakes)
  } else {
    k2ao <- krige(v ~ orog, n10pan, lakes, nmax = nlocal)
    i2ao <- k2ao[['var1.pred']]
    i2ao.var <- k2ao[['var1.var']]
  }
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
  if (completelyhomog2) {
    k2bn <- NA
    i2bn <- homog2
    i2bn.var <- rep(NA, times = nlakes)
  } else {
    k2bn <- krige(v ~ 1, n10pan, lakes, vfl2, nmax = nlocal)
    i2bn <- k2bn[['var1.pred']]
    i2bn.var <- k2bn[['var1.var']]
  }
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
  if (completelyhomog2) {
    k2bo <- NA
    i2bo <- homog2
    i2bo.var <- rep(NA, times = nlakes)
  } else {
    k2bo <- krige(v ~ orog, n10pan, lakes, vfl2o, nmax = nlocal)
    i2bo <- k2bo[['var1.pred']]
    i2bo.var <- k2bo[['var1.var']]
  } 
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
  if (completelyhomog2) {
    k2cn <- NA
    i2cn <- homog2
    i2cn.var <- rep(NA, times = nlakes)
  } else {
    k2cn <- krige(v ~ 1, n10pan, lakes, vfe2, nmax = nlocal)
    i2cn <- k2cn[['var1.pred']]
    i2cn.var <- k2cn[['var1.var']]
  }
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
  if (completelyhomog2) {
    k2co <- NA
    i2co <- homog2
    i2co.var <- rep(NA, times = nlakes)
  } else {
    k2co <- krige(v ~ orog, n10pan, lakes, vfe2o, nmax = nlocal)
    i2co <- k2co[['var1.pred']]
    i2co.var <- k2co[['var1.var']]
  }
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
  
  ## finally putting the calculated values in container
  for (lakei in 1:nlakes) {
    interpolated[[lakei]][ni, ] <-
      c(i1a[lakei],
        i1b[lakei],
        i1c[lakei],
        i2an[lakei],
        i2ao[lakei],
        i2bn[lakei],
        i2bo[lakei],
        i2cn[lakei],
        i2co[lakei],
        i3an[lakei],
        i3ao[lakei],
        i3bn[lakei],
        i3bo[lakei],
        i3cn[lakei],
        i3co[lakei])
    metadata[[lakei]][ni, ] <-
      c(completelyhomog2 * 1,
        locallyhomog3[[lakei]] * 1,
        maxgamma2,
        maxgamma2o,
        maxgamma3[[lakei]],
        maxgamma3o[[lakei]],
        maxdist2,
        maxdist2o,
        maxdist3[[lakei]],
        maxdist3o[[lakei]],
        round(ifelse(completelyhomog2, NA, vfl2[['psill']]) /
              maxgamma2, digits = 3),
        round(ifelse(completelyhomog2, NA, vfl2o[['psill']]) /
              maxgamma2o, digits = 3),
        round(ifelse(locallyhomog3[[lakei]], NA, vfl3[[lakei]][['psill']]) /
              maxgamma3[[lakei]], digits = 3),
        round(ifelse(locallyhomog3[[lakei]], NA, vfl3o[[lakei]][['psill']]) /
              maxgamma3o[[lakei]], digits = 3),
        round(ifelse(rep(completelyhomog2, times = 6),
                     rep(NA, times = 6), vfe2[['psill']]) /
              maxgamma2, digits = 3), ## 6 elements
        round(ifelse(rep(completelyhomog2, times = 6),
                     rep(NA, times = 6), vfe2o[['psill']]) /
              maxgamma2o, digits = 3), ## 6 elements
        round(ifelse(rep(locallyhomog3[[lakei]], times = 6),
                     rep(NA, times = 6), vfe3[[lakei]][['psill']]) /
              maxgamma3[[lakei]], digits = 3), ## 6 elements
        round(ifelse(rep(locallyhomog3[[lakei]], times = 6),
                     rep(NA, times = 6), vfe3o[[lakei]][['psill']]) /
              maxgamma3o[[lakei]], digits = 3),  ## 6 elements
        ifelse(completelyhomog2, NA, attr(vfl2, 'SSErr')),
        ifelse(completelyhomog2, NA, attr(vfl2o, 'SSErr')),
        ifelse(locallyhomog3[[lakei]], NA, attr(vfl3[[lakei]], 'SSErr')),
        ifelse(locallyhomog3[[lakei]], NA, attr(vfl3o[[lakei]], 'SSErr')),
        ifelse(completelyhomog2, NA, attr(vfe2, 'SSErr')),
        ifelse(completelyhomog2, NA, attr(vfe2o, 'SSErr')),
        ifelse(locallyhomog3[[lakei]], NA, attr(vfe3[[lakei]], 'SSErr')),
        ifelse(locallyhomog3[[lakei]], NA, attr(vfe3o[[lakei]], 'SSErr')),
        ifelse(completelyhomog2, NA,
               sqrt(attr(vfl2, 'SSErr') / nrow(vfl2)) / maxgamma2), 
        ifelse(completelyhomog2, NA,
               sqrt(attr(vfl2o, 'SSErr') / nrow(vfl2o)) / maxgamma2o),
        ifelse(locallyhomog3[[lakei]], NA,
               sqrt(attr(vfl3[[lakei]], 'SSErr') /
                    nrow(vfl3[[lakei]])) / maxgamma3[[lakei]]),
        ifelse(locallyhomog3[[lakei]], NA,
               sqrt(attr(vfl3o[[lakei]], 'SSErr') /
                    nrow(vfl3o[[lakei]])) / maxgamma3o[[lakei]]),
        ifelse(completelyhomog2, NA,
               sqrt(attr(vfe2, 'SSErr') / nrow(vfe2)) / maxgamma2),
        ifelse(completelyhomog2, NA,
               sqrt(attr(vfe2o, 'SSErr') / nrow(vfe2o)) / maxgamma2o),
        ifelse(locallyhomog3[[lakei]], NA,
               sqrt(attr(vfe3[[lakei]], 'SSErr') /
                    nrow(vfe3[[lakei]])) / maxgamma3[[lakei]]),
        ifelse(locallyhomog3[[lakei]], NA,
               sqrt(attr(vfe3o[[lakei]], 'SSErr') /
                    nrow(vfe3o[[lakei]])) / maxgamma3o[[lakei]]),
        i2an.var[lakei],
        i2ao.var[lakei],
        i2bn.var[lakei],
        i2bo.var[lakei],
        i2cn.var[lakei],
        i2co.var[lakei],
        i3an.var[lakei],
        i3ao.var[lakei],
        i3bn.var[lakei],
        i3bo.var[lakei],
        i3cn.var[lakei],
        i3co.var[lakei])
  }
  variofn <-
    sprintf('interpolated/vario/%s/%s/%s_%04d_%s_variograms_cutoff_%s.RData',
            varname, year, nora10, ni,
            lakes[['waterbodyname']][lakei], ncutoff)
  save(list = c('v2', 'v2o', 'v3', 'v3o'), file = variofn)
}

for (lakei in 1:nlakes) {
  dimnames(interpolated[[lakei]])[[2]] <-
    c('i1a', 'i1b', 'i1c',
      'i2an', 'i2ao', 'i2bn', 'i2bo', 'i2cn', 'i2co',
      'i3an', 'i3ao', 'i3bn', 'i3bo', 'i3cn', 'i3co')
  dimnames(metadata[[lakei]])[[2]] <-
    c('panhomog', 'localhomog',
      paste0('maxgamma', c('2', '2o', '3', '3o')), 
      paste0('maxdist', c('2', '2o', '3', '3o')), 
      paste0('vfl', c('2', '2o', '3', '3o'), '.Lin'),
      paste0('vfe', rep(c('2', '2o', '3', '3o'), each = 6), '.',
             rep(c('Nug', 'Lin', 'Gau', 'Exp', 'Sph75', 'Sph50'), times = 4)),
      paste0('vfl', c('2', '2o', '3', '3o'), '.SSE'), 
      paste0('vfe', c('2', '2o', '3', '3o'), '.SSE'), 
      paste0('vfl', c('2', '2o', '3', '3o'), '.PartialRMSE'),
      paste0('vfe', c('2', '2o', '3', '3o'), '.PartialRMSE'),
      paste0('i', rep(c(2, 3), each = 6),
             rep(rep(c('a', 'b', 'c'), each = 2), times = 2),
             rep(c('n', 'o'), times = 6), '.var')) 
}


for (lakei in 1:nlakes) {
  fnameout <- sprintf('interpolated/pred/%s/%s_%s.csv.gz',
                      varname, nora10, lakes[['waterbodyname']][lakei])
  g <- gzfile(fnameout, 'w')
  write.csv(interpolated[[lakei]], file = g, row.names = FALSE)
  close(g)
  fnameout <- sprintf('interpolated/pred/%s/%s_%s_metadata.csv.gz',
                      varname, nora10, lakes[['waterbodyname']][lakei])
  g <- gzfile(fnameout, 'w')
  write.csv(metadata[[lakei]], file = g, row.names = FALSE)
  close(g)
}


  
  

##   ## co-kriging with elevation
##   maxgamma <- max(vario[['gamma']])
##   vf <- fit.variogram(vario,
##                       vgm(maxgamma / 2, 'Sph', 50,
##                           add.to = vgm(maxgamma / 2, 'Sph', 75, 
##                             add.to = vgm(maxgamma / 2, 'Exp', 100,
##                               add.to = vgm(maxgamma / 2, 'Gau', 100,
##                                 add.to = vgm(maxgamma / 2, 'Lin', 100,
##                                   maxgamma / 2)))),
##                       fit.sills = TRUE, fit.ranges = FALSE))
##   vf.Lin <- fit.variogram(vario, vgm(maxgamma, 'Lin', 100),
##                           fit.sills = TRUE, fit.ranges = FALSE)
##   print(vf)
##   plot(vario[['dist']], vario[['gamma']], type = 'p',
##        ylim = c(0, maxgamma), xlim = c(0, 100),
##        ylab = 'Semivariance', xlab = 'Distance',
##        main = sprintf('%s (%s) time entry %04d', varname, year, ni))
##   vfLine <- variogramLine(vf, 100)
##   lines(vfLine[['dist']], vfLine[['gamma']])
##   text(100, maxgamma / 10 * (((nrow(vf) + 1):1 - 1) / 2 + 0.5),
##        labels = c(
##          paste(sprintf('RMSE / max(gamma) : %02d %%',
##                        as.integer(sqrt(attr(vf, 'SSErr') / nrow(vario)
##                                        ) / maxgamma * 100)
##                        )
##                ),
##          paste(vf[['model']],
##                as.character(signif(vf[['psill']], digits = 2)),
##                as.character(round(vf[['range']], digits = 0)),
##                sprintf(': %02d %%', vf[['psill']] / maxgamma * 100)
##                )
##          ),
##        pos = 2)
##   abline(h = 0)
##   ku10 <- krige(v ~ orog, n10n, comsat, vf, nmax = 10)
##   ku30 <- krige(v ~ orog, n10n, comsat, vf, nmax = 30)
##   ku50 <- krige(v ~ orog, n10n, comsat, vf, nmax = 50)
##   ku100 <- krige(v ~ orog, n10n, comsat, vf, nmax = 100)
##   ko10 <- krige(v ~ 1, n10n, comsat, vf, nmax = 10)
##   ko30 <- krige(v ~ 1, n10n, comsat, vf, nmax = 30)
##   ko50 <- krige(v ~ 1, n10n, comsat, vf, nmax = 50)
##   ko100 <- krige(v ~ 1, n10n, comsat, vf, nmax = 100)
##   kuL10 <- krige(v ~ orog, n10n, comsat, vf.Lin, nmax = 10)
##   kuL30 <- krige(v ~ orog, n10n, comsat, vf.Lin, nmax = 30)
##   kuL50 <- krige(v ~ orog, n10n, comsat, vf.Lin, nmax = 50)
##   kuL100 <- krige(v ~ orog, n10n, comsat, vf.Lin, nmax = 100)
##   koL10 <- krige(v ~ 1, n10n, comsat, vf.Lin, nmax = 10)
##   koL30 <- krige(v ~ 1, n10n, comsat, vf.Lin, nmax = 30)
##   koL50 <- krige(v ~ 1, n10n, comsat, vf.Lin, nmax = 50)
##   koL100 <- krige(v ~ 1, n10n, comsat, vf.Lin, nmax = 100)
##   predicted <- data.frame(lapply(
##     list(ku10 = ku10, ku30 = ku30, ku50 = ku50, ku100 = ku100,
##          ko10 = ko10, ko30 = ko30, ko50 = ko50, ko100 = ko100,
##          kuL10 = kuL10, kuL30 = kuL30, kuL50 = kuL50, kuL100 = kuL100,
##          koL10 = koL10, koL30 = koL30, koL50 = koL50, koL100 = koL100), 
##     function(x) x[['var1.pred']]))
##   pdf('testpredicted.pdf', height = 6, width = 6)
##   ra <- range(c(predicted[-c(4, 8, 12, 16)], recursive = TRUE))
##   plot(predicted[-c(4, 6:8, 9:16)],
##        pch = 20, cex = 1,
##        col = ifelse(comsat[['orog']] < 200, 'red',
##          ifelse(comsat[['orog']] < 400, 'gray', 'blue')),
##        xlim = ra, ylim = ra)
##   dev.off()

##   ## lake specific
##   nn <- 100
##   nlocal <- 10
##   comsati <- 30
##   ## example lake comsat[comsati, ]
##   r <- rank(spDistsN1(n10df, comsat[comsati, ], longlat = TRUE))
##   n10r <- n10df[r <= nn, ]
##   ## 1. inverse distance
##   kklm <- krige(v ~ 1, n10r, comsat[comsati, ], nmax = nlocal)
##   ## 2. inverse distance weighted
##   kklmw <- krige(v ~ orog, n10r, comsat[comsati, ], nmax = nlocal)
##   ## 3.0 variogram
##   vario <- variogram(v ~ orog, n10r)
##   maxgamma <- max(vario[['gamma']])
##   maxdist <- max(vario[['dist']])
##   ## 3.1 kriging using variogram model "use everything"
##   vf <- fit.variogram(vario,
##                       vgm(maxgamma / 2, 'Sph', maxdist * 0.5,
##                           add.to = vgm(maxgamma / 2, 'Sph', maxdist * 0.75, 
##                             add.to = vgm(maxgamma / 2, 'Exp', maxdist,
##                               add.to = vgm(maxgamma / 2, 'Gau', maxdist,
##                                 add.to = vgm(maxgamma / 2, 'Lin', maxdist,
##                                   maxgamma / 2))))),
##                       fit.sills = TRUE, fit.ranges = FALSE)
##   ## 3.1.1 ordinary kriging (vgm: "fit everything")
##   koE <- krige(v ~ 1, n10r, comsat[comsati, ], vf, nmax = nlocal)
##   ## 3.1.2 universal kriging (co-krig with orog) (vgm: "fit everything")
##   kuE <- krige(v ~ orog, n10r, comsat[comsati, ], vf, nmax = nlocal)
##   ## 3.2 kriging using variogram model "linear"
##   vfL <- fit.variogram(vario, vgm(maxgamma, 'Lin', maxdist), 
##                        fit.sills = TRUE, fit.ranges = FALSE)  
##   ## 3.2.1 ordinary kriging (vgm: "linear")
##   koL <- krige(v ~ 1, n10r, comsat[comsati, ], vfL, nmax = nlocal)
##   ## 3.2.2 universal kriging (co-krig with orog) (vgm: "linear")
##   kuL <- krige(v ~ orog, n10r, comsat[comsati, ], vfL, nmax = nlocal)
##   predicted.list <- list(kklm = kklm, kklmw = kklmw,
##                          koE = koE, kuE = kuE, koL = koL, kuL = kuL)
##   predicted <- unlist(lapply(predicted.list,
##                              function(x) x[['var1.pred']]))
##   print(predicted)
##   print(vf)
##   print(sqrt(attr(vf, 'SSErr') / nrow(vario)))
##   print(vfL)
##   print(sqrt(attr(vfL, 'SSErr') / nrow(vario)))
  
                      
  
  
  
                          
                          
  
  
  
  
## }

## dev.off()

  

  
