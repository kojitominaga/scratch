require(flakeutil)

runsimple <- function(dirname) {
  cat(dirname)
  cat('\n')
  fnameaffix <- 'simple'

  firstday <- as.Date('1991-01-01')
  lastday <- as.Date('2000-12-31')
  dayseq <- seq(from = firstday, to = lastday, by = 'day')
  dayseqP <- as.POSIXlt(dayseq)

  pr <- scan(paste0(dirname, '/', 'pr.csv.gz'))
  rlds <- scan(paste0(dirname, '/', 'rlds.csv.gz'))
  wss <- scan(paste0(dirname, '/', 'wss.csv.gz'))
  huss <- scan(paste0(dirname, '/', 'huss.csv.gz'))
  ps <- scan(paste0(dirname, '/', 'ps.csv.gz'))

  rootpath24 <- './'
  rsds24 <- scan(paste0(dirname, '/', 'rsds24.csv.gz'))
  tas24 <- scan(paste0(dirname, '/', 'tas24.csv.gz'))
  
  height_u <- 10
  height_tq <- 2
  
  n <- length(pr)
  m <- 24
  initialrepeat <- 2
  
  ts.input0 <- data.frame(dMsnowdt_in = rep(pr, each = m),
                          I_atm_in = rsds24,
                          Q_atm_lw_in = rep(rlds, each = m),
                          height_u_in = rep(rep(height_u, times = n),
                            each = m),
                          height_tq_in = rep(rep(height_tq, times = n),
                            each = m),
                          U_a_in = rep(wss, each = m),
                          T_a_in = tas24,
                          q_a_in = rep(huss, each = m),
                          P_a_in = rep(ps, each = m)
                          )
  ts.input <- ts.input0[c(rep(1:(m * 365), times = initialrepeat), 1:(n * m)), ]
  initiali <- 1:(m * 365 * initialrepeat)
  
  parameters <- c(10, 1000, 0.5,
                  mean(ts.input[['T_a_in']]),
                  sin(60 / 180 * pi) * 2 * 7.29e-5,
                  60 * 60 * 24 / m,
                  0, 0.8, 0.8)
  names(parameters) <-
    c('depth_w', 'fetch', 'depth_bs', 'T_bs', 'par_Coriolis', 'del_time',
      'albedo_water', 'albedo_ice', 'albedo_snow')
  
  init.state <-
    c(0 + 273.15, 0 + 273.15, 4 + 273.15, 4 + 273.15, 4 + 273.15, 5 + 273.15,
      0.5, 0, 0, parameters[['depth_w']], 0.4, 4 + 273.15)
  names(init.state) <-
    c('T_snow', 'T_ice', 'T_mnw', 'T_wML', 'T_bot', 'T_B1',
      'C_T', 'h_snow', 'h_ice', 'h_ML', 'H_B1', 'T_sfc')
  
  optic <- c(2, 20, 20)
  names(optic) <- paste('extincoef_', c('water', 'ice', 'snow'), sep = '')

  cat('Running FLake\n')
  result0 <- data.frame(ts.input,
                        runflake(ts.input, parameters, init.state, optic)
                        )[-initiali, ]
  depths <- seq(from = 0, to = parameters[['depth_w']], by = 0.1)
  bthA <- (1000 * (parameters[['depth_w']] - depths) /
           parameters[['depth_w']]) ^ 2 * pi
  cat('Calculating Lake Analyzer indicators\n')
  result <- data.frame(result0,
                       LAIndices(result0, parameters, bthA, depths))
  fullnames2 <- c(fullnames,
                  c('Thermocline depth',
                    'Mixed layer depth',
                    'Schmidt stability',
                    'Wederburn number',
                    'Lake number'
                    )
                  )
    
  cat('Calculating daily mean\n')
  dm <- apply(result, 2, tapply,
              rep(1:(n * m), each = 24, length.out = nrow(result)),
              mean)

  cat('Writing out files\n')  
  
  if (!file.exists(paste0(dirname, '/csv'))) dir.create(paste0(dirname, '/csv'))
  
  c <- xzfile(paste0(dirname, '/csv/dm_', fnameaffix, '.csv.xz'),
              open = 'wb')
  write.csv(data.frame(date = dayseq, signif(dm, digits = 4)), file = c)
  close(c)
  
  typicalyear <- apply(dm, 2, tapply, dayseqP$yday, mean)[1:365, ]
  ## 1:365 makes it ignore 31 Dec in leap years

  c <- xzfile(paste0(dirname, '/csv/typicalyear_', fnameaffix, '.csv.xz'),
              open = 'wb')
  write.csv(data.frame(MonthDay = format(seq(from = as.Date('1999-01-01'),
                         to = as.Date('1999-12-31'),
                         by = 'day'), ## need any non-leap year
                         format = '%m-%d'),
                       signif(typicalyear, digits = 4)), 
            file = c)
  close(c)
  
  shortnames <- names(result)
  if (!file.exists(paste0(dirname, '/pdf'))) dir.create(paste0(dirname, '/pdf'))
  pdf(paste0(dirname, '/pdf/allvariables_dm_', fnameaffix, '.pdf'), 
      height = 7.5, width = 11.5)
  par(mfcol = c(3, 3))
  par(mar = c(2, 3, 3, 1))
  for (vi in 1:ncol(typicalyear)) {
    plot(seq(from = as.Date('1999-01-01'),
             to = as.Date('1999-12-31'),
             by = 'day'),
         typicalyear[1:365, vi],
         type = 'l',
         xlab = 'month',
         ylab = '',
         main = fullnames2[vi],
         cex.main = 1,
         xaxt = 'n')
    axis.Date(1,
              at = seq(from = as.Date('1999-01-01'),
                to = as.Date('1999-12-01'),
                by = 'month'),
              labels = c('J', 'F', 'M', 'A', 'M', 'J',
                'J', 'A', 'S', 'O', 'N', 'D')
              )
  }
  dev.off()
}  

## main loops
folders <- list.dirs()
for (fi in 1:length(folders)) {
  temp <- strsplit(folders[fi], '/')[[1]]
  folder <- temp[length(temp)]
  temp2 <- strsplit(folder, '-')[[1]]
  x <- as.integer(temp2[1])
  y <- as.integer(temp2[2])
  if (is.na(x)) {
    ## if 'x' is not number, e.g., './' -- it is not a folder like '093-082'
    cat('-------------------------\n')
    cat('skipping the folder ')
    cat(folder)
    cat('\n-------------------------\n')
    next
  }  
  cat('-- Running the folder ')
  cat(folder)
  cat(' --\n')
  runsimple(folder)
}
  
  
