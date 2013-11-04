require(flakeutil)

dnames <- list.dirs(".", recursive = FALSE)
for (di in 1:length(dnames)) {
  dname <- dnames[di]
  cat('--\n')
  cat(paste(di, 'of', length(dnames), ':', dname, '\n'))
  dmfname <- paste0(dname, '/csv/dm_simple.csv.bz2')
  if (!file.exists(dmfname)) {
    cat('FLake result file dm_simple.csv.bz2 does not exist\n')
    next
  }
  dm <- read.csv(dmfname)

  cat('Calculating Lake Analyzer indicators\n')
  m <- 24
  parameters <- c(10, 1000, 0.5,
                  NA, ## this will be fine for this application only
                  sin(60 / 180 * pi) * 2 * 7.29e-5,
                  60 * 60 * 24 / m,
                  0, 0.8, 0.8)
  names(parameters) <-
    c('depth_w', 'fetch', 'depth_bs', 'T_bs', 'par_Coriolis', 'del_time',
      'albedo_water', 'albedo_ice', 'albedo_snow')
  depths <- seq(from = 0, to = parameters[['depth_w']], by = 0.1)
  bthA <- (1000 * (parameters[['depth_w']] - depths) /
           parameters[['depth_w']]) ^ 2 * pi

  thislais <-
    tryCatch({
      LAIndices(dm, parameters, bthA, depths)
      }, error = function(msg) {
        f <- file('errors', open = 'a')
        cat(c(dname, ':', '\n', str(msg), '--\n'),
            file = f)
        cat('failed to calculate Lake Analyzer Indices\n--\n', file = f)
        close(f)
        thislais <- data.frame(ThermoclineDepth = rep(NA, times = nrow(dm)),
                               MixedLayerDepth = rep(NA, times = nrow(dm)),
                               SchmidtStability = rep(NA, times = nrow(dm)),
                               WedderburnNumber = rep(NA, times = nrow(dm)),
                               LakeNumber = rep(NA, times = nrow(dm))
                               )
        return(thislais)
      }, warning = function(msg) {
        f <- file('warnings', open = 'a')
        cat(c(dname, ':', dayi, print(day), '\n', str(msg), '--\n'),
            file = f)
        close(f)
        return(thislais)
      })
  thislais[['ThermoclineDepth']] <-
    round(thislais[['ThermoclineDepth']], digits = 3)
  thislais[['MixedLayerDepth']] <-
    round(thislais[['MixedLayerDepth']], digits = 3)
  thislais[['SchmidtStability']] <-
    signif(thislais[['SchmidtStability']], digits = 4)
  thislais[['WedderburnNumber']] <-
    signif(thislais[['WedderburnNumber']], digits = 4)
  thislais[['LakeNumber']] <-
    signif(thislais[['LakeNumber']], digits = 4)
  
  laisfname <- paste0(dname, '/csv/dm_simple_lais.csv.bz2')
  laisf <- bzfile(laisfname, open = 'wb')
  write.csv(thislais, file = laisf)
  close(laisf)
}

