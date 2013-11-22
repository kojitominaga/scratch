source('flakedream2.R')
require(dream)

load('meta/dcs.RData')
load('meta/dcsshort.RData')
load('meta/defaults.RData')
load('meta/defaultsshort.RData')
load('meta/savepathsshort.RData')
savepaths <- sprintf('dream/%s.RData', names(dcs))

summarise.dir <- function(dir) {
  dir <- sub('/', '', dir)
  print(dir)
  files <- list.files(dir, pattern = '.RData', full.names = TRUE)
  dcnames <-
    c(lapply(strsplit(c(lapply(strsplit(files, '/', fixed = TRUE),
                               function(x) x[length(x)]
                               ),
                        recursive = TRUE
                        ),
                      '.RData', fixed = TRUE),
             function(x) x[length(x)]
           ),
      recursive = TRUE
      )
  ## in python dcnames = [f.split('/')[-1].split('.RData')[-2] for f in files]
      
  dd <- list()
  pdf(sprintf('summary_%s.pdf', dir), height = 11, width = 7)
  par(mfcol = c(7, 3))
  par(mar = c(2, 4, 2, 1))
  for (fi in 1:length(files)) {
    fname <- files[fi]
    cat(fname)
    cat('\n')
    load(fname)
    dd[[fi]] <- d
    hist(c(window(d), recursive = TRUE),
         breaks = c(0, seq(from = 300, to = 10300, by = 500), 10000),
         xlim = c(300, 10000),
         ylim = c(0, 1 / 500),
         freq = FALSE,
         ylab = dcnames[fi],
         xlab = '', 
         main = paste(dcs[[dcnames[fi]]], collapse = ' '), 
         col = 'lightblue',
         border = 'blue'
         )
  }
  dev.off()
  codastats <- lapply(
    dd, function(x) c(summary(window(x))[1:2], recursive = TRUE))
  
  
  write.csv(data.frame(t(as.matrix(data.frame(codastats)))),
            file = sprintf('summary_%s.csv', dir),
            row.names = dcnames)
  
  
}
