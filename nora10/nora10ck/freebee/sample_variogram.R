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

lakes <- comsat
## we will be using non-COMSAT lakes later so use "lakes" as name
nlakes <- nrow(lakes)

if (!file.exists('samplevariogram')) dir.create('samplevariogram')
pdf(sprintf('samplevariogram/%s_%s_sample_variogram_fit.pdf', varname, year))
for (nii in 1:length(chosen)) { # 1:ndays) {
  ni <- chosen[nii]
  cat(sprintf('%i of %i : %i', nii, choosethismany, ni))  ; cat('\n')
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
  
  ## interpolation type 1 "simple"
  ## 1a: nearest value
  i1a <-
    unlist(lapply(as.list(1:nlakes),
                  function(lakei) {
                    n10df@data[['v']][ranks[[lakei]] == 1]
                  }))
  ## 1b: mean of nearest four
  i1b <-
    unlist(lapply(as.list(1:nlakes),
                  function(lakei) {
                    mean(n10df@data[['v']][ranks[[lakei]] < 4])
                  }))
  ## 1c: triangular 2D linear interpolation
  i1c <-
    unlist(lapply(as.list(1:nlakes),
                  function(lakei) {
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
                    return(out)
                  }))

  ## scope 2 variogram (pan regional) SEE bb1
  n10n <- n10df[bb1, ]
  vario2 <- variogram(v ~ orog, n10n, cutoff = 100)



  
  

  ## co-kriging with elevation
  maxgamma <- max(vario[['gamma']])
  vf <- fit.variogram(vario,
                      vgm(maxgamma / 2, 'Sph', 50,
                          add.to = vgm(maxgamma / 2, 'Sph', 75, 
                            add.to = vgm(maxgamma / 2, 'Exp', 100,
                              add.to = vgm(maxgamma / 2, 'Gau', 100,
                                add.to = vgm(maxgamma / 2, 'Lin', 100,
                                  maxgamma / 2)))),
                      fit.sills = TRUE, fit.ranges = FALSE))
  vf.Lin <- fit.variogram(vario, vgm(maxgamma, 'Lin', 100),
                          fit.sills = TRUE, fit.ranges = FALSE)
  print(vf)
  plot(vario[['dist']], vario[['gamma']], type = 'p',
       ylim = c(0, maxgamma), xlim = c(0, 100),
       ylab = 'Semivariance', xlab = 'Distance',
       main = sprintf('%s (%s) time entry %04d', varname, year, ni))
  vfLine <- variogramLine(vf, 100)
  lines(vfLine[['dist']], vfLine[['gamma']])
  text(100, maxgamma / 10 * (((nrow(vf) + 1):1 - 1) / 2 + 0.5),
       labels = c(
         paste(sprintf('RMSE / max(gamma) : %02d %%',
                       as.integer(sqrt(attr(vf, 'SSErr') / nrow(vario)
                                       ) / maxgamma * 100)
                       )
               ),
         paste(vf[['model']],
               as.character(signif(vf[['psill']], digits = 2)),
               as.character(round(vf[['range']], digits = 0)),
               sprintf(': %02d %%', vf[['psill']] / maxgamma * 100)
               )
         ),
       pos = 2)
  abline(h = 0)
  ku10 <- krige(v ~ orog, n10n, comsat, vf, nmax = 10)
  ku30 <- krige(v ~ orog, n10n, comsat, vf, nmax = 30)
  ku50 <- krige(v ~ orog, n10n, comsat, vf, nmax = 50)
  ku100 <- krige(v ~ orog, n10n, comsat, vf, nmax = 100)
  ko10 <- krige(v ~ 1, n10n, comsat, vf, nmax = 10)
  ko30 <- krige(v ~ 1, n10n, comsat, vf, nmax = 30)
  ko50 <- krige(v ~ 1, n10n, comsat, vf, nmax = 50)
  ko100 <- krige(v ~ 1, n10n, comsat, vf, nmax = 100)
  kuL10 <- krige(v ~ orog, n10n, comsat, vf.Lin, nmax = 10)
  kuL30 <- krige(v ~ orog, n10n, comsat, vf.Lin, nmax = 30)
  kuL50 <- krige(v ~ orog, n10n, comsat, vf.Lin, nmax = 50)
  kuL100 <- krige(v ~ orog, n10n, comsat, vf.Lin, nmax = 100)
  koL10 <- krige(v ~ 1, n10n, comsat, vf.Lin, nmax = 10)
  koL30 <- krige(v ~ 1, n10n, comsat, vf.Lin, nmax = 30)
  koL50 <- krige(v ~ 1, n10n, comsat, vf.Lin, nmax = 50)
  koL100 <- krige(v ~ 1, n10n, comsat, vf.Lin, nmax = 100)
  predicted <- data.frame(lapply(
    list(ku10 = ku10, ku30 = ku30, ku50 = ku50, ku100 = ku100,
         ko10 = ko10, ko30 = ko30, ko50 = ko50, ko100 = ko100,
         kuL10 = kuL10, kuL30 = kuL30, kuL50 = kuL50, kuL100 = kuL100,
         koL10 = koL10, koL30 = koL30, koL50 = koL50, koL100 = koL100), 
    function(x) x@data[['var1.pred']]))
  pdf('testpredicted.pdf', height = 6, width = 6)
  ra <- range(c(predicted[-c(4, 8, 12, 16)], recursive = TRUE))
  plot(predicted[-c(4, 6:8, 9:16)],
       pch = 20, cex = 1,
       col = ifelse(comsat[['orog']] < 200, 'red',
         ifelse(comsat[['orog']] < 400, 'gray', 'blue')),
       xlim = ra, ylim = ra)
  dev.off()

  ## lake specific
  nn <- 100
  nlocal <- 10
  comsati <- 30
  ## example lake comsat[comsati, ]
  r <- rank(spDistsN1(n10df, comsat[comsati, ], longlat = TRUE))
  n10r <- n10df[r <= nn, ]
  ## 1. inverse distance
  kklm <- krige(v ~ 1, n10r, comsat[comsati, ], nmax = nlocal)
  ## 2. inverse distance weighted
  kklmw <- krige(v ~ orog, n10r, comsat[comsati, ], nmax = nlocal)
  ## 3.0 variogram
  vario <- variogram(v ~ orog, n10r)
  maxgamma <- max(vario[['gamma']])
  maxdist <- max(vario[['dist']])
  ## 3.1 kriging using variogram model "use everything"
  vf <- fit.variogram(vario,
                      vgm(maxgamma / 2, 'Sph', maxdist * 0.5,
                          add.to = vgm(maxgamma / 2, 'Sph', maxdist * 0.75, 
                            add.to = vgm(maxgamma / 2, 'Exp', maxdist,
                              add.to = vgm(maxgamma / 2, 'Gau', maxdist,
                                add.to = vgm(maxgamma / 2, 'Lin', maxdist,
                                  maxgamma / 2))))),
                      fit.sills = TRUE, fit.ranges = FALSE)
  ## 3.1.1 ordinary kriging (vgm: "fit everything")
  koE <- krige(v ~ 1, n10r, comsat[comsati, ], vf, nmax = nlocal)
  ## 3.1.2 universal kriging (co-krig with orog) (vgm: "fit everything")
  kuE <- krige(v ~ orog, n10r, comsat[comsati, ], vf, nmax = nlocal)
  ## 3.2 kriging using variogram model "linear"
  vfL <- fit.variogram(vario, vgm(maxgamma, 'Lin', maxdist), 
                       fit.sills = TRUE, fit.ranges = FALSE)  
  ## 3.2.1 ordinary kriging (vgm: "linear")
  koL <- krige(v ~ 1, n10r, comsat[comsati, ], vfL, nmax = nlocal)
  ## 3.2.2 universal kriging (co-krig with orog) (vgm: "linear")
  kuL <- krige(v ~ orog, n10r, comsat[comsati, ], vfL, nmax = nlocal)
  predicted.list <- list(kklm = kklm, kklmw = kklmw,
                         koE = koE, kuE = kuE, koL = koL, kuL = kuL)
  predicted <- unlist(lapply(predicted.list,
                             function(x) x@data[['var1.pred']]))
  print(predicted)
  print(vf)
  print(sqrt(attr(vf, 'SSErr') / nrow(vario)))
  print(vfL)
  print(sqrt(attr(vfL, 'SSErr') / nrow(vario)))
  
                      
  
  
  
                          
                          
  
  
  
  
}

dev.off()

  

  
