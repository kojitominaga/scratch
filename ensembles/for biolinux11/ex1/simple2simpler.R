require(flakeutil)

dnames <- list.dirs(".", recursive = FALSE)
for (di in 1:length(dnames)) {
  dname <- dnames[di]
  cat('--\n')
  cat(paste(di, 'of', length(dnames), ':', dname, '\n'))
  dmfname <- paste0(dname, '/csv/dm_simple.csv.xz')
  if (!file.exists(dmfname)) {
    cat('FLake result file dm_simple.csv.xz does not exist\n')
    next
  }
  dm <- read.csv(dmfname)
  cat('Calculating Lake Analyzer indicators\n')
  depths <- seq(from = 0, to = parameters[['depth_w']], by = 0.1)
  bthA <- (1000 * (parameters[['depth_w']] - depths) /
           parameters[['depth_w']]) ^ 2 * pi
  thislais <-
    tryCatch({
      LAIndices(result0, parameters, bthA, depths)
      }, error = function(msg) {
        f <- file('errors', open = 'a')
        cat(c(dname, ':', '\n', str(msg), '--\n'),
            file = f)
        cat('failed to calculate Lake Analyzer Indices\n--\n', file = f)
        close(f)
        thislais <- data.frame(ThermoclineDepth = rep(NA, times = nrow(result0)),
                               MixedLayerDepth = rep(NA, times = nrow(result0)),
                               SchmidtStability = rep(NA, times = nrow(result0)),
                               WedderburnNumber = rep(NA, times = nrow(result0)),
                               LakeNumber = rep(NA, times = nrow(result0))
                               )
        return(thislais)
      }, warning = function(msg) {
        f <- file('warnings', open = 'a')
        cat(c(dname, ':', dayi, print(day), '\n', str(msg), '--\n'),
            file = f)
        close(f)
        return(thislais)
      })
  laisfname <- paste0(dname, '/csv/dm_simple_lais.csv.xz')
  laisf <- xzfile(laisfname, open = 'wb')
  write.csv(thislais, file = laisf)
}

