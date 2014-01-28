## usage: Rscript spatial_interpolation.R --args NORA10file

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
near3plane <- matrix(NA, nrow = ndays, ncol = nrow(comsat))
cokriging <- matrix(NA, nrow = ndays, ncol = nrow(comsat))

require(gstat)

nmax <- 10

cat('now interpolating...\n')
for (ni in 1:ndays) {
  if (ni %% 100 == 0) cat(sprintf('done %s times\n', ni))
  n10raw <- scan(sprintf('temp/%s/%s/%s_%04i.txt.bz2',
                         varname, year, nora10, ni - 1),
                 quiet = TRUE)
  n10df <- data.frame(lat, lon, v = n10raw, orog = orograw)
  coordinates(n10df) <- c('lon', 'lat')
  ## promotes orodf to SpatialPointsDataFrame
  proj4string(n10df) <- llCRS

  n10n <- n10df[bb1, ] # NORA10 weather variable "N"ear COMSAT

  ## near-thre plane interpolation
  n10n3 <- numeric()
  for (i in 1:nrow(comsat)) {
    r <- rank(spDistsN1(n10n, comsat[i, ], longlat = TRUE))
    cx <- coordinates(comsat[i, ])[1, 1]
    cy <- coordinates(comsat[i, ])[1, 2]
    n1 <- n10n[r == 1, ]
    n1x <- coordinates(n1)[1, 1]
    n1y <- coordinates(n1)[1, 2]
    n2 <- n10n[r == 2, ]
    n2x <- coordinates(n2)[1, 1]
    n2y <- coordinates(n2)[1, 2]
    n3 <- n10n[r == 3, ]
    n3x <- coordinates(n3)[1, 1]
    n3y <- coordinates(n3)[1, 2]
    ## now say, p1|n2(x, y) - n1(x, y)| + p2|n3(x, y) - n1(x, y)] = c(x, y)
    p2 <- ((cy - n1y) * (n2x - n1x) / (n2y - n1y) - (cx - n1x)) /
      ((n3y - n1y) * (n2x - n1x) / (n2y - n1y) - (n3x - n1x))
    p1 <- ((cx - n1x) - p2 * (n3x - n1x)) / (n2x - n1x)
    ## p1a <- ((cy - n1y) - p2 * (n3y - n1y)) / (n2y - n1y)
    ## p1a should be the same as p1
    n10n3[i] <- n1[['v']] +
      p1 * (n2[['v']] - n1[['v']]) +
        p2 * (n3[['v']] - n1[['v']]) 
  }
  near3plane[ni, ] <- n10n3

  ## co-kriging with elevation
  v2 <- variogram(v ~ orog, n10n)
  vf2 <- fit.variogram(v2, vgm(500000, "Lin", 300, 1))
  k2 <- krige(v ~ orog, n10n, comsat, vf2, nmax = nmax)
  cokriging[ni, ] <- k2[['var1.pred']]
}

near3planef <-
  gzfile(sprintf('interpolated/%s_interp_for_COMSAT_near3.csv.gz', nora10))
write.table(round(near3plane, digits = signifdigit),
            file = near3planef,
            row.names = FALSE,
            col.names = paste0('id', comsat[['ID']]),
            sep = ',')
cokrigingf <-
  gzfile(sprintf('interpolated/%s_interp_for_COMSAT_cokrig.csv.gz', nora10))
write.table(round(cokriging, digits = signifdigit), 
            file = cokrigingf,
            row.names = FALSE,
            col.names = paste0('id', comsat[['ID']]),
            sep = ',')


  

  
