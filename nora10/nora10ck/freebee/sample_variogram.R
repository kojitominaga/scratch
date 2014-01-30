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

## boundary box near comsat
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

  n10n <- n10df[bb1, ] # NORA10 weather variable "N"ear COMSAT

  ## co-kriging with elevation
  v <- variogram(v ~ orog, n10n, cutoff = 100)
  maxgamma <- max(v[['gamma']])
  LinNug <- vgm(maxgamma, 'Lin', 100, 0.01 * maxgamma)
  LinNug2 <- vgm(maxgamma / 2, 'Lin', 100, 0.01 * maxgamma)
  Lin <- vgm(maxgamma, 'Lin', 100)
  vf <- switch(
    varname,
    'ta_2m' = fit.variogram(v, Lin,
      fit.sills = TRUE, fit.ranges = FALSE),
    'pr' = fit.variogram(v,
      vgm(maxgamma / 2, 'Sph', 50,
          add.to = vgm(maxgamma / 2, 'Sph', 75, 
            add.to = vgm(maxgamma / 2, 'Exp', 100,
              add.to = vgm(maxgamma / 2, 'Gau', 100,
                add.to = LinNug2)))),
      fit.sills = TRUE, fit.ranges = FALSE)
    )
  print(vf)
  plot(v[['dist']], v[['gamma']], type = 'p',
       ylim = c(0, maxgamma), xlim = c(0, 100),
       ylab = 'Semivariance', xlab = 'Distance',
       main = sprintf('%s (%s) time entry %04d', varname, year, ni))
  vfLine <- variogramLine(vf, 100)
  lines(vfLine[['dist']], vfLine[['gamma']])
  text(100, maxgamma / 10 * (((nrow(vf) + 1):1 - 1) / 2 + 0.5),
       labels = c(
         paste(sprintf('RMSE / max(gamma) : %02d %%',
                       as.integer(sqrt(attr(vf, 'SSErr') / nrow(v)
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
  ## k2 <- krige(v ~ orog, n10n, comsat, vf2, nmax = nmax)
  ## cokriging[ni, ] <- k2[['var1.pred']]
}

dev.off()

  

  
