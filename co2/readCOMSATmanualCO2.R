dataraw <- read.table('comsat/COMSAT 2011 synthesis.txt',
                   header = TRUE, sep = ' ')

data <- dataraw[!is.na(dataraw[['Temperature']]), ]
## removing one lake without the data

gasdata <- read.table('comsat/NSD/COMSAT 2011 gases.txt', header = TRUE)
data[['CO2']] <- gasdata[['CO2']]

TICM = data[['TIC']] / 1000 / 12
pK1 = 6.35
pK2 = 10.33

HCO3 = TICM / (1 / 10 ^ (data[['pH']] - pK1) + 1 + 10 ^ (data[['pH']] - pK2))
CO2 = HCO3 / (10 ^ (data[['pH']] - pK1))
CO3 = HCO3 * (10 ^ (data[['pH']] - pK2))

phreeqc <- read.csv('CO2 PHREEQC for 76 (not 77) COMSAT lakes.csv')

co2df <- data.frame(Measured = data[['CO2']],
                    PHREEQC = phreeqc[['CO2_PHREEQC']] * 1e6,
                    Manual = CO2 * 1e6)
ra <- range(c(0, co2df, recursive = TRUE))

pdf('CO2 comparison (micro M).pdf')
plot(co2df, main = 'CO2 concentration (micro M)', xlim = ra, ylim = ra)
dev.off()

write.csv(data.frame(ID = data[['ID']], co2df), file = 'CO2 comparison (micro M).csv')

Henryco2 <- 0.034 * exp(2400 * ((1/(data[['Temperature']] + 273.15)) - (1 / 298.15)))
pco2H <- co2df * (1 / Henryco2) * 0.987
pco2 <- data.frame(ID = data[['ID']],
                   pco2H,
                   pco2PHREEQCdirect = 10 ^ phreeqc[['logpCO2_PHREEQC']] * 1e6
                   )

pdf('pCO2 comparison (ppm or micro atm).pdf')
plot(pco2, main = 'pCO2 (ppm)', xlim = ra * Henryco2, ylim = ra * Henryco2)
abline(h = 390)
abline(v = 390)
dev.off()
