## portability and I/O speed up KT 10 June 2014


####################################################################
# Import and extract climate data for catchement polygons 
# from  saved in ".asc" format. climate data are in this example
# extrapolated and gridded dayliy temperature and mean average
# from ftp://ftpvm.met.no/projects/klimagrid/
# temperatures are in tenths of kelvin degreee 2731.5 = 273.15 K = 0 C 
# precipitation are in tenths of mm 123 = 12.3 mm
#
# Code revised 26.05.14 by AGF
#
#
####################################################################


##### import libraries #####
library(raster)
library(maptools)
library(rgdal)
require(RSAGA)

## import list of lakes 
lakes <- read.table("Soren/list_vatn_lnr_SL.txt", header=TRUE, sep='\t',
                    na.strings=c(' na', 'na'), as.is=TRUE)
lakes$GRIDCODE <- lakes$vatn_lnr

## KT: below 8 lines do it only once (shown here for pedigree notes)
##  importing shape files (catchments polygon data from NOSWE dataset) ####
## nbf <- readShapeSpatial("catchments/NOSWE_Catchments_somethingoddwithprojection.shp",
##                         proj4string=CRS("+proj=utm +zone=33 +datum=WGS84"))
## class(nbf) # checking objectclass
## ## subset catchment polygon layer with list of lakes 
## nbf.sub <- nbf[nbf$vatn_lnr %in% lakes$vatn_lnr, ]
## ## export subsettet polygon layer (uncomment if desirable)
## writeOGR(nbf.sub, "catchments", layer="nbf.sub", driver="ESRI Shapefile")

nbf.sub <- readOGR('catchments', 'nbf.sub')
nbf.sub.data <- slot(nbf.sub, 'data')

## head(nbf.sub.data)
## plot(nbf.sub) # visualization - do not run on large shapefiles (will take a long time to run)

# years and dates to be extracted,

# a) first generate dataframe with file names and year,mnt,day, date
#    (file names of met.no climate reasters contain information,
#     use substr function to extract date from filenames)

klimagriddir <- '../klimagrid'

rr.fns <- list.files(paste0(klimagriddir, '/rr'))
rr.fnroots <-
  unlist(lapply(strsplit(rr.fns, '.', fixed=TRUE), function(x) x[1]))
rr.fncomponents <- strsplit(rr.fnroots, '_', fixed=TRUE)
rr.year <-
  as.numeric(unlist(lapply(rr.fncomponents, function(x) as.numeric(x[2]))))
rr.mnt <-
  as.numeric(unlist(lapply(rr.fncomponents, function(x) as.numeric(x[3]))))
rr.day <-
  as.numeric(unlist(lapply(rr.fncomponents, function(x) as.numeric(x[4]))))

tm.fns <- list.files(paste0(klimagriddir, '/tam'))
tm.fnroots <-
  unlist(lapply(strsplit(tm.fns, '.', fixed=TRUE), function(x) x[1]))
tm.fncomponents <- strsplit(tm.fnroots, '_', fixed=TRUE)
tm.year <-
  as.numeric(unlist(lapply(tm.fncomponents, function(x) as.numeric(x[2]))))
tm.mnt <-
  as.numeric(unlist(lapply(tm.fncomponents, function(x) as.numeric(x[3]))))
tm.day <-
  as.numeric(unlist(lapply(tm.fncomponents, function(x) as.numeric(x[4]))))

rr.files <- data.frame(filename=rr.fns, year=rr.year, mnt=rr.mnt, day=rr.day)
tm.files <- data.frame(filename=tm.fns, year=tm.year, mnt=tm.mnt, day=tm.day)

if (!identical(rr.files[['rr.year']], tm.files[['tm.year']])) {
  stop('we need both rr and tm for all months')
} else if (!identical(rr.files[['rr.mnt']], tm.files[['tm.mnt']])) {
  stop('we need both rr and tm for all months')
} else if (!identical(rr.files[['rr.day']], tm.files[['tm.day']])) {
  stop('we need both rr and tm for all months')
} else {
  files <- data.frame(rr.fn=rr.fns, rr.fnroot=rr.fnroots,
                      tm.fn=tm.fns, tm.fnroot=tm.fnroots, 
                      year=tm.year, month=tm.mnt, day=tm.day,
                      stringsAsFactors=FALSE)
}

