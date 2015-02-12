import numpy as np
import pandas as pd
import h5py
import datetime
import os
import math
import sys

depth_resolution = 0.1 # metre


def mylakeinit(max_depth, area, outpath):
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
    with open(outpath, 'w') as f:
        f.write('\n'.join(lines))


def mylakepar(longitude, latitude, outpath, atten_coeff=1):
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
    with open(outpath, 'w') as f:
        f.write(out)


def take5(pdict, dates, eh):
    '''pdict: dictionary of paths to HDF5 files (see pA and pB)
    dates: see datesA and datesB
    eh: ebhex
    returns pandas.DataFrame'''
    e = eh.lstrip('0x').lstrip('0')
    df = pd.DataFrame(dates, columns = ['date'])
    df['clt'] = h5py.File(pdict['clt'], mode='r')[e][:] * 0.01
    df['hurs'] = h5py.File(pdict['hurs'], mode='r')[e][:]
    df['pr'] = h5py.File(pdict['pr'], mode='r')[e][:] * (60 * 60 * 24)
    df['ps'] = h5py.File(pdict['ps'], mode='r')[e][:] * 0.01
    df['rsds'] = h5py.File(pdict['rsds'], mode='r')[e][:] * (60 * 60 * 24 * 1e-6)
    df['sfcWind'] = h5py.File(pdict['sfcWind'], mode='r')[e][:]
    df['tas'] = h5py.File(pdict['tas'], mode='r')[e][:] - 273.15
    return df


def mylakeinput(pA, pB, datesA, datesB, eh, outpath):
    df = pd.concat([take5(pA, datesA, eh), take5(pB, datesB, eh)])
    ndays = len(datesA) + len(datesB)
    df.index = np.arange(ndays)
    repd = [datesA[0] + datetime.timedelta(d) for d in range(-(365 * 2), ndays)]
    mlyear = np.array([d.year for d in repd])
    mlmonth = np.array([d.month for d in repd])
    mlday = np.array([d.day for d in repd])
    mlndays = 365 + 365 + ndays
    repeati = range(365) + range(365) + range(ndays)
    spacer = np.repeat([0], repeats = ndays)[repeati].reshape((mlndays, 1))
    temporarypath = '%s.temp' % outpath
    np.savetxt(temporarypath,
               np.concatenate((mlyear.reshape((mlndays, 1)),
                               mlmonth.reshape((mlndays, 1)), 
                               mlday.reshape((mlndays, 1)), 
                               df['rsds'][repeati].reshape((mlndays, 1)),
                               df['clt'][repeati].reshape((mlndays, 1)), 
                               df['tas'][repeati].reshape((mlndays, 1)), 
                               df['hurs'][repeati].reshape((mlndays, 1)), 
                               df['ps'][repeati].reshape((mlndays, 1)), 
                               df['sfcWind'][repeati].reshape((mlndays, 1)), 
                               df['pr'][repeati].reshape((mlndays, 1)), 
                               spacer, spacer, spacer, spacer, 
                               spacer, spacer, spacer, spacer), axis = 1), 
               fmt = ['%i', '%i', '%i', 
                      '%.4g', '%.3f', '%.2f', '%i', '%i', '%.2f', '%.3f', 
                      '%i', '%i', '%i', '%i', 
                      '%i', '%i', '%i', '%i'],
               delimiter = '\t', 
               header = 'mylake input\nYear	Month	Day	Global_rad (MJ/m2)	Cloud_cov (-)	Air_temp (deg C)	Relat_hum (%)	Air_press (hPa)	Wind_speed (m/s)	Precipitation (mm/day)	Inflow (m3/day)	Inflow_T (deg C)	Inflow_C	Inflow_S (kg/m3)	Inflow_TP (mg/m3)	Inflow_DOP (mg/m3)	Inflow_Chla (mg/m3)	Inflow_DOC (mg/m3)')
    with open(temporarypath) as f:
        with open(outpath, 'w') as g:
            g.write(f.read().replace('-99999999', 'NaN'))
    os.unlink(temporarypath)        


variables = ['clt', 'hurs', 'tas', 'rsds', 'ps', 'pr', 'sfcWind']
models = {1: ('ICHEC-EC-EARTH', 'r1i1p1_KNMI-RACMO22E_v1_day'), 
          2: ('ICHEC-EC-EARTH', 'r3i1p1_DMI-HIRHAM5_v1_day_'), 
          3: ('MPI-M-MPI-ESM-LR', 'r1i1p1_CLMcom-CCLM4-8-17_v1_day_')}
