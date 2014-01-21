require(sp)

source('readCOMSAT.R')

oroglat <- orogdf@coords[, 2]
oroglon <- orogdf@coords[, 1]

## boundary box near comsat
bb1 <- (oroglat > comsatwraplat[1]) &
  (oroglat < comsatwraplat[2]) &
  (oroglon > comsatwraplon[1]) &
  (oroglon < comsatwraplon[2])

plot(orogdf[bb1,], pch = 19, cex = 0.2, col = 'gray')
points(comsat, pch = 19)

## pts <- list('sp.points', comsat, pch = 19, col = 'black')
## spplot(orogdf[bb1, ]['orog'], pch = 19, cex = 0.4,
##        cuts = c(0, 0.4, 300, 600, 900, 1200, 1500, 1800),
##        col.regions = rainbow(7),
##        main = "NORA10 vertices and COMSAT lakes",
##        colorkey = TRUE,
##        sp.layout = list(pts))

## example1
psl0000raw <- scan('data/NORA10_1H_11km_psl_2011_0000.txt')
psl0000df <- data.frame(lat, lon, psl = psl0000raw, orog = orograw)
coordinates(psl0000df) <- c('lon', 'lat')
## promotes orodf to SpatialPointsDataFrame
proj4string(psl0000df) <- llCRS

require(gstat)

psln <- psl0000df[bb1, ]

## 1: simple kriging (spatial only)
v1 <- variogram(psl ~ 1, psln)
vf1 <- fit.variogram(v1, vgm(500000, 'Exp', 500, 1))
k1 <- krige(psl ~ 1, psln, comsat, vf1, nmax = nmax)
psl1 <- k1[['var1.pred']]

## 2: co-kriging with elevation
v2 <- variogram(psl ~ orog, psln)
vf2 <- fit.variogram(v2, vgm(500000, "Lin", 300, 1))
k2 <- krige(psl ~ orog, psln, comsat, vf2, nmax = nmax)
psl2 <- k2[['var1.pred']]

## 3: mean of nearest four
psl3 <- numeric()
for (i in 1:nrow(comsat)) {
  r <- rank(spDistsN1(psln, comsat[i, ], longlat = TRUE))
  nearest4 <- psln[r < 5, ]
  psl3[i] <- mean(nearest4[['psl']])
}

## 4: near-three plane interpolation
psl4 <- numeric()
for (i in 1:nrow(comsat)) {
  r <- rank(spDistsN1(psln, comsat[i, ], longlat = TRUE))
  cx <- coordinates(comsat[i, ])[1, 1]
  cy <- coordinates(comsat[i, ])[1, 2]
  n1 <- psln[r == 1, ]
  n1x <- coordinates(n1)[1, 1]
  n1y <- coordinates(n1)[1, 2]
  n2 <- psln[r == 2, ]
  n2x <- coordinates(n2)[1, 1]
  n2y <- coordinates(n2)[1, 2]
  n3 <- psln[r == 3, ]
  n3x <- coordinates(n3)[1, 1]
  n3y <- coordinates(n3)[1, 2]
  ## now say, p1|n2(x, y) - n1(x, y)| + p2|n3(x, y) - n1(x, y)] = c(x, y)
  p2 <- ((cy - n1y) * (n2x - n1x) / (n2y - n1y) - (cx - n1x)) /
    ((n3y - n1y) * (n2x - n1x) / (n2y - n1y) - (n3x - n1x))
  p1 <- ((cx - n1x) - p2 * (n3x - n1x)) / (n2x - n1x)
  ## p1a <- ((cy - n1y) - p2 * (n3y - n1y)) / (n2y - n1y)
  ## p1a should be the same as p1
  psl4[i] <- n1[['psl']] +
    p1 * (n2[['psl']] - n1[['psl']]) +
    p2 * (n3[['psl']] - n1[['psl']]) 
}

pdf(sprintf('comparison of interpolation methods %s.pdf', nmax))
plot(data.frame(psl3, psl4, psl1, psl2), pch = 19, cex = 0.4)
dev.off()
  
  

  
