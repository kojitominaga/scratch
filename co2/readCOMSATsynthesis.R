dataraw <- read.table('comsat/COMSAT 2011 synthesis.txt',
                   header = TRUE, sep = ' ')
data <- dataraw[!is.na(dataraw[['Temperature']]), ]
## removing one lake without the data

ids <- data[['ID']]
inputfns <- sprintf('input_%05d.txt', ids)
outputfns <- sprintf('output_%05d.txt', ids)

for (li in 1:length(ids)) {  # li lake index (not ID)
  inputfn <- inputfns[li]
  outputfn <- outputfns[li]
  cat('DATABASE phreeqc-2.18.3/database/phreeqc.dat\n',
      file = inputfn)
  cat('SOLUTION 1\n',
      file = inputfn, append = TRUE)
  cat(sprintf('    temp %f\n', data[['Temperature']][li]),
      file = inputfn, append = TRUE)
  cat(sprintf('    pH %f\n', data[['pH']][li]),
      file = inputfn, append = TRUE)
  cat('    pe 4\n    redox pe\n    units umol/kgw\n    density 1\n',
      file = inputfn, append = TRUE)
  cat(sprintf('    C %f\n', data[['TIC']][li] / 1000 / 12 * 1000000),
      file = inputfn, append = TRUE)
  cat('    -water 1 # kg\n',
      file = inputfn, append = TRUE)
}



## create a linux batch file
bf <- 'batch.sh' # batch file name
commandphreeqc <- 'phreeqc-2.18.3/bin/phreeqc'
cat('## batch file for phreeqc for 76 (not 77) COMSAT lakes\n\n', file = bf)
for (li in 1:length(ids)) {  # li lake index (not ID)
  inputfn <- inputfns[li]
  outputfn <- outputfns[li]
  cat(commandphreeqc, file = bf, append = TRUE)
  cat(' ', file = bf, append = TRUE)
  cat(inputfn, file = bf, append = TRUE)
  cat(' ', file = bf, append = TRUE)
  cat(outputfn, file = bf, append = TRUE)
  cat(' \n', file = bf, append = TRUE)
}
  
  



