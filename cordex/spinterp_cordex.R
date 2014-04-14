## usage: Rscript spinterp_cordex.R --args \
##          lonpath latpath orogpath varpath outdir llon llat lalt

nlocal <- 500
cutoff <- 100
ninterpmethods <- 9
nmetadata <- 33
## boundariesMid <- sqrt(c(1, 2, 4, 5, 8, 9, 10, 13, 16, 17, 18)) * 12.245
## ## at grid 0.11 degree
## > boundariesMid
##  [1] 12.24500 17.31705 24.49000 27.38065 34.63409 36.73500 38.72209 44.14998
##  [9] 48.98000 50.48743 51.95114
boundaries <- c(15, 20, 25.8, 30, 35.2, 37.7, 42, 46, 53, 62, 71, 80, 90, 101)


cat('====\n====\n====\n====\nThis is Rscript\n')
cat(format(Sys.time(), "%a %b %d %X %Y"))
cat('current working directory is:\n')
cat(getwd())
cat('\n====\n====\n====\n====\n')

## lonpath <- commandArgs(trailingOnly = TRUE)[2]
## latpath <- commandArgs(trailingOnly = TRUE)[3]
## orogpath <- commandArgs(trailingOnly = TRUE)[4]
## varpath <- commandArgs(trailingOnly = TRUE)[5]
## outdir <- commandArgs(trailingOnly = TRUE)[6]
## llon <- as.numeric(commandArgs(trailingOnly = TRUE)[7])
## llat <- as.numeric(commandArgs(trailingOnly = TRUE)[8])
## lalt <- as.numeric(commandArgs(trailingOnly = TRUE)[9])

lonpath <- 'EUR-11/DMI/ICHEC-EC-EARTH/rcp85/r3i1p1/DMI-HIRHAM5/v1/fx/orog/near-testlocation-longitude.txt.gz'
latpath <- 'EUR-11/DMI/ICHEC-EC-EARTH/rcp85/r3i1p1/DMI-HIRHAM5/v1/fx/orog/near-testlocation-latitude.txt.gz'
orogpath <- 'EUR-11/DMI/ICHEC-EC-EARTH/rcp85/r3i1p1/DMI-HIRHAM5/v1/fx/orog/near-testlocation-altitude.txt.gz'
varpath <- 'EUR-11/DMI/ICHEC-EC-EARTH/rcp85/r3i1p1/DMI-HIRHAM5/v1/day/tas/near-testlocation-tas_EUR-11_ICHEC-EC-EARTH_rcp85_r3i1p1_DMI-HIRHAM5_v1_day_20910101-20951231.txt.gz'
outdir <- '.'
llon <- 10
llat <- 60
lalt <- 100



cat(sprintf('[spinterp_cordex.R] lonpath is %s\n', lonpath))
cat(sprintf('[spinterp_cordex.R] latpath is %s\n', latpath))
cat(sprintf('[spinterp_cordex.R] orogpath is %s\n', orogpath))
cat(sprintf('[spinterp_cordex.R] varpath is %s\n', varpath))
cat(sprintf('[spinterp_cordex.R] outdir is %s\n', outdir))
cat(sprintf('[spinterp_cordex.R] llon is %s\n', llon))
cat(sprintf('[spinterp_cordex.R] llat is %s\n', llat ))
cat(sprintf('[spinterp_cordex.R] lalt is %s\n', lalt))

require(intervals)
require(sp)
require(gstat)
## require(intervals, lib.loc = 'R')
## require(sp, lib.loc = 'R')
## require(gstat, lib.loc = 'R')

llCRS <- CRS('+proj=longlat +ellps=WGS84 +datum=WGS84')

lon <- scan(lonpath, quiet = TRUE)
lat <- scan(latpath, quiet = TRUE)
alt <- scan(orogpath, quiet = TRUE)
orogdf <- data.frame(lat, lon, orog = alt)
orogdfgeo <- orogdf
coordinates(orogdfgeo) <- c('lon', 'lat')
proj4string(orogdfgeo) <- llCRS

require(gstat)
## require(gstat, lib.loc = 'R')

newloc <- data.frame(lon = llon, lat = llat, orog = lalt)
coordinates(newloc) <- c('lon', 'lat')
proj4string(newloc) <- llCRS

## read raw data
raw <- as.matrix(read.table(varpath))
n <- nrow(raw) ## number of time points

results <- matrix(nrow = n, ncol = ninterpmethods + nmetadata)

ranks <- rank(spDistsN1(orogdfgeo, newloc, longlat = TRUE))
lh <- length(unique(orogdf[['v']][ranks <= 5])) == 1 ## locally homogeneous

