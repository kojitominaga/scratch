
shapename <- 'n1k_elevation'
shapename2 <- 'n1k_elevation2'
outcsv <- 'n1k_AR5_a_model.csv'
RDataname <- 'n1k.RData'
suffix <- 'pred_n1k'
length1 <- 1002
## shapename <- 'regin_elevation'
## outcsv <- 'regin_AR5_a_model.csv'
## RDataname <- 'regin.RData'
## suffix <- 'pred_regin'
## length1 <- 19477

varnames <- c('mrros', 'tas', 'pr', 'tasmin', 'tasmax')
varnames2 <- c('tmin01', 'tmin02', 'tmin03', 'tmin12',
               'tmax06', 'tmax07', 'tmax08', 'tmax09')
enames <- c('historical', 'rcp45', 'rcp85')
yearlist <- list(1961:2005, c(2006:2020, 2061:2100), c(2006:2020, 2061:2100))
names(yearlist) <- enames
reportrange <- list(1961:1990, 2071:2100, 2071:2100)
names(reportrange) <- enames

alist1 <- list()
for (varname in c(varnames, varnames2)) {
  alist1[[varname]] <- list()
  for (ename in enames) {
    alist1[[varname]][[ename]] <-
      as.data.frame(array(NA, dim=c(length1, length(yearlist[[ename]]))))
    names(alist1[[varname]][[ename]]) <- yearlist[[ename]]
  }
}

fnames <- list.files('csv')
fnames1 <- fnames[grepl(suffix, fnames, fixed=TRUE)]
for (fn in fnames1) {
  result <- read.csv(sprintf('csv/%s', fn), row.names=1)
  vn <- strsplit(fn, '_')[[1]][1]
  en <- strsplit(fn, '_')[[1]][2]
  yearrange <- strsplit(fn, '_')[[1]][3]
  startystr <- substr(strsplit(yearrange, '-')[[1]][1], 1, 4)
  endystr <- substr(strsplit(yearrange, '-')[[1]][2], 1, 4)
  years <- as.character(as.integer(startystr):as.integer(endystr))
  if (vn == 'tasmin') {
    for (yeari in 1:length(years)) {
      alist1[['tmin01']][[en]][[years[yeari]]] <- result[[(yeari - 1) * 4 + 1]]
      alist1[['tmin02']][[en]][[years[yeari]]] <- result[[(yeari - 1) * 4 + 2]]
      alist1[['tmin03']][[en]][[years[yeari]]] <- result[[(yeari - 1) * 4 + 3]]
      alist1[['tmin12']][[en]][[years[yeari]]] <-  result[[(yeari - 1) * 4 + 4]]
    }
  } else if (vn == 'tasmax') {
    for (yeari in 1:length(years)) {
      alist1[['tmax06']][[en]][[years[yeari]]] <- result[[(yeari - 1) * 4 + 1]]
      alist1[['tmax07']][[en]][[years[yeari]]] <- result[[(yeari - 1) * 4 + 2]]
      alist1[['tmax08']][[en]][[years[yeari]]] <- result[[(yeari - 1) * 4 + 3]]
      alist1[['tmax09']][[en]][[years[yeari]]] <- result[[(yeari - 1) * 4 + 4]]
    }
  } else {
    for (yeari in 1:length(years)) {
      alist1[[vn]][[en]][[years[yeari]]] <- result[[yeari]]
    }
  }
}

## find which month is the coldest
minmonthi <- integer()
maxmonthi <- integer()
for (ri in 1:length1) {
  reporti <- yearlist[['historical']] %in% reportrange[['historical']]
  tmin <- data.frame(
    tmin01=c(alist1[['tmin01']][['historical']][ri, reporti], recursive=TRUE), 
    tmin02=c(alist1[['tmin02']][['historical']][ri, reporti], recursive=TRUE), 
    tmin03=c(alist1[['tmin03']][['historical']][ri, reporti], recursive=TRUE), 
    tmin12=c(alist1[['tmin12']][['historical']][ri, reporti], recursive=TRUE))
  tmax <- data.frame(
    tmax06=c(alist1[['tmax06']][['historical']][ri, reporti], recursive=TRUE), 
    tmax07=c(alist1[['tmax07']][['historical']][ri, reporti], recursive=TRUE), 
    tmax08=c(alist1[['tmax08']][['historical']][ri, reporti], recursive=TRUE), 
    tmax09=c(alist1[['tmax09']][['historical']][ri, reporti], recursive=TRUE))
  tminmean <- apply(tmin, 2, mean)
  tmaxmean <- apply(tmax, 2, mean)
  thisisminmonth <- which(tminmean == min(tminmean))
  thisismaxmonth <- which(tmaxmean == max(tmaxmean))
  minmonthi[ri] <- ifelse(is.null(thisisminmonth), NA, thisisminmonth)
  maxmonthi[ri] <- ifelse(is.null(thisismaxmonth), NA, thisismaxmonth)
}
for (ri in 1:length1) {
  if (!is.na(minmonthi[ri])) {
    alist1[['tasmin']] <-
      alist1[[c('tmin01', 'tmin02', 'tmin03', 'tmin12')[minmonthi[ri]]]]
  }
  if (!is.na(maxmonthi[ri])) {
    alist1[['tasmax']] <-
      alist1[[c('tmax06', 'tmax07', 'tmax08', 'tmax09')[maxmonthi[ri]]]]
  }
}
save(alist1, minmonthi, maxmonthi, file = RDataname)

report <- as.data.frame(matrix(NA, nrow=length1, ncol=0))
for (varname in varnames) {
  for (ename in enames) {
    colname <- sprintf('%s_%s_%s_%s', varname, ename,
                       min(reportrange[[ename]]), max(reportrange[[ename]]))
    toaggregate <- yearlist[[ename]] %in% reportrange[[ename]]
    report[[colname]] <-
      apply(alist1[[varname]][[ename]][ , toaggregate], 1,
            function(x) { ifelse(any(is.na(x)), NA, mean(pmax(x, 0))) })
  }
}
for (ename in enames) {
  report[[sprintf('trange_%s_%s_%s', ename,
                  min(reportrange[[ename]]), max(reportrange[[ename]]))]] <-
    report[[sprintf('tasmax_%s_%s_%s', ename,
                    min(reportrange[[ename]]), max(reportrange[[ename]]))]] -
     report[[sprintf('tasmin_%s_%s_%s', ename,
                      min(reportrange[[ename]]), max(reportrange[[ename]]))]]
}
report[['tmin_month_historical_1961_1990']] <-
  factor(c('Jan', 'Feb', 'Mar', 'Dec')[minmonthi])
report[['tmax_month_historical_1961_1990']] <-
  factor(c('Jun', 'Jul', 'Aug', 'Sep')[minmonthi])

require(rgdal)
require(sp)
n1k <- readOGR('shp', shapename)
report <- data.frame(n1k@data, report)
write.csv(report, file = outcsv)
