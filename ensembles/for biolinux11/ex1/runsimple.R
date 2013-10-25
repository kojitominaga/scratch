require(flakeutil)

fnameaffix <- 'simple'

firstday <- as.Date('2001-01-01')
lastday <- as.Date('2010-12-31')
dayseq <- seq(from = firstday, to = lastday, by = 'day')
dayseqP <- as.POSIXlt(dayseq)
rootpath <- './'
pr <- scan(paste0(rootpath, 'pr.txt'))
rlds <- scan(paste0(rootpath, 'rlds.txt'))
wss <- scan(paste0(rootpath, 'wss.txt'))
huss <- scan(paste0(rootpath, 'huss.txt'))
ps <- scan(paste0(rootpath, 'ps.txt'))

rootpath24 <- './'
rsds24 <- scan(paste0(rootpath24, 'rsds_24-hourized.txt'))
tas24 <- scan(paste0(rootpath24, 'tas_24-hourized.txt'))

height_u <- 10
height_tq <- 2

n <- length(pr)
m <- 24
initialrepeat <- 3

ts.input0 <- data.frame(dMsnowdt_in = rep(pr, each = m),
                        I_atm_in = rsds24,
                        Q_atm_lw_in = rep(rlds, each = m),
                        height_u_in = rep(rep(height_u, times = n), each = m),
                        height_tq_in = rep(rep(height_tq, times = n), each = m),
                        U_a_in = rep(wss, each = m),
                        T_a_in = tas24,
                        q_a_in = rep(huss, each = m),
                        P_a_in = rep(ps, each = m)
                        )
ts.input <- ts.input0[c(rep(1:(m * 365), times = initialrepeat), 1:(n * m)), ]
initiali <- 1:(m * 365 * initialrepeat)

parameters <- c(38, 10000, 0.5,
                mean(ts.input[['T_a_in']]),
                sin(60 / 180 * pi) * 2 * 7.29e-5,
                60 * 60 * 24 / m,
                0, 0.8, 0.8)
names(parameters) <-
  c('depth_w', 'fetch', 'depth_bs', 'T_bs', 'par_Coriolis', 'del_time',
    'albedo_water', 'albedo_ice', 'albedo_snow')

init.state <-
  c(0 + 273.15, 0 + 273.15, 4 + 273.15, 4 + 273.15, 4 + 273.15, 5 + 273.15,
    0.5, 0, 0, 38, 0.4, 4 + 273.15)
names(init.state) <-
  c('T_snow', 'T_ice', 'T_mnw', 'T_wML', 'T_bot', 'T_B1',
    'C_T', 'h_snow', 'h_ice', 'h_ML', 'H_B1', 'T_sfc')

optic <- c(2, 20, 20)
names(optic) <- paste('extincoef_', c('water', 'ice', 'snow'), sep = '')

result <- data.frame(ts.input,
                     runflake(ts.input, parameters, init.state, optic)
                     )[-initiali, ]

print('... calculating daily mean')
dm <- apply(result, 2, tapply,
            rep(1:(n * m), each = 24, length.out = nrow(result)),
            mean)

if (!file.exists('csv')) dir.create('csv')
c <- xzfile(paste('csv/dm_', fnameaffix, '.csv.xz', sep = ''), open = 'wb')
write.csv(data.frame(date = dayseq, signif(dm, digits = 4)), file = c)
close(c)

typicalyear <- apply(dm, 2, tapply, dayseqP$yday, mean)[1:365, ]
## 1:365 makes it ignore 31 Dec in leap years
if (!file.exists('csv')) dir.create('csv')
c <- xzfile(paste('csv/typicalyear_', fnameaffix, '.csv.xz', sep = ''),
            open = 'wb')
write.csv(data.frame(MonthDay = format(seq(from = as.Date('1999-01-01'),
                       to = as.Date('1999-12-31'),
                       by = 'day'), ## need any non-leap year
                       format = '%m-%d'),
                     signif(typicalyear, digits = 4)), 
          file = c)
close(c)

shortnames <- names(result)
if (!file.exists('pdf')) dir.create('pdf')
pdf(paste('pdf/allvariables_dm_', fnameaffix, '.pdf', sep = ''), 
    height = 7.5, width = 11.5)
par(mfcol = c(3, 3))
par(mar = c(2, 3, 3, 1))
for (vi in 1:ncol(typicalyear)) {
  plot(seq(from = as.Date('1999-01-01'),
           to = as.Date('1999-12-31'),
           by = 'day'),
       typicalyear[1:365, vi],
       type = 'l',
       xlab = 'month',
       ylab = '',
       main = fullnames[vi],
       cex.main = 1,
       xaxt = 'n')
  axis.Date(1,
            at = seq(from = as.Date('1999-01-01'),
                     to = as.Date('1999-12-01'),
                     by = 'month'),
            labels = c('J', 'F', 'M', 'A', 'M', 'J',
                       'J', 'A', 'S', 'O', 'N', 'D')
            )
}
dev.off()


                     
