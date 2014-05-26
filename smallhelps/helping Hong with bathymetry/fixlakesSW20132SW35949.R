data <- read.csv('SwedishBathymetryCollatedFixed.csv')

new.data <- data

name <- 'SW2-0132'
questionableinterval <- '0-8'
data.rest <- new.data[new.data[['lakeid']] != name, ]
data.laketofix <- new.data[new.data[['lakeid']] == name, ]
temp <- data.laketofix[data.laketofix[['intervals.string']] != questionableinterval, ]
temp[['fractionalarea']] <- temp[['area']] / sum(temp[['area']])
temp[['cumsumarea']] <- rev(cumsum(rev(temp[['area']])))
temp[['cumsumfraction']] <- rev(cumsum(rev(temp[['fractionalarea']])))
new.data <- rbind(data.rest, temp)


name <- 'SW3-5949'
questionableinterval <- '0-7'
data.rest <- new.data[new.data[['lakeid']] != name, ]
data.laketofix <- new.data[new.data[['lakeid']] == name, ]
temp <- data.laketofix[data.laketofix[['intervals.string']] != questionableinterval, ]
temp[['fractionalarea']] <- temp[['area']] / sum(temp[['area']])
temp[['cumsumarea']] <- rev(cumsum(rev(temp[['area']])))
temp[['cumsumfraction']] <- rev(cumsum(rev(temp[['fractionalarea']])))
new.data <- rbind(data.rest, temp)



new.data.sorted <- new.data[order(new.data[['lakeid']], new.data[['d1']]), ]
write.csv(new.data.sorted, file = 'SwedishBathymetryCollatedFixed2.csv',
          row.names = FALSE)

                      
                      
