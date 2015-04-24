import numpy as np
import pandas as pd
import h5py
import datetime
import os


'''will run for Bogstadvannet'''

depth_resolution = 0.1 # metre

def mylakeinit(max_depth, area):
    '''max_depth: m, area: m2.
    returns string to be written to an init file of MyLake

    assumes a cone shaped bathymetry curve'''
    
    depth_levels = np.arange(0, max_depth, depth_resolution)
    if not max_depth in depth_levels: 
        depth_levels = np.concatenate((depth_levels, np.array([max_depth])))
    areas = area * (depth_levels - max_depth) ** 2 / max_depth ** 2
    lines = ['\t'.join([('%.2f' % d), ('%.0f' % a)] + ['4'] + ['0'] * 9)
             for d, a in zip(depth_levels, areas)]    
    lines[0] = lines[0] + '\t0\t0'  # snow and ice
    firstlines = '''-999	"MyLake init"
Z (m)	Az (m2)	Tz (deg C)	Cz	Sz (kg/m3)	TPz (mg/m3)	DOPz (mg/m3)	Chlaz (mg/m3)	DOCz (mg/m3)	TPz_sed (mg/m3)	Chlaz_sed (mg/m3)	"Fvol_IM (m3/m3	 dry w.)"	Hice (m)	Hsnow (m)'''
    lines = [firstlines] + lines
    return '\n'.join(lines)

def mylakepar(atten_coeff, longitude, latitude):
    '''atten_coeff: m-1 
    uses the Minesota area and BV parameters -> sets NaNs
    returns string to be written to a file'''

    out = '''-999	"MyLake parameters"			
Parameter	Value	Min	Max	Unit
dz	1	0.5	2	m
Kz_ak	NaN	NaN	NaN	(-)
Kz_ak_ice	0.000898	NaN	NaN	(-)
Kz_N0	7.00E-05	NaN	NaN	s-2
C_shelter	NaN	NaN	NaN	(-)
latitude	%.5f	NaN	NaN	dec.deg
longitude	%.5f	NaN	NaN	dec.deg
alb_melt_ice	0.3	NaN	NaN	(-)
alb_melt_snow	0.77	NaN	NaN	(-)
PAR_sat	3.00E-05	1.00E-05	1.00E-04	mol m-2 s-1
f_par	0.45	NaN	NaN	(-)
beta_chl	0.015	0.005	0.045	m2 mg-1
lambda_I	5	NaN	NaN	m-1
lambda_s	15	NaN	NaN	m-1
sed_sld	0.36	NaN	NaN	(m3/m3)
I_scV 	2.15	NaN	NaN	(-)
I_scT	0	NaN	NaN	deg C
I_scC	1	NaN	NaN	(-)
I_scS	1.5	1.1	1.9	(-)
I_scTP	0.59	0.4	0.8	(-)
I_scDOP	1	NaN	NaN	(-)
I_scChl	1	NaN	NaN	(-)
I_scDOC	1	NaN	NaN	(-)
swa_b0	2.5	NaN	NaN	m-1
swa_b1	%.2f	0.8	1.3	m-1
S_res_epi	3.30E-07	7.30E-08	1.82E-06	m d-1 (dry mass)
S_res_hypo	3.30E-08	NaN	NaN	m d-1 (dry mass)
H_sed	0.03	NaN	NaN	m
Psat_Lang	2500	NaN	NaN	mg m-3
Fmax_Lang	8000	5000	10000	mg kg-1
Uz_Sz	0.3	0.1	1	m d-1
Uz_Chl	0.16	0.05	0.5	m d-1
Y_cp	1	NaN	NaN	(-)
m_twty	0.2	0.1	0.3	d-1
g_twty	1.5	1	1.5	d-1
k_sed_twty	2.00E-04	NaN	NaN	d-1
k_dop_twty	0	NaN	NaN	d-1
P_half	0.2	0.2	2	mg m-3
PAR_sat2	3.00E-05	NaN	NaN	mol m-2 s-1
beta_chl2	0.015	NaN	NaN	m2 mg-1
Uz_Chl2	0.16	NaN	NaN	m d-1
m_twty2	0.2	NaN	NaN	d-1
g_twty2	1.5	NaN	NaN	d-1
P_half2	0.2	NaN	NaN	mg m-3
oc_DOC	0.01	NaN	NaN	m2 mg-1
qy_DOC	0.1	NaN	NaN	mg mol-1
''' % (latitude, longitude, atten_coeff)
    return out

