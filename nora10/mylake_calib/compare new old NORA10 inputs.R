new <- read.csv('csv/parameters_utf8.csv')
old <- read.csv('csv_old/parameters_utf8.csv')
m1 <- merge(new, old, all=TRUE, by='id')
pdf('new NORA10 inputs fit statistics.pdf', height = 6, width = 11)
par(mfrow=c(1, 2))
plot(m1[['min_rmsd.y']], m1[['min_rmsd.x']],
     pch=19, col='#44444444', 
     xlab='best RMSD using wrong NORA10',
     ylab='best RMSD using correct NORA10',
     main='COMSAT lakes temperature profile fit (deg C)', 
     xlim = c(0, 4),
     ylim = c(0, 4))
abline(a = 0, b = 1)
plot(m1[['min_abs_bias.y']], m1[['min_abs_bias.x']],
     pch=19, col='#44444444',
     xlab='best abs(bias) using wrong NORA10',
     ylab='best abs(bias) using correct NORA10',
     main='COMSAT lakes temperature profile fit (deg C)', 
     xlim = c(0, 3),
     ylim = c(0, 3))
abline(a = 0, b = 1)
dev.off()
