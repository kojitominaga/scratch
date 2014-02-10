load("test_rmc.RData")

dates <- as.Date(dimnames(results)[[6]])
datesiso <- as.POSIXlt(dates)
month <- datesiso$mon + 1 # 1 = January, 2 = Feburary
dow <- datesiso$wday # 0 = Sunday, 1 = Monday
year <- datesiso$year + 1900
datei <- (dow == 1) & (month > 3) & (month < 10) & (year > 1992)
results2 <- results[ , , , , , datei]
dates2 <- dates[datei]
nd <- sum(datei)
print(nd)
print(dates2)

delimiter <- '\t'
  
fn <- file('table.txt',
           open = 'at' # append text mode
           )

cat(paste('date',
          'basin',
          'MyLakeParameters',
          'LAKETEMP',
          'LAKETHERMCLINEDEPTH',
          'LAKESECCHIDEPTH',
          'LAKETP',
          'LAKEPIP',
          'LAKEPOP',
          'LAKEDIP',
          'LAKEDOP',
          'irradiance',
          sep = delimiter
          ),
    file = fn)
cat('\n', file = fn) # , append = TRUE)

for (bi in 1:(dim(results)[1])) {
   for (pi in 1:(dim(results)[2])) {
        out <- data.frame(matrix(NA, nrow = nd, ncol = 12))
        out[ , 1] <- dates2
        out[ , 2] <- bi
        out[ , 3] <- pi
        out[ , 4:12] <- round(t(results2[bi, pi, , ]), digits = 2)
        out[ , 12] <- round(out[ , 12])
        write.table(out, file = fn,
                    # append = TRUE,
                    quote = FALSE,
                    sep = delimiter,
                    row.names = FALSE, col.names = FALSE
                    )
      }
}

close(fn)