with open('init', 'w') as f:
    f.write(mylakeinit(12, 1100000))

with open('par', 'w') as f:
    f.write(mylakepar(1.0, 10.62, 59.97))

outpath = 'input'

p1 = '/Volumes/Seagate Expansion Drive/cordex-lakes/Lakes_'
p2 = '_EUR-11_ICHEC-EC-EARTH_historical_r3i1p1_DMI-HIRHAM5_v1_day_19710101-19751231.h5'

ndays = (datetime.date(1975, 12, 31) - datetime.date(1971, 1, 1)).days + 1
dates = [datetime.date(1971, 1, 1) + datetime.timedelta(d) 
         for d in range(ndays)]
eh = '1cb62'
# eh = 'b516a3' ## a lake in the north

df = pd.DataFrame(dates, columns = ['date'])
df['clt'] = h5py.File(''.join([p1, 'clt', p2]), mode='r')[eh][:] * 0.01
df['hurs'] = h5py.File(''.join([p1, 'hurs', p2]), mode='r')[eh][:]
df['pr'] = h5py.File(''.join([p1, 'pr', p2]), mode='r')[eh][:] * (60 * 60 * 24)
df['ps'] = h5py.File(''.join([p1, 'ps', p2]), mode='r')[eh][:] * 0.01
df['rsds'] = h5py.File(''.join([p1, 'rsds', p2]), mode='r')[eh][:] * (60 * 60 * 24 * 1e-6)
df['sfcWind'] = h5py.File(''.join([p1, 'sfcWind', p2]), mode='r')[eh][:]
df['tas'] = h5py.File(''.join([p1, 'tas', p2]), mode='r')[eh][:] - 273.15

repeatdates = [datetime.date(1971, 1, 1) + datetime.timedelta(d) 
               for d in range(-(365 * 2), ndays)]
mlyear = np.array([d.year for d in repeatdates])
mlmonth = np.array([d.month for d in repeatdates])
mlday = np.array([d.day for d in repeatdates])
mlndays = 365 + 365 + ndays
repeati = range(365) + range(365) + range(ndays)
spacer = np.repeat([0], repeats = ndays)[repeati].reshape((mlndays, 1))

np.savetxt('temp',
           np.concatenate((mlyear.reshape((mlndays, 1)),
                           mlmonth.reshape((mlndays, 1)), 
                           mlday.reshape((mlndays, 1)), 
                           df['rsds'][repeati].reshape((mlndays, 1)),
                           df['clt'][repeati].reshape((mlndays, 1)), 
                           df['tas'][repeati].reshape((mlndays, 1)), 
                           df['hurs'][repeati].reshape((mlndays, 1)), 
                           df['ps'][repeati].reshape((mlndays, 1)), 
                           df['sfcWind'][repeati].reshape((mlndays, 1)), 
                           spacer, 
                           spacer, spacer, spacer, spacer, 
                           spacer, spacer, spacer, spacer), axis = 1), 
           fmt = ['%i', '%i', '%i', 
                  '%.4g', '%.3f', '%.2f', '%i', '%i', '%.2f', '%.3f', 
                  '%i', '%i', '%i', '%i', 
                  '%i', '%i', '%i', '%i'],
           delimiter = '\t', 
           header = 'mylake input\nYear	Month	Day	Global_rad (MJ/m2)	Cloud_cov (-)	Air_temp (deg C)	Relat_hum (%)	Air_press (hPa)	Wind_speed (m/s)	Precipitation (mm/day)	Inflow (m3/day)	Inflow_T (deg C)	Inflow_C	Inflow_S (kg/m3)	Inflow_TP (mg/m3)	Inflow_DOP (mg/m3)	Inflow_Chla (mg/m3)	Inflow_DOC (mg/m3)')
with open('temp') as f:
    with open(outpath, 'w') as g:
        g.write(f.read().replace('-99999999', 'NaN'))

os.unlink('temp')        

