require(flaker)
require(flakeutil)

ip <- 9

pf <- 'interpolated/COMSAT170/interpolated-COMSAT170_NORA10'
## clt <- read.table(sprintf('%s_1H_11km_clt_2007.txt.gz', pf))[, ip]
## clt <- pmin(pmax(clt, 0), 1)
pr <- read.table(sprintf('%s_1H_11km_pr_2007.txt.gz', pf))[, ip]
pr <- pmax(pr, 0)
albedo <- read.table(sprintf('%s_1H_11km_albedo_2007.txt.gz', pf))[, ip]
rss <- read.table(sprintf('%s_1H_11km_rss_2007.txt.gz', pf))[, ip]
rss <- rss / 3.6
rls <- read.table(sprintf('%s_1H_11km_rls_2007.txt.gz', pf))[, ip] 
rls <- rls / 3.6
wss <- read.table(sprintf('%s_1H_11km_wss_10m_2007.txt.gz', pf))[, ip]
wss <- pmax(wss, 0)
ta <- read.table(sprintf('%s_1H_11km_ta_2m_2007.txt.gz', pf))[, ip]
ts <- read.table(sprintf('%s_1H_11km_ts_0m_2007.txt.gz', pf))[, ip]
hur <- read.table(sprintf('%s_1H_11km_hur_2m_2007.txt.gz', pf))[, ip]
hur <- pmin(pmax(hur, 0), 100)
ps <- read.table(sprintf('%s_3H_11km_ps_2007.txt.gz', pf))[, ip]
rsds <- rss * 100 / (100 - albedo)
hurs <- hurr2hurs(hur, ta, ps)
rlus <- 5.6704e-8 * (ts ^ 4)
rlds <- rls + rlus
## summary(data.frame(pr, albedo, rss, rsds, rls, rlus, rlds,
##                    wss, ta, ts, ps, hur, hurs))
ts.input <- data.frame(dMsnowdt_in=pr, I_atm_in=rsds, Q_atm_lw_in=rlds,
                       height_u_in=rep(10, times=length(pr)),
                       height_tq_in=rep(2, times=length(pr)),
                       U_a_in=wss, T_a_in=ta, q_a_in=hurs, P_a_in=ps)
parameters <- c(depth_w=20, fetch=1000, depth_bs=3, T_bs=mean(ta),
                par_Coriolis=sin(60 / 180 * pi) * 2 * 7.29e-5,
                del_time=60 * 60 * 24,
                albedo_water=0.9, albedo_ice=0.5, albedo_snow=0.3)
init.state <- c(T_snow=273.15, T_ice=273.15, T_mnw=275, T_wML=273.20,
                T_bot=273.15 + 3.98, T_B1=273.15 + 6, C_T=0.5,
                h_snow=0, h_ice=0, h_ML=10, H_B1=1.5, T_sfc=273.15)
optic <- list(opticpar_nband_water=1,
              opticpar_frac_water=rep(0.1, times=10),
              opticpar_extincoef_water=seq(from=0.2, to=4.0, length.out=10),
              opticpar_nband_ice=1,
              opticpar_frac_ice=c(1, rep(0, times=9)),
              opticpar_extincoef_ice=c(20, rep(100, times=9)),
              opticpar_nband_snow=1,
              opticpar_frac_snow=c(1, rep(0, times=9)),
              opticpar_extincoef_snow=c(20, rep(100, times=9)))
result <- runflake(ts.input, parameters, init.state, simpleoptic=FALSE, optic)

              