for (i in 1:n) {
  cat(i) ; cat('\n')
  vi <- raw[i, ]
  r <- data.frame(orogdf, v = vi)
  coordinates(r) <- c('lon', 'lat')
  proj4string(r) <- llCRS
  ## now use r to estimate v at newloc 

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
    i1c <- out
  }
  if (lh) {
    v3 <- NA
    v3o <- NA
    mg <- NA
    mgo <- NA
    md <- NA
    mdo <- NA
    vfl3 <- NA
    vfl3o <- NA
    vfe3 <- NA
    vfe3o <- NA
    k3an <- NA
    i3an <- homog
    i3an.var <- NA
    k3ao <- NA
    i3ao <- homog
    i3ao.var <- NA
    k3bn <- NA
    i3bn <- homog
    i3bn.var <- NA
    k3bo <- NA
    i3bo <- homog
    i3bo.var <- NA
    k3cn <- NA
    i3cn <- homog
    i3cn.var <- NA
    k3co <- NA
    i3co <- homog
    i3co.var <- NA
  } else {
    v3 <- variogram(v ~ 1, r, cutoff = cutoff, boundaries = boundaries)
    v3o <- variogram(v ~ orog, r, cutoff = cutoff, boundaries = boundaries)
    mg <- max(v3[['gamma']])
    mgo <- max(v3o[['gamma']])
    md <- max(v3[['dist']])
    mdo <- max(v3o[['dist']])
    vfl3 <- fit.variogram(v3, vgm(mg, 'Lin', md),
                          fit.sills = TRUE, fit.ranges = FALSE)
    vfl3o <- fit.variogram(v3o, vgm(mgo, 'Lin', mdo),
                           fit.sills = TRUE, fit.ranges = FALSE)
    vfe3 <- fit.variogram(v3,
                          vgm(mg / 2, 'Sph', md * 0.25,
                              add.to = vgm(mg / 2, 'Sph', md * 0.50,
                                add.to = vgm(mg / 2, 'Exp', md,
                                  add.to = vgm(mg / 2, 'Gau', md,
                                    add.to = vgm(mg / 2, 'Lin', md,
                                      mg / 2))))),
                          fit.sills = TRUE, fit.ranges = FALSE)
    vfe3o <- fit.variogram(v3o,
                           vgm(mgo / 2, 'Sph', mdo * 0.25,
                               add.to = vgm(mgo / 2, 'Sph', mdo * 0.50,
                                 add.to = vgm(mgo / 2, 'Exp', mdo,
                                   add.to = vgm(mgo / 2, 'Gau', mdo,
                                     add.to = vgm(mgo / 2, 'Lin', mdo,
                                       mgo / 2))))),
                           fit.sills = TRUE, fit.ranges = FALSE)
    ## 3an* : inverse distance
    k3an <- krige(v ~ 1, r, newloc, nmax = nlocal)
    i3an <- k3an[['var1.pred']]
    i3an.var <- k3an[['var1.var']]
    ## 3ao* : inverse distance with weighting by orog
    k3ao <- krige(v ~ orog, r, newloc, nmax = nlocal)
    i3ao <- k3ao[['var1.pred']]
    i3ao.var <- k3ao[['var1.var']]
    ## 3bn* : kriging (linear variogram model), ordinary
    k3bn <- krige(v ~ 1, r, newloc, vfl3, nmax = nlocal)
    i3bn <- k3bn[['var1.pred']]
    i3bn.var <- k3bn[['var1.var']]
    ## 3bo* : kriging (linear variogram model), universal
    k3bo <- krige(v ~ orog, r, newloc, vfl3o, nmax = nlocal)
    i3bo <- k3bo[['var1.pred']]
    i3bo.var <- k3bo[['var1.var']]
    ## 3cn* : kriging (complex variogram model), ordinary
    k3cn <- krige(v ~ 1, r, newloc, vfe3, nmax = nlocal)
    i3cn <- k3cn[['var1.pred']]
    i3cn.var <-k3cn[['var1.var']]
    ## 3co* : kriging (complex variogram model), universal
    k3co <- krige(v ~ orog, r, newloc, vfe3o, nmax = nlocal)
    i3co <- k3co[['var1.pred']]
    i3co.var <- k3co[['var1.var']]
  }
  
  results[i, ] <-
    c(i1a, i1b, i1c, i3an, i3ao, i3bn, i3bo, i3cn, i3co,
      lh * 1, mg, mgo, md, mdo,
      round(ifelse(lh, NA, vfl3[['psill']]) / mg, digits = 3),
      round(ifelse(lh, NA, vfl3o[['psill']]) / mgo, digits = 3),
      round(ifelse(rep(lh, times = 6),
                   rep(NA, times = 6),
                   vfe3[['psill']]) / mg, digits = 3), ## 6 elements
      round(ifelse(rep(lh, times = 6),
                   rep(NA, times = 6),
                   vfe3o[['psill']]) / mgo, digits = 3), ## 6 elements
      ifelse(lh, NA, attr(vfl3, 'SSErr')),
      ifelse(lh, NA, attr(vfl3o, 'SSErr')),
      ifelse(lh, NA, attr(vfe3, 'SSErr')),
      ifelse(lh, NA, attr(vfe3o, 'SSErr')),
      ifelse(lh, NA, sqrt(attr(vfl3, 'SSErr') / nrow(vfl3)) / mg),
      ifelse(lh, NA, sqrt(attr(vfl3o, 'SSErr') / nrow(vfl3o)) / mgo),
      ifelse(lh, NA, sqrt(attr(vfe3, 'SSErr') / nrow(vfe3)) / mg),
      ifelse(lh, NA, sqrt(attr(vfe3o, 'SSErr') / nrow(vfe3o)) / mgo),
      i3an.var,
      i3ao.var,
      i3bn.var,
      i3bo.var,
      i3cn.var,
      i3co.var)
}


  


