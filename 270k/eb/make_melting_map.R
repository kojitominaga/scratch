require(sp)
require(rgdal)

  
geog <- read.csv('9k_geography.csv')
cats <- read.csv('category_sequence.csv')
names(cats)[1] <- 'ebint'
m <- merge(geog, cats, all=FALSE)

m[['cFullFull']] <- (m[['X22']] == 1) & (m[['X28']] == 1)
m[['cFullPart']] <- (m[['X22']] == 1) & (m[['X28']] > 1)
m[['cPartOpen']] <- (m[['X22']] < 6) & (m[['X28']] > 5)
m[['cOpenOpen']] <- (m[['X22']] > 5) & (m[['X28']] > 5)
m[['melting']] <- m[['cFullFull']] * 10 + m[['cFullPart']] * 20 +
  m[['cPartOpen']] * 30 + m[['cOpenOpen']] * 40

coordinates(m) <- ~longitude+latitude
proj4string(m) <- '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs'
writeOGR(m, '.', 'impact_map', 'ESRI Shapefile')

png('density_area.png')
d <- density(log10(m[['area']]))
dff <- density(log10(subset(m, cFullFull)[['area']]))
dfp <- density(log10(subset(m, cFullPart)[['area']]))
dpo <- density(log10(subset(m, cPartOpen)[['area']]))
doo <- density(log10(subset(m, cOpenOpen)[['area']]))
plot(d, ylim=c(0, 0.6), lwd=2,
     xlab='log10(area m2)', ylab='density', main='density distribution of surface area')
lines(dff, col='lightblue', lwd=2)
lines(dfp, col='blue', lwd=2)
lines(dpo, col='orange', lwd=2)
lines(doo, col='red', lwd=2)
legend('topright',
       legend=c('entire set', 
         'always -> always',
         'always -> sometimes',
         'sometimes -> never',
         'never -> never'),
       lwd=2,
       col=c('black', 'lightblue', 'blue', 'orange', 'red')
       )
dev.off()


png('density_depth.png')
d <- density(m[['maxdepth']])
dff <- density(subset(m, cFullFull)[['maxdepth']])
dfp <- density(subset(m, cFullPart)[['maxdepth']])
dpo <- density(subset(m, cPartOpen)[['maxdepth']])
doo <- density(subset(m, cOpenOpen)[['maxdepth']])
plot(d, ylim=c(0, 0.16), xlim=c(0, 50), lwd=2,
     xlab='maximum depth (m)', ylab='density', main='density distribution of maximum depth')
lines(dff, col='lightblue', lwd=2)
lines(dfp, col='blue', lwd=2)
lines(dpo, col='orange', lwd=2)
lines(doo, col='red', lwd=2)
legend('topright',
       legend=c('entire set', 
         'always -> always',
         'always -> sometimes',
         'sometimes -> never',
         'never -> never'),
       lwd=2,
       col=c('black', 'lightblue', 'blue', 'orange', 'red')
       )
dev.off()


