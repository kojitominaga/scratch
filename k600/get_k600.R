wss <- read.csv('NORA10_1H_11km_wss_10m_2011_interp_for_COMSAT_near3.csv.gz')
JFMAM <- sum(31, 28, 31, 30, 31)
JJA <- sum(30, 31, 31)
h <- 24
is.summer <- (JFMAM * h + 1):((JFMAM + JJA) * h)

eq5 <- function(u10) 2.07 + 0.215 * (u10 ^ 1.7)
eq6 <- function(u10) 0.45 * (u10 ^ 1.64)

k600eq5 <- apply(wss[is.summer, ], 1:2, eq5)
k600eq5JJA <- apply(k600eq5, 2, mean) # cm per hour (mean hourly)
k600eq6 <- apply(wss[is.summer, ], 1:2, eq6)
k600eq6JJA <- apply(k600eq6, 2, mean) # cm per hour (mean hourly)

out <- data.frame(k600eq5JJA, k600eq6JJA)
write.csv(out, file = 'data-out/k600 estimates for JJA 2011.csv')
