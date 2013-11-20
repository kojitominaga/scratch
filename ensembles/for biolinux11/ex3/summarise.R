source('flakedream2.R')
load('meta/dcs.RData')
load('meta/defaults.RData')
savepaths <- sprintf('dream/%s.RData', names(dcs))
dd <- list()
for (di in 1:length(savepaths)) {
  savepath <- savepaths[di]
  cat(savepath)
  cat('\n')
  load(savepath) ## loads "d"
  dd[[di]] <- d
}

codastats <- lapply(
  dd, function(x) c(summary(window(x))[1:2], recursive = TRUE))

write.table(t(as.matrix(data.frame(codastats))), file = 'test.txt',
            row.names = FALSE)

pdf(height = 11, width = 7)
par(mfrow = c(7, 3))
par(mar = c(2, 4, 1, 0))
for (di in 1:length(savepaths)) {
  hist(c(window(dd[[di]]), recursive = TRUE),
       breaks = c(0, seq(from = 995.5, to = 1004.5, by = 1), 10000),
       xlim = c(995.5, 1004.5),
       ylim = c(0, 1 / 1),
       freq = FALSE,
       ylab = names(dcs)[di],
       main = '', 
       col = 'lightblue',
       border = 'blue'
       )
  hist(c(window(dd[[di]]), recursive = TRUE),
       breaks = c(0, seq(from = 982, to = 1018, by = 4), 10000),
       xlim = c(982, 1018),
       ylim = c(0, 1 / 4),
       freq = FALSE,
       ylab = '', 
       main = '', 
       col = 'lightblue',
       border = 'blue'
       )
  hist(c(window(dd[[di]]), recursive = TRUE),
       breaks = c(0, seq(from = 910, to = 1090, by = 20), 10000),
       xlim = c(910, 1090), 
       ylim = c(0, 1 / 20),
       freq = FALSE, 
       ylab = '',
       main = '', 
       col = 'lightblue',
       border = 'blue'
       )
}
dev.off()
