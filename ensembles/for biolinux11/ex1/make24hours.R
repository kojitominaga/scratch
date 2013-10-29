require(flakeutil)

ensemblename <- './'

folders <- list.dirs()
lat <- read.table('lat.txt') # x (north) by y (east)
lon <- read.table('lon.txt')

for (fi in 1:length(folders)) {
  temp <- strsplit(folders[fi], '/')[[1]]
  folder <- temp[length(temp)]
  cat('\n')
  cat(folder)
  cat('\n')
  temp2 <- strsplit(folder, '-')[[1]]
  x <- as.integer(temp2[1])
  y <- as.integer(temp2[2])
  if (is.na(x)) {
    ## if 'x' is not number, e.g., './' -- it is not a folder like '093-082'
    next
  }
  thislat <- lat[x + 1, y + 1]
  thislon <- lon[x + 1, y + 1]
  
  rootpath <- folders[fi]
  firstday <- as.Date('1991-01-01')
  lastday <- as.Date('2000-12-31')
  dayseq <- seq(from = firstday, to = lastday, by = 'day')

  rsds <- scan(paste0(rootpath, '/', 'rsds.csv.gz'))
  tas <- scan(paste0(rootpath, '/', 'tas.csv.gz'))
  tasmax <- scan(paste0(rootpath, '/', 'tasmax.csv.gz'))
  tasmin <- scan(paste0(rootpath, '/', 'tasmin.csv.gz'))

  n <- length(rsds)
  m <- 24

  ## solar radiation (sw) 24-hourize
  iatmin <- numeric()
  for (dayi in 1:length(dayseq)) {
    if (dayi %% 1000 == 0) {
      cat(paste('... making solar radiation of day', dayi, ':',
                round(dayi / n * 100),
                'percent done\n'))
    }
    day <- dayseq[dayi]
    frac <-
      tryCatch({
        FractionalRadiation(day, thislat, thislon, m) * rsds[dayi] * m
      }, error = function(msg) {
        f <- file('errors', open = 'a')
        cat(c(folder, ':', dayi, print(day), '\n', str(msg), '--\n'),
            file = f)
        cat('unelegant repeat of global radiation\n--\n', file = f)
        close(f)
        frac <- rep(rsds[dayi], times = m)
        return(frac)
      }, warning = function(msg) {
        f <- file('warnings', open = 'a')
        cat(c(folder, ':', dayi, print(day), '\n', str(msg), '--\n'),
            file = f)
        close(f)
        return(frac)
      })
    iatmin[1:m + (dayi - 1) * m] <- frac
  }
  ## air temperature 24-hourzize
  tain <- numeric()
  previousT <- tas[1]
  for (dayi in 1:length(dayseq)) {
    if (dayi %% 1000 == 0) {
      cat(paste('... making temperature of day', dayi, ':',
                round(dayi / n * 100),
                'percent done\n'))
    }
    day <- dayseq[dayi]
    if (dayi == length(dayseq)) dayi2 <- dayi - 1 else dayi2 <- dayi
    temp <-
      tryCatch({
        HourlyAirTemperature(day, thislat, thislon, previousT,
                             tasmin[dayi2], tasmax[dayi2], tas[dayi2],
                             tasmin[dayi2 + 1], tasmax[dayi2 + 1], m)
      }, error = function(msg) {
        f <- file('errors', open = 'a')
        print(str(msg))
        cat(c(folder, ':', dayi, print(day), '\n',
              tasmin[dayi2], tasmax[dayi2], tas[dayi2],
              '\n', str(msg), '--\n'),
            file = f)
        cat('unelegant repeat of daily air temperature\n--\n', file = f)
        close(f)
        temp <- rep(tas[dayi2], times = m)
        return(temp)
      }, warning = function(msg) {
        f <- file('warnings', open = 'a')
        cat(c(folder, ':', dayi, print(day), '\n',
              tasmin[dayi2], tasmax[dayi2], tas[dayi2],
              '\n', str(msg), '--\n'),
            file = f)
        close(f)
        return(temp)
      })
    tain[1:m + (dayi - 1) * m] <- temp
    previousT <- temp[24]
  }
  cat('writing files...\n')
  rsds24f <- gzfile(paste0(rootpath, '/', 'rsds24.csv.gz'), open = 'wb')
  cat(ifelse(is.na(iatmin), NA, signif(iatmin, digits = 4)),
      file = rsds24f, sep = '\n')
  close(rsds24f)
  tas24f <- gzfile(paste0(rootpath, '/', 'tas24.csv.gz'), open = 'wb')
  cat(ifelse(is.na(tain), NA, signif(tain, digits = 4)),
      file = tas24f, sep = '\n')
  close(tas24f)
}

  
  