scenarios = {1: ('historical', 1971, 'historical', 1976), 
             2: ('historical', 2001, 'rcp45', 2006), 
             3: ('rcp45', 2031, 'rcp45', 2036), 
             4: ('rcp45', 2061, 'rcp45', 2066), 
             5: ('rcp45', 2091, 'rcp45', 2096), 
             6: ('rcp85', 2031, 'rcp85', 2036), 
             7: ('rcp85', 2061, 'rcp85', 2066), 
             8: ('rcp85', 2091, 'rcp85', 2096)}
prefix = '/work/users/kojito/cordex' # prefix
prefix2 = '/work/users/kojito/lakes'
def runlake(modelid, scenarioid, eh, depth, area, longitude, latitude):
    '''see above lines for models and scenarios (dictionaries). eh: EBhex'''
    exA, y1A, exB, y1B = scenarios[scenarioid]
    m1, m2 = models[modelid]
    y2A = y1A + 4
    y2B = y1B + 4
    pA = {v: '%s/Lakes_%s_EUR-11_%s_%s_%s_%s0101-%s1231.h5' % 
          (prefix, v, m1, exA, m2, y1A, y2A) for v in variables}
    pB = {v: '%s/Lakes_%s_EUR-11_%s_%s_%s_%s0101-%s1231.h5' % 
          (prefix, v, m1, exB, m2, y1B, y2B) for v in variables}
    ndaysA = (datetime.date(y2A, 12, 31) - datetime.date(y1A, 1, 1)).days + 1
    datesA = [datetime.date(y1A, 1, 1) + datetime.timedelta(d) 
              for d in range(ndaysA)]
    ndaysB = (datetime.date(y2B, 12, 31) - datetime.date(y1B, 1, 1)).days + 1
    datesB = [datetime.date(y1B, 1, 1) + datetime.timedelta(d)
              for d in range(ndaysB)]
    
    eh = eh[2:] if eh[:2] == '0x' else eh
    while len(eh) < 6:
        eh = '0' + eh
    d1, d2, d3 = eh[:2], eh[:4], eh[:6]
    outdir = os.path.join(prefix2, d1, d2, d3, 
                          'EUR-11_%s_%s-%s_%s_%s0101-%s1231' % (
                              m1, exA, exB, m2, y1A, y2B))
    if not os.path.exists(outdir):
        os.makedirs(outdir)
    initp = os.path.join(outdir, 'Feb2015init')
    parp = os.path.join(outdir, 'Feb2015par')
    inputp = os.path.join(outdir, 'vanillainput')
    if os.path.exists(os.path.join(outdir, 'Feb2015COMPLETE')):
        print('lake %s is already completed' % eh)
        ret = 0
    else:
        mylakeinit(depth, area, initp)
        mylakepar(longitude, latitude, parp)
        mylakeinput(pA, pB, datesA, datesB, eh, inputp)
        cmd = 'octave mylake.m %s %s %s %s %s %s' % (
            initp, parp, inputp, y1A - 2, y2B, outdir)
        print(cmd)
        os.system(cmd)
        for f in [initp, parp, inputp]:
            os.system('bzip2 %s' % f)
        expectedfs = ['Feb2015init.bz2', 'Feb2015par.bz2',
                      'vanillainput.bz2', 'Tzt.csv.gz', 
                      'Kzt.csv.gz', 'His.csv.gz', 'Qst.csv.gz']
        flags = [os.path.exists(os.path.join(outdir, f)) for f in expectedfs]
        if all(flags):
            with open(os.path.join(outdir, 'Feb2015COMPLETE'), 'w') as f:
                f.write(datetime.datetime.now().isoformat())
        ret = 0 if all(flags) else 100
    return ret

if __name__ == '__main__':
    # model = 'EUR-11_ICHEC-EC-EARTH_historical_r1i1p1_KNMI-RACMO22E_v1_day'
    # y1 = 1971
    # latitude = 59.97
    # longitude = 10.62
    # eh = '1cb62'
    # # eh = 'b516a3' ## a lake in the north
    # area = 1100000
    # depth = max(4.0, math.sqrt(area) / 100)
    # y2 = y1 + 4
    # y3 = y1 + 5
    # y4 = y1 + 9
    a = sys.argv
    
    
