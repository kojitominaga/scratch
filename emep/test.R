require(sp)
require(gstat)

emep <- read.table('data/webdabData135929.txt.gz', skip = 2,
                   header = FALSE, sep = ';')
names(emep) <- c('V1', 'year', 'V3', 'variable', 'i', 'j', 'unit', 'value')
ts95 <- subset(emep, (year == 1995) & (variable == 'total ox. sulphur'))
coordinates