files[['date']] <- as.Date(ISOdate(files[['year']], files[['month']], files[['day']]))

# b) subsetting based on dates 

# vector of dates to include in analyses
dates.inn <- seq(from=as.Date('1957-01-01'), to=as.Date('2012-12-31'),
                 by='day')
files.inn <- files[files[['date']] %in% dates.inn, ]

##################################################################
# extracting climatic data 
#################################################################

rr <- matrix(NA, nrow=nrow(files.inn), ncol=nrow(nbf.sub))
dimnames(rr) <- list(sprintf('%s-%02d-%02d',
                             files.inn[['year']],
                             files.inn[['month']],
                             files.inn[['day']]),
                     nbf.sub[['lake_id']])
names(dimnames(rr)) <- c('date', 'vatn_lnr')
rr2 <- rr
tm <- rr
## vatn_lnr <- numeric()
## year <- numeric()
## mnt <- numeric()

# starting loop 
for (i in 1:nrow(files.inn)) {
  fn <- sprintf('%s/rr/%s', klimagriddir, files.inn[['rr.fn']][i])
  cat(fn) ; cat('\n')
  f <- unz(fn, filename=sprintf('%s.asc', files.inn[['rr.fnroot']][i]), open='r')
  a <- read.ascii.grid(f)
  close(f)
  h <- a[['header']]
  ra1 <- raster(a[['data']],
                xmn=h[['xllcorner']],
                ymn=h[['yllcorner']],
                xmx=(h[['xllcorner']] + h[['cellsize']] * h[['ncols']]),
                ymx=(h[['yllcorner']] + h[['cellsize']] * h[['nrows']]),
                crs=CRS("+proj=utm +zone=33 +datum=WGS84"))
  ## rr2[i, ] <- extract(ra1, nbf.sub, small=TRUE,
  ##                    fun=function(x, na.rm=FALSE) {x[is.na(x)] <- 0 ; mean(x)},
  ##                    na.rm=FALSE)
  rr[i, ] <- extract(ra1, nbf.sub, small=TRUE, fun=mean, na.rm=TRUE)
  ## tempraster2 <- raster('../klimagrid/rrmth/rrmth_1957_01.asc',
  ##                       proj4string=CRS("+proj=utm +zone=33 +datum=WGS84"))
  ## sum1 <- extract(ra1, nbf.sub, small=TRUE, fun=sum, na.rm=TRUE)
  ## n1 <- extract(ra1, nbf.sub, small=TRUE, function(x) length(x), na.rm=FALSE)
  ## rr[i, ] <- sum1 / n1
  
  fn <- sprintf('%s/tam/%s', klimagriddir, files.inn[['tm.fn']][i])
  cat(fn) ; cat('\n')
  f <- unz(fn, filename=sprintf('%s.asc', files.inn[['tm.fnroot']][i]), open='r')
  a <- read.ascii.grid(f)
  close(f)
  h <- a[['header']]
  ra1 <- raster(a[['data']],
                xmn=h[['xllcorner']],
                ymn=h[['yllcorner']],
                xmx=(h[['xllcorner']] + h[['cellsize']] * h[['ncols']]),
                ymx=(h[['yllcorner']] + h[['cellsize']] * h[['nrows']]),
                crs=CRS("+proj=utm +zone=33 +datum=WGS84"))
  tm[i, ] <- extract(ra1, nbf.sub, small=TRUE, fun=mean, na.rm=TRUE)
}
write.table(rr, file = 'rr.txt')
write.table(tm, file = 'tam.txt')

rrdf <- as.data.frame.table(rr, dnn=c('date', 'vatn_lnr'),
                            responseName='rr', stringsAsFactors=FALSE)
tmdf <- as.data.frame.table(tm, dnn=c('date', 'vatn_lnr'),
                            responseName='tam', stringsAsFactors=FALSE)
m2 <- merge(rrdf, tmdf, all=TRUE)
components <- strsplit(m2[['date']], '-', fixed=TRUE)
m2[['year']] <- as.numeric(unlist(lapply(components, function(x) x[1])))
m2[['month']] <- as.numeric(unlist(lapply(components, function(x) x[2])))
m2[['day']] <- as.numeric(unlist(lapply(components, function(x) x[3])))
m2[['vatn_lnr']] <- as.numeric(m2[['vatn_lnr']])
write.table(m2, 'clim.out.txt', row.names=FALSE)
