## setwd ("C:/Hong Yang/Work01/SWEDEN/BathymetryMaps/bathymetry.tar/bathymetry/helping Hong with bathymetry")
## getwd()

require(sp)
require(rgdal)

data <- read.csv('SwedishBathymetryCollatedFixed2.csv')

lakenames <- unique(data[['lakeid']])
utm33n <- CRS('+proj=utm +zone=33 +ellps=WGS84 +datum=WGS84 +units=m +no_defs')

model2a <- numeric()
model2b <- numeric()
model3b <- numeric()
surfacearea <- numeric()
maximumdepth <- numeric()
volumebyDM <- numeric()
meandepthbyDM <- numeric()
perimeterfromshp <- numeric()

pdf()
## png(height = 1440, width = 1440)
par(mfcol = c(3, 3))

smallnumber <- 1e-3  # 0.001
for (namei in 1:length(lakenames)) {
  sub <- subset(data, lakeid == lakenames[namei])
  if (nrow(sub) <= 2) {
    next
    b[namei] <- NA
  }
  ## ## model1: with the bottom as a small area (0.1 percent)
  ## model1 <- lm(log10(cumsumfraction) ~ log10(oneminusZdmdivZmaxdm + smallnumber),
  ##              data = sub)
  
  ## model2: with intercept USING also the origin (0, 0) as part of regression
  ## discussion 26th May 2014
  model2 <- lm(log10(cumsumfraction) ~ log10(oneminusZdivZmax),
               data = sub)
  ## model3: forcing intercept zero, NOT using the origin (0, 0) as part of regression       
  model3 <- lm(log10(cumsumfraction) ~ log10(oneminusZdivZmax) - 1,
               data = sub[-1, ])               
  plot(log10(sub[['oneminusZdivZmax']]),
       log10(sub[['cumsumfraction']]),
       xlab = 'log10(1 - dz/dz(max))',
       ylab = 'log10(Az/A0), cumulative',
       main = lakenames[namei],
       pch = 19)
  abline(h = 0, col = 'gray')
  abline(v = 0, col = 'gray')
  abline(model3, col = 'chocolate', lwd = 2)
  abline(model2, col = 'red')
  model2a[namei] <- coefficients(model2)[1]
  model2b[namei] <- coefficients(model2)[2]
  model3b[namei] <- coefficients(model3)[1]
  surfacearea[namei] <- max(sub[['cumsumarea']])
  maximumdepth[namei] <- max(sub[['d2']])
  volumebyDM[namei] <- sum(sub[['dm']] * sub[['area']]) # m3
  meandepthbyDM[namei] <- volumebyDM[namei] / surfacearea[namei]
  lakeid <- strsplit(as.character(lakenames[namei]), 'SW', fixed = TRUE)[[1]][2]
  p <- readOGR(paste0('SwedishBathymetry/', lakeid), lakeid)
  p.utm33n <- spTransform(p, utm33n)
  perimeterfromshp[namei] <- max(p.utm33n@data[['PERIMETER']])
}

dev.off()
out <- data.frame(lakenames, model2a, model2b, model3b, maximumdepth, meandepthbyDM,
                  volumebyDM, surfacearea, perimeterfromshp)
write.csv(out, file = 'SW lake basin slope parameters.csv', row.names = FALSE)




  
