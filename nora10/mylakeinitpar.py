import numpy as np
import os

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


    


data1 = np.genfromtxt('comsat/NSD/COMSAT 2011 field.data.txt', 
                      skip_header = 1,
                      dtype = 'S50,i4,S50,S50,S50,S50,f8,f8,f8,f8,f8',
                      names = ("rowname", "ID", "Lake.name", "Date", 
                               "Start.time", "End.time",
                               "Station.depth", "Zooplankton.Depth", 
                               "Secchi.depth" "Latitude" "Longitude"),
                      usecols = (1, 6, 8, 9, 10))
data2 = np.genfromtxt('comsat/NSD/COMSAT 2011 lakes.txt', 
                      names = True, usecols = (0, 7), 
                      dtype = 'i4,S50,S50,S50,f8,f8,f8,f8,S50,S50,S50,S50,S50', 
                      delimiter = '\t')
good_ids = set(data1['ID']) & set(data2['ID'])

for lake_id in good_ids:
    depth, secchi_depth, latitude, longitude = \
      data1[data1['ID'] == lake_id][0].tolist()[1:]
    area = data2[data2['ID'] == lake_id][0].tolist()[1]
    lakedir = os.path.join('mylake', 'COMSAT' + str(lake_id))
    initdir = os.path.join(lakedir, 'init')
    if not os.path.exists(initdir): os.makedirs(initdir)
    pardir = os.path.join(lakedir, 'par')
    if not os.path.exists(pardir): os.makedirs(pardir)
    with open(os.path.join(initdir, '1.5fielddepth_cone.mlinit'), 'w') as f:
        f.write(mylakeinit(depth * 1.5, area * 1e6))
    with open(os.path.join(pardir, '18secchi_Minnesota.mlpar'), 'w') as f:
        f.write(mylakepar(1.8 / secchi_depth, longitude, latitude))
    with open(os.path.join(pardir, 'LA018_Minnesota.mlpar'), 'w') as f:
        f.write(mylakepar(0.18, longitude, latitude))
    with open(os.path.join(pardir, 'LA090_Minnesota.mlpar'), 'w') as f:
        f.write(mylakepar(0.90, longitude, latitude))
    with open(os.path.join(pardir, 'LA450_Minnesota.mlpar'), 'w') as f:
        f.write(mylakepar(4.50, longitude, latitude))
    
