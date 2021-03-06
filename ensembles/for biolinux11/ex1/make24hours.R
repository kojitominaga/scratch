require(flakeutil)

ensemblename <- './'

folders <- list.dirs()
lat <- read.table('lat.txt') # y (NS) by x (EW) !!!
lon <- read.table('lon.txt')

for (fi in 1:length(folders)) {
  temp <- strsplit(folders[fi], '/')[[1]]
  folder <- temp[length(temp)]
  cat('\n')
  cat(folder)
  cat('\n')
  rootpath <- folders[fi]
  temp2 <- strsplit(folder, '-')[[1]]
  x <- as.integer(temp2[1])
  y <- as.integer(temp2[2])
  
  if (is.na(x)) {
    ## if 'x' is not number, e.g., './' -- it is not a folder like '093-082'
    next
  }
  
  cond1 <- file.exists(paste0(rootpath, '/', 'tas24.csv.gz'))
  cond2 <- file.exists(paste0(rootpath, '/', 'rsds24.csv.gz'))
  if (cond1 & cond2) next
  ## skip already made input
  
  thislon <- lon[y + 1, x + 1]
  thislat <- lat[y + 1, x + 1]
  
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
    ta <-
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
        ta <- rep(tas[dayi2], times = m)
        return(ta)
      }, warning = function(msg) {
        f <- file('warnings', open = 'a')
        cat(c(folder, ':', dayi, print(day), '\n',
              tasmin[dayi2], tasmax[dayi2], tas[dayi2],
              '\n', str(msg), '--\n'),
            file = f)
        close(f)
        ta <- rep(tas[dayi2], times = m)        
        return(ta)
      })
    tain[1:m + (dayi - 1) * m] <- ta
    previousT <- ta[24]
  }
  cat('writing files...\n')
  rsds24f <- gzfile(paste0(rootpath, '/', 'rsds24.csv.gz'), open = 'wb')
  
  ## following 3 convoluted expressions
  ## due to error: signif(NA)
  ## ifelse() doesn't work because it still evaluates the "else" part
  ## causing the above problem
  out <- rep(NA, times = length(iatmin))
  test <- is.na(iatmin)
  out[!test] <- signif(iatmin[!test], digits = 4)
  
  cat(out, file = rsds24f, sep = '\n')
  close(rsds24f)

  tas24f <- gzfile(paste0(rootpath, '/', 'tas24.csv.gz'), open = 'wb')


  ## see above for the iatmin and problem of signif(NA) and ifelse()
  out <- rep(NA, times = length(tain))
  test <- is.na(tain)
  out[!test] <- signif(tain[!test], digits = 4)

  cat(out, file = tas24f, sep = '\n')
  close(tas24f)
}

  
  
