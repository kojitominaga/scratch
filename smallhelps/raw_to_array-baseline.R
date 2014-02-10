dates <- seq(from = as.Date('1990-04-01'), ##1990-04-01
             to = as.Date('2012-09-25'), ## 2012-09-25
             by = 'day'
             )

## initialise the data set
results <- array(NA, dim = c(2, 1, 1, 60, 9, length(dates)))
dimnames(results) <- list(c('Storefjorden', 'Vanemfjorden'),
                          c('HistWeath'),
                          c('HistManage'),
                          paste('MyLakePar', 1:60),
                          c('temperature',  # 1
                            'thermocline',  # 2
                            'secchi',       # 3
                            'totalP',       # 4 
                            'PIP',          # 5
                            'POP',          # 6
                            'DIP',          # 7
                            'DOP',          # 8
                            'irradiance'    # 9
                            ),
                          as.character(dates)
                          )
ies80 <- c(999.842594,
           6.793952e-2,
           -9.09529e-3,
           1.001685e-4,
           -1.120083e-6,
           6.536332e-9
           )
thermoclinedepth <- function(depthprofile, resolution = 1, threshold = 0.01) {
  rho <- (ies80[1] +
          ies80[2] * depthprofile +
          ies80[3] * depthprofile ^ 2 + 
          ies80[4] * depthprofile ^ 3 + 
          ies80[5] * depthprofile ^ 4 + 
          ies80[6] * depthprofile ^ 5
          )
  drho <- c(0, abs(rho[1:(length(rho) - 1)] - rho[2:length(rho)]))
  zz <- seq(from = 0, by = resolution, length.out = length(depthprofile))
  return(sum((drho * zz)[drho > threshold]) / sum(drho[drho > threshold]))
}
secchidepth <- function(lightattenprofile, resolution = 1, constant = 1.7) {
  di <- 1
  while((di * resolution) < (constant / mean(lightattenprofile[1:di]))) {
    di <- di + 1
  }
  return(constant / mean(lightattenprofile[1:di]))
}
  
notgood <- list()
  
## reading in files
for (bi in 1:(dim(results)[1])) {
  print(dimnames(results)[[1]][bi])
  weightsfn <- paste('MyLake_inputs/MyLake_',
                     c('Storefjorden/posterior_parameters',
                       'Vanemfjorden/posterior_parameters_using_median_INCA-P'
                       ),
                     '/weightforuniqueresampledparameters.csv',
                     sep = ''
                   )[bi]
  print(weightsfn)
  weights <- scan(weightsfn)
  print(weights)
  for (ci in 1:(dim(results)[2])) {
    for (mi in 1:(dim(results)[3])) {
      pii <- 1
      for (pi in 1:length(weights)) {
        path <- sprintf('%s_Scenarios/runs/%03d-c%s_m%s/',
                        dimnames(results)[[1]][bi], pi, ci, mi)
        print(path)
        temporary <- array(NA, dim = c(9, length(dates)))
        ## check that files exist
        if (!file.exists(paste(path, 'totalP.csv.bz2', sep = ''))) {
          print('This simulation failed')
          notgood[[length(notgood) + 1]] <- c(bi, ci, mi, pi) # append info
        } else {
          temporary[1, ] <-
            scan(paste(path, 'temperature.csv.bz2', sep = ''), quiet = TRUE)
          temporary[4, ] <-
            scan(paste(path, 'totalP.csv.bz2', sep = ''), quiet = TRUE)
          temporary[6, ] <-
            scan(paste(path, 'POP.csv.bz2', sep = ''), quiet = TRUE)
          temporary[7, ] <-
            scan(paste(path, 'DIP.csv.bz2', sep = ''), quiet = TRUE)
          temporary[8, ] <-
            scan(paste(path, 'DOP.csv.bz2', sep = ''), quiet = TRUE)
          temporary[9, ] <-
            read.table(paste(path, 'Qst.csv.bz2', sep = ''), sep = ',')[, 1]
          temporary[5, ] <-
            scan(paste(path, 'POPandPIP.csv.bz2', sep = ''), quiet = TRUE) -
              temporary[6, ]
          temp2d <-
            read.table(paste(path, 'temperaturedepths.csv.bz2', sep = ''),
                       sep = ','
                       )
          temporary[2, ] <-
            apply(temp2d, 1, thermoclinedepth)
          atten2d <-
            read.table(paste(path, 'lightattenuationdepths.csv.bz2', sep = ''),
                       sep = ','
                       )
          temporary[3, ] <-
            apply(atten2d, 1, secchidepth)
        }
        count <- 1
        theweight <- weights[pi]
        while(count <= theweight) {
          print(c(pii, count, theweight))
          results[bi, ci, mi, pii, , ] <- temporary
          pii <- pii + 1
          count <- count + 1
        }
      }
    }
  }
}

save(results, file = 'test_rmc.RData')
