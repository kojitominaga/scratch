## usage: Rscript sample_variogram.R --args NORA10file

## nora10nc <- commandArgs(trailingOnly = TRUE)[2]
nora10nc <- 'NORA10_1H_11km_pr_2012.nc'
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

require(gstat)

nmax <- 10
pdf('pr.pdf')
for (ni in seq(from = 1, to = 8001, by = 250)) { # 1:ndays) {
  # cat(ni) ; cat('\n')
  if (ni %% 100 == 0) cat(sprintf('done %s times\n', ni))
  n10raw <- scan(sprintf('temp/%s/%s/%s_%04i.txt.bz2',
                         varname, year, nora10, ni - 1),
                 quiet = TRUE)
  n10df <- data.frame(lat, lon, v = n10raw, orog = orograw)
  coordinates(n10df) <- c('lon', 'lat')
  ## promotes orodf to SpatialPointsDataFrame
  proj4string(n10df) <- llCRS

  n10n <- n10df[bb1, ] # NORA10 weather variable "N"ear COMSAT

  ## co-kriging with elevation
  v2 <- variogram(v ~ orog, n10n, cutoff = 100)
  print(plot(v2, ylim = c(0, 2e-8)))
  ## vf2 <- fit.variogram(v2, vgm(500000, "Lin", 300, 1))
  ## k2 <- krige(v ~ orog, n10n, comsat, vf2, nmax = nmax)
  ## cokriging[ni, ] <- k2[['var1.pred']]
}

dev.off()

  

  
