data <- read.csv('SwedishBathymetryCollated.csv')

data.rest <- data[data[['lakeid']] != 'SW3-4016', ]
data.sw34016 <- data[data[['lakeid']] == 'SW3-4016', ]

problematic <- data.sw34016[['d1']] >= 12
new.row <- data.frame(lakeid = 'SW3-4016',
                      d1 = 12,
                      d2 = 16,
                      dm = (12 + 16) / 2,
                      area = sum(data.sw34016[['area']][problematic]),
                      fractionalarea = sum(data.sw34016[['area']][problematic]) / sum(data.sw34016[['area']]),
                      ## below two variables are the same as the above two because these are the last (deepest) layer
                      cumsumarea = sum(data.sw34016[['area']][problematic]),
                      cumsumfraction = sum(data.sw34016[['area']][problematic]) / sum(data.sw34016[['area']]),
                      intervals.string = '12-16',
                      oneminusZdmdivZmaxdm = 1 - (14 / 14),
                      oneminusZdivZmax = 1 - (12 / 16))
new.data.sw34016 <- rbind(data.sw34016[!problematic, ], new.row)
new.data <- rbind(data.rest, new.data.sw34016)

data <- new.data

data.rest <- data[data[['lakeid']] != 'SW3-5739', ]
data.sw35739 <- data[data[['lakeid']] == 'SW3-5739', ]

problematic <- data.sw35739[['d1']] >= 6
new.row <- data.frame(lakeid = 'SW3-5739',
                      d1 = 6,
                      d2 = 7,
                      dm = (6 + 7) / 2,
                      area = sum(data.sw35739[['area']][problematic]),
                      fractionalarea = sum(data.sw35739[['area']][problematic]) / sum(data.sw35739[['area']]),
                      ## below two variables are the same as the above two because these are the last (deepest) layer
                      cumsumarea = sum(data.sw35739[['area']][problematic]),
                      cumsumfraction = sum(data.sw35739[['area']][problematic]) / sum(data.sw35739[['area']]),
                      intervals.string = '6-7',
                      oneminusZdmdivZmaxdm = 1 - (6.5 / 6.5),
                      oneminusZdivZmax = 1 - (6 / 7))
new.data.sw35739 <- rbind(data.sw35739[!problematic, ], new.row)
new.data <- rbind(data.rest, new.data.sw35739)

data <- new.data

data.rest <- data[data[['lakeid']] != 'SW3-6593', ]
data.sw36593 <- data[data[['lakeid']] == 'SW3-6593', ]

problematic <- data.sw36593[['d1']] >= 6
new.row <- data.frame(lakeid = 'SW3-6593',
                      d1 = 6,
                      d2 = 8,
                      dm = (6 + 8) / 2,
                      area = sum(data.sw36593[['area']][problematic]),
                      fractionalarea = sum(data.sw36593[['area']][problematic]) / sum(data.sw36593[['area']]),
                      ## below two variables are the same as the above two because these are the last (deepest) layer
                      cumsumarea = sum(data.sw36593[['area']][problematic]),
                      cumsumfraction = sum(data.sw36593[['area']][problematic]) / sum(data.sw36593[['area']]),
                      intervals.string = '6-8',
                      oneminusZdmdivZmaxdm = 1 - (7 / 7),
                      oneminusZdivZmax = 1 - (6 / 8))
new.data.sw36593 <- rbind(data.sw36593[!problematic, ], new.row)
new.data <- rbind(data.rest, new.data.sw36593)

data <- new.data

data.rest <- data[data[['lakeid']] != 'SW3-6427', ]
data.sw36427 <- data[data[['lakeid']] == 'SW3-6427', ]

problematic <- data.sw36427[['d1']] >= 8
new.row <- data.frame(lakeid = 'SW3-6427',
                      d1 = 8,
                      d2 = 10.5,
                      dm = (8 + 10.5) / 2,
                      area = sum(data.sw36427[['area']][problematic]),
                      fractionalarea = sum(data.sw36427[['area']][problematic]) / sum(data.sw36427[['area']]),
                      ## below two variables are the same as the above two because these are the last (deepest) layer
                      cumsumarea = sum(data.sw36427[['area']][problematic]),
                      cumsumfraction = sum(data.sw36427[['area']][problematic]) / sum(data.sw36427[['area']]),
                      intervals.string = '8-10.5',
                      oneminusZdmdivZmaxdm = 1 - (9.25 / 9.25),
                      oneminusZdivZmax = 1 - (8 / 10.5))
new.data.sw36427 <- rbind(data.sw36427[!problematic, ], new.row)
new.data <- rbind(data.rest, new.data.sw36427)

data <- new.data

data.rest <- data[data[['lakeid']] != 'SW3-6430', ]
data.sw36430 <- data[data[['lakeid']] == 'SW3-6430', ]

problematic <- data.sw36430[['d1']] >= 1
new.row <- data.frame(lakeid = 'SW3-6430',
                      d1 = 1,
                      d2 = 1.9,
                      dm = (1 + 1.9) / 2,
                      area = sum(data.sw36430[['area']][problematic]),
                      fractionalarea = sum(data.sw36430[['area']][problematic]) / sum(data.sw36430[['area']]),
                      ## below two variables are the same as the above two because these are the last (deepest) layer
                      cumsumarea = sum(data.sw36430[['area']][problematic]),
                      cumsumfraction = sum(data.sw36430[['area']][problematic]) / sum(data.sw36430[['area']]),
                      intervals.string = '1 / 1.9',
                      oneminusZdmdivZmaxdm = 1 - (1.45 / 1.45),
                      oneminusZdivZmax = 1 - (1 / 1.9))
new.data.sw36430 <- rbind(data.sw36430[!problematic, ], new.row)
new.data <- rbind(data.rest, new.data.sw36430)





new.data.sorted <- new.data[order(new.data[['lakeid']], new.data[['d1']]), ]
write.csv(new.data.sorted, file = 'SwedishBathymetryCollatedFixed.csv',
          row.names = FALSE)

                      
                      
