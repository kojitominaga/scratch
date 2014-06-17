require(abind)

fnames <- as.list(paste0(1957:2013, '.RData'))
byyear <- lapply(fnames, function(x) {load(x) ; return(out)})
byyear[['along']] <- 1
concatenated <- do.call(abind, byyear)
names(dimnames(concatenated)) <- c('date', 'variable', 'vatn_lnr')
varnames <- dimnames(concatenated)[[2]]
datalist <- list()
for (varname in varnames) {
  thedata <- concatenated[ , which(varnames == varname), ]
  datalist[[varname]] <- thedata
  f <- gzfile(sprintf('%s (be careful with columns).txt.gz', varname), 'w')
  write.table(as.data.frame(thedata), f)
  close(f)
}
flattened <- as.data.frame.table(concatenated, responseName='value')
f <- gzfile('flattened (be careful with columns).txt.gz', 'w')
write.table(flattened, f, row.names=FALSE)
close(f)

datalistflattened <- lapply(datalist, as.data.frame.table, responseName='value')
for (varname in varnames) {
  names(datalistflattened[[varname]])[3] <- varname
}
datalistdate <- datalistflattened[[1]][['date']]
datalistvatnlnr<- datalistflattened[[1]][['vatn_lnr']]
datalistflattened2 <- lapply(datalistflattened, function(x) x[3])
datalistflattened2[['date']] <- datalistdate
datalistflattened2[['vatn_lnr']] <- datalistvatnlnr
flattened2 <- do.call(data.frame, datalistflattened2)
f <- gzfile('flattened2 (be careful with columns).txt.gz', 'w')
write.table(flattened2, f, row.names=FALSE)
close(f)

## example for getting annual means
date <- as.Date(datalistdate)
year <- as.integer(format(date, "%Y"))
fullyears <- date < as.Date('2014-01-01') ## year 2014 is not complete
c2 <- flattened2[fullyears, ]
date2 <- date[fullyears]
year2 <- year[fullyears]
annualmeans <- lapply(as.list(c2)[1:13], tapply,
                      list(year2, c2[['vatn_lnr']]), mean, na.rm=TRUE)

for (varname in varnames) {
  f <- gzfile(sprintf('%s annual means (be careful with columns).txt.gz',
                      varname), 'w')
  write.table(as.data.frame(annualmeans[[varname]]), f)
  write.csv(as.data.frame(annualmeans[[varname]]),
            sprintf('%s annual.csv', varname))
  close(f)
}

## example for getting monthly means
month <- as.integer(format(date, "%m"))
fullyears <- date < as.Date('2014-01-01') ## year 2014 is not complete
c2 <- flattened2[fullyears, ]
month2 <- month[fullyears]
monthlymeans <- lapply(as.list(c2)[1:13], tapply,
                       list(month2, c2[['vatn_lnr']]), mean, na.rm=TRUE)
for (varname in varnames) {
  f <- gzfile(sprintf('%s monthly means (be careful with columns).txt.gz',
                      varname), 'w')
  write.table(as.data.frame(monthlymeans[[varname]]), f)
  write.csv(as.data.frame(monthlymeans[[varname]]),
            sprintf('%s montly.csv', varname))
  close(f)
}


## example for getting annual means in the multidimensional array
date3 <- as.Date(dimnames(concatenated)[[1]])
year3.0 <- as.integer(format(date3, "%Y"))
fullyear3 <- date3 < as.Date('2014-01-01') ## year 2014 is not complete
c3 <- concatenated[fullyear3, , ]
year3 <- year3.0[fullyear3]
annualmeans3 <- apply(c3, 2:3, tapply, year3, mean, na.rm=TRUE)
## use this as wish - example below

## > str(annualmeans3)
##  num [1:48, 1:11, 1:78] 0.364 0.427 0.509 0.609 0.496 ...
##  - attr(*, "dimnames")=List of 3
##   ..$         : chr [1:48] "1957" "1958" "1959" "1960" ...
##   ..$ variable: chr [1:11] "eva" "frd" "gwt" "is" ...
##   ..$ vatn_lnr: chr [1:78] "23386" "10127" "10926" "14367" ...
## > annualmeans3[1:5, 1:5, 1:5]
## , , vatn_lnr = 23386

##       variable
##              eva       frd       gwt       is       os
##   1957 0.3644160  93.21507 104.06321 15.44263 15.27073
##   1958 0.4268168 152.29346  95.83486 13.30888 13.06500
##   1959 0.5094247 119.14117  92.40284 13.13479 12.81481
##   1960 0.6089567 102.56042  85.12220 10.70258 10.25335
##   1961 0.4959980  87.74056 101.21865 15.76425 15.48574

## , , vatn_lnr = 10127

##       variable
##             eva      frd      gwt       is       os
##   1957 1.538795 37.35755 68.86132 3.583986 2.555260
##   1958 1.500000 65.39666 54.37004 3.912630 2.865712
##   1959 1.348452 48.20174 58.24155 4.751795 3.753384
##   1960 1.469631 51.56426 61.64534 3.822964 2.767650
##   1961 1.598863 55.43725 68.73286 4.929890 3.807507

## , , vatn_lnr = 10926

##       variable
##             eva      frd      gwt       is       os
##   1957 1.496740 33.53460 75.72467 4.530479 3.441753
##   1958 1.454959 66.85847 64.63732 5.342836 4.265178
##   1959 1.394959 46.95060 67.54236 5.948630 4.906726
##   1960 1.452254 56.60903 74.95235 6.195533 5.108757
##   1961 1.640110 36.91258 82.00103 6.034397 4.825329

## , , vatn_lnr = 14367

##       variable
##              eva       frd      gwt       is       os
##   1957 1.0412123 101.24712 59.27702 4.627212 3.826589
##   1958 1.0799452  78.59437 54.08668 3.628500 2.800151
##   1959 0.9144247  74.48079 46.12955 3.497041 2.741185
##   1960 1.0917623 117.64107 56.41199 4.828436 3.984952
##   1961 1.1711575  97.89878 64.11362 5.943562 5.054192

## , , vatn_lnr = 40322

##       variable
##              eva       frd      gwt       is       os
##   1957 0.7634047 117.90550 61.74968 4.279716 3.657198
##   1958 0.8644085 165.56904 59.95465 4.358379 3.698854
##   1959 0.9391108  60.91993 68.87079 3.904022 3.184991
##   1960 0.9017437 117.70074 54.54151 2.873927 2.149466
##   1961 0.9772379 103.08747 69.63982 5.550463 4.735088
