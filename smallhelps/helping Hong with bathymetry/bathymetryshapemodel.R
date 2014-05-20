data <- read.csv('SwedishBathymetryCollated.csv')

lakenames <- unique(data[['lakeid']])
bmodel1 <- numeric()
bmodel2 <- numeric()


pdf('test.pdf')
par(mfcol = c(3, 3))

smallnumber <- 1e-3  # 0.001
for (namei in 1:length(lakenames)) {
  sub <- subset(data, lakeid == lakenames[namei])
  if (nrow(sub) <= 2) {
    next
    b[namei] <- NA
  }
  model1 <- lm(log10(fractionalarea) ~ log10(oneminusZdmdivZmaxdm + smallnumber),
               data = sub)
  model2 <- lm(log10(fractionalarea) ~ log10(oneminusZdmdivZmaxdm),
               data = sub[-nrow(sub), ])
  plot(log10(sub[['oneminusZdmdivZmaxdm']] + smallnumber),
       log10(sub[['fractionalarea']]),
       xlab = 'Az/A0',
       ylab = '1 - dz/dz(max)',
       main = lakenames[namei],
       pch = 19, 
       col = ifelse(1:nrow(sub) == nrow(sub), 'blue', 'darkgray'))
  abline(model1)
  abline(model2, col = 'red')
  bmodel1[namei] <- coefficients(model1)[2]
  bmodel2[namei] <- coefficients(model2)[2]
}

dev.off()
out <- data.frame(lakenames, bmodel1, bmodel2)
write.csv(out, file = 'b.csv')




  
