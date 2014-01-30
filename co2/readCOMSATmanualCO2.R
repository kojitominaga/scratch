TICM = data[['TIC_UMB']] / 1000000
pK1 = 6.35
pK2 = 10.33

HCO3 = TICM / (1 / 10 ^ (data[['pH']] - pK1) + 1 + 10 ^ (data[['pH']] - pK2))
CO2 = HCO3 / (10 ^ (data[['pH']] - pK1))
CO3 = HCO3 * (10 ^ (data[['pH']] - pK2))

phreeqcUMB <- read.csv('CO2 PHREEQC for 76 (not 77) COMSAT lakes UMB.csv')
phreeqcUIO <- read.csv('CO2 PHREEQC for 76 (not 77) COMSAT lakes UIO.csv')

co2df <- data.frame(CO2_UMB = data[['CO2_UMB']],
                    PHREEQC_TIC_UMB = phreeqcUMB[['CO2_PHREEQC']] * 1e6,
                    PHREEQC_TIC_UIO = phreeqcUIO[['CO2_PHREEQC']] * 1e6,
                    Manual_TIC_UMB = CO2 * 1e6)
ra <- range(c(0, co2df, recursive = TRUE), na.rm = TRUE)

pdf('CO2 comparison (micro M).pdf')
plot(co2df, main = 'CO2 concentration (micro M)', xlim = ra, ylim = ra)
dev.off()

write.csv(data.frame(ID = data[['ID']], co2df), file = 'CO2 comparison (micro M).csv')

Henryco2 <- 0.034 * exp(2400 * ((1/(data[['Temperature']] + 273.15)) - (1 / 298.15)))
pco2H <- co2df * (1 / Henryco2) * 0.987
pco2 <- data.frame(ID = data[['ID']],
                   pco2H,
                   pco2PHREEQCdirect = 10 ^ phreeqcUMB[['logpCO2_PHREEQC']] * 1e6
                   )

pdf('pCO2 comparison (ppm or micro atm).pdf')
plot(pco2[, -1], main = 'pCO2 (ppm)', xlim = c(0, 2000), ylim = c(0, 2000))
abline(h = 390)
abline(v = 390)
dev.off()
