name <- 'Grunnaai'
year <- 2007

p1 <- 'interpolated/pred'

albedo <- read.csv(sprintf('%s/albedo/NORA10_1H_11km_albedo_%s_%s.csv.gz',
                           p1, year, name))
hur <- read.csv(sprintf('%s/hur_2m/NORA10_1H_11km_hur_2m_%s_%s.csv.gz',
                        p1, year, name))
pr <- read.csv(sprintf('%s/pr/NORA10_1H_11km_pr_%s_%s.csv.gz',
                       p1, year, name))
psl <- read.csv(sprintf('%s/psl/NORA10_1H_11km_psl_%s_%s.csv.gz',
                        p1, year, name))
ps <- read.csv(sprintf('%s/ps/NORA10_3H_11km_ps_%s_%s.csv.gz',
                       p1, year, name))
rls <- read.csv(sprintf('%s/rls/NORA10_3H_11km_rls_%s_%s.csv.gz',
                        p1, year, name))
rss <- read.csv(sprintf('%s/rss/NORA10_3H_11km_rss_%s_%s.csv.gz',
                        p1, year, name))
ta <- read.csv(sprintf('%s/ta_2m/NORA10_1H_11km_ta_2m_%s_%s.csv.gz',
                       p1, year, name))
ts <- read.csv(sprintf('%s/ts_0m/NORA10_1H_11km_ts_0m_%s_%s.csv.gz',
                       p1, year, name))
wss <- read.csv(sprintf('%s/wss_10m/NORA10_1H_11km_wss_10m_%s_%s.csv.gz',
                        p1, year, name))

rls3 <- data.frame(lapply(rls, rep, each = 3))

## missing cloud cover - calculate according to what MyLake does inside
tac <- ta - 273.15
ew <- (1 + 1e-6 * 1020 * (4.5 + 0.0006 * (tac) ^ 2)) *
  (10 ^ ((0.7859 + 0.03477 * tac) / (1 + 0.00412 * tac)))# use C
r <- (hur / 100) * 0.62197 * ew / (1020 - ew)
ea <- r * 1020 / (0.62197 + r)

fc <- (rls3 + 4 * 0.985 * 5.6697e-8 * (ta ^ 3) * (ts - ta)) /
  (-0.985 * 5.6697e-8 * (ta ^ 4) * (0.39 - 0.05 * sqrt(ea))) # use K
a1 <- 0.76
cc <- (1 - fc) / a1

cc <- 0.6
fc <- 1 - a1 * cc
rls <- (-0.985 * 5.6697e-8 * (ta ^ 4) * (0.39 - 0.05 * sqrt(ea)) * fc) - 4 * 0.985 * 5.6697e-8 * (ta ^ 3) * (ts - ta)





nora <- list(albedo = albedo,
             hur = hur,
             pr = pr,
             psl = psl,
             ps = ps,
             rls = rls,
             rss = rss,
             ta = ta,
             ts = ts,
             wss = wss)

plot1 <- function(df1, varname) { # data.frame
  ra <- range(as.matrix(df1), na.rm = TRUE)
  if (!file.exists('png')) dir.create('png')
  png(sprintf('png/comparison of interpolation methods %s %s %s.png',
              name, year, varname),
      width = 1920, height = 1920, pointsize = 24)
  plot(df1, range = ra, cex = 0.3, col = '#11111111', pch = 19)
  dev.off()
}

for (vi in 1:length(nora)) {
  plot1(nora[[vi]], names(nora)[vi])
}

plot2 <- function(df1, varname, days = 1:(24 * 7)) {
  ra <- range(as.matrix(df1[days, ]), na.rm = TRUE)
  print(ra)
  if (!file.exists('png')) dir.create('png')
  png(sprintf('png/sampledays %s %s %s.png',
              name, year, varname),
      width = 1920, height = 960, pointsize = 24)
  plot(days, rep(0, times = length(days)), type = 'n',
       ylim = ra, xlim = c(min(days), max(days) + 10),  # + 4 for legends
       xlab = 'sample time points', ylab = varname)
  for (ii in 1:ncol(df1)) {
    lines(days, df1[days, ii],
          col = rainbow(ncol(df1))[ii],
          lty = ii,
          lwd = 2)
  }
  legend('topright', legend = names(df1),
         lwd = 2, lty = 1:ncol(df1), col = rainbow(ncol(df1)),
         bty = 'n')
  dev.off()
}

for (vi in 1:length(nora)) {
  plot2(nora[[vi]], names(nora)[vi])
}


            

## plot(0, 0, type = 'n', xlim = c(1, 1000), ylim = range(as.matrix(albedo)))
## for (ii in 1:ncol(albedo)) {
##   lines(1:1000, albedo[1:1000, ii])
## }

