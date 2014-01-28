years <- 1988:2012
vars <- c('albedo', 'hur_2m', 'pr', 'psl', 'ta_2m', 'wss_10m',
          'ps', 'rls', 'rss')
tresolutions <- c(rep('1H', times = 6), rep('3H', times = 3))
varlongnames <- c('Surface albedo',
                  '2-meter relative humidity',
                  'Predipitation (kg m-2 s-1)',
                  'Mean sea level pressure (Pa)',
                  '2-meter temperature (K)',
                  '10-meter wind speed (m s-1)',
                  'Surface pressure (Pa)',
                  'Net LW surface radiation (W m-2)',
                  'Net SW surface radiation (W m-2)')

for (vi in 1:length(vars)) {
  fnamesc <- paste0('NORA10_', tresolutions[vi], '_11km_', vars[vi],
                    '_', years, '_interp_for_COMSAT_cokrig.csv.gz')
  fnamesn <- paste0('NORA10_', tresolutions[vi], '_11km_', vars[vi],
                    '_', years, '_interp_for_COMSAT_near3.csv.gz')
  pngfn <- paste0(vars[vi], '.png')
  datac <- lapply(fnamesc, read.csv)
  datan <- lapply(fnamesn, read.csv)
  data <- data.frame(cokrig = unlist(lapply(datac, c, recursive = TRUE)),
                     near3 = unlist(lapply(datan, c, recursive = TRUE)))
  ra <- range(c(data, recursive = TRUE))
  png(pngfn, width = 960, height = 960, pointsize = 24)
  plot(data[['cokrig']], data[['near3']], type = 'p', pch = 19, 
       main = vars[vi],
       xlab = 'Co-kriging by elevation (nearest 10)',
       ylab = 'Near-three plane interpolation')
  dev.off()
}

  

  
