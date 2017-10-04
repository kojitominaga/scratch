select count(ebint) from ecco_biwa_lakes_v_0_1
where ccluster30 = 1 or ccomsat = 1 or ebint in (select ebint from north_euro_lake_surv_1995)


create table catchment_cordex_sept2015 (
ebint integer primary key, 
runoff_dmi_2001_2010_jj numeric, 
runoff_dmi_2001_2010_mjja numeric, 
airtemp_dmi_2001_2010_jj numeric, 
airtemp_dmi_2001_2010_mjja numeric);

create table catchment_cordex_oct2015 (
ebint integer primary key, 
runoff_dmi_2001_2010_total_annual numeric, 
runoff_dmi_2031_2040_total_annual numeric, 
runoff_dmi_2061_2070_total_annual numeric, 
runoff_dmi_2091_2100_total_annual numeric) 
