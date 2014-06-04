require(RNetCDF)

fname <-'mrros_EUR-11_ICHEC-EC-EARTH_rcp85_r3i1p1_DMI-HIRHAM5_v1_day_20960101-21001231.nc'

fnameroot <- strsplit(fname, '.nc')[[1]][1]
r <- open.nc(fname)
data <- read.nc(r)

varname <- strsplit(fname, '_')[[1]][1]  ## varname <- 'ta' etc. 
v <- data[[varname]]

## example
meanvalues <- apply(v, 1:2, mean) ## takes computation time
write.csv(meanvalues, file = paste0(fnameroot, '_meanvalues.csv'))
