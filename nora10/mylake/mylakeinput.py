import os
import datetime
# import io
import numpy as np

outdir = 'mylake'
if not os.path.exists(outdir): os.makedirs(outdir)
affix = 'NORA10_11km_interpolated'

origindir = 'collated/all vars by loc by interp'
filelist = os.listdir(origindir)
file1H = [f for f in filelist if '_mean24_' in f]
file3H = [f for f in filelist if '_mean8_' in f]
file1H.sort()
file3H.sort()
locations = [f.split('.')[0].split('_')[-5] for f in file3H]
interpmethods = [f.split('.')[0].split('_')[-1] for f in file1H]
# list of tuples (location, interpmethod, file1H, file3H)
names = zip(locations, interpmethods, file1H, file3H)

yearrange = [int(y) for y in file1H[0].split('.')[0].split('_')[-4].split('-')]
ndays = (datetime.date(yearrange[1], 12, 31) - \
         datetime.date(yearrange[0], 1, 1)).days + 1
dates = [datetime.date(yearrange[0], 1, 1) + datetime.timedelta(d) 
         for d in range(ndays)]
mlyear = np.array([d.year for d in dates]).reshape((ndays, 1))
mlmonth = np.array([d.month for d in dates]).reshape((ndays, 1))
mlday = np.array([d.day for d in dates]).reshape((ndays, 1))
spacer = np.repeat([0], repeats = ndays).reshape((ndays, 1))
spacer2 = np.repeat([-99999999], repeats = ndays).reshape((ndays, 1)) # NaN
spacer3 = np.repeat([100], repeats = ndays).reshape((ndays, 1))

for location, interpmethod, f1H, f3H in names:    
    outfname = '_'.join([affix, '-'.join([str(yearrange[0]), str(yearrange[1])]), 
                         location, interpmethod]) + '.mlinput'
    if not os.path.exists(os.path.join(outdir, location, interpmethod)): 
        os.makedirs(os.path.join(outdir, location, interpmethod))
    outpath = os.path.join(outdir, location, interpmethod, outfname)
    varnames1 = '_'.join(f1H.split('.')[0].split('_')[3:-5]).split('-')
    varnames3 = '_'.join(f3H.split('.')[0].split('_')[3:-5]).split('-')
    ta_2m_i = varnames1.index('ta_2m')
    hur_2m_i = varnames1.index('hur_2m')
    wss_10m_i = varnames1.index('wss_10m')
    pr_i = varnames1.index('pr')
    
    clt_i = varnames1.index('clt')
    # clt = np.repeat([0.5], repeats = ndays).reshape((ndays, 1))
    
    ps_i = varnames3.index('ps')
    # ta_2m, hur_2m, wss_10m, pr = \
    #   np.loadtxt(os.path.join(origindir, f1H), skiprows = 1, unpack = True, 
    #              usecols = (ta_2m_i, hur_2m_i, wss_10m_i, pr_i))
    ta_2m, hur_2m, wss_10m, pr, clt = \
      np.loadtxt(os.path.join(origindir, f1H), skiprows = 1, unpack = True, 
                 usecols = (ta_2m_i, hur_2m_i, wss_10m_i, pr_i, clt_i))
    ps = \
      np.loadtxt(os.path.join(origindir, f3H), skiprows = 1, unpack = True,
                 usecols = (ps_i, ))
    ta_2m = ta_2m.reshape((ndays, 1)) - 273.15
    hur_2m = hur_2m.reshape((ndays, 1))
    hur_2m = np.maximum(hur_2m, spacer)
    hur_2m = np.minimum(hur_2m, spacer3)
    wss_10m = wss_10m.reshape((ndays, 1))
    wss_10m = np.maximum(wss_10, spacer)
    pr = pr.reshape((ndays, 1)) * (60 * 60 * 24)
    pr = np.maxiumum(pr, spacer)
    clt = clt.reshape((ndays, 1))
    ps = ps.reshape((ndays, 1)) * 1e-2
    np.savetxt('temp',
               np.concatenate((mlyear, mlmonth, mlday, 
                               spacer2, clt, ta_2m, hur_2m, ps, wss_10m, pr, 
                               spacer, spacer, spacer, spacer, 
                               spacer, spacer, spacer, spacer), axis = 1), 
               fmt = ['%i', '%i', '%i', 
                      '%i', '%.3g', '%.2f', '%.1f', '%.1f', '%.2f', '%.2f', 
                      '%i', '%i', '%i', '%i', 
                      '%i', '%i', '%i', '%i'],
               delimiter = '\t', 
               header = 'mylake input\nYear	Month	Day	Global_rad (MJ/m2)	Cloud_cov (-)	Air_temp (deg C)	Relat_hum (%)	Air_press (hPa)	Wind_speed (m/s)	Precipitation (mm/day)	Inflow (m3/day)	Inflow_T (deg C)	Inflow_C	Inflow_S (kg/m3)	Inflow_TP (mg/m3)	Inflow_DOP (mg/m3)	Inflow_Chla (mg/m3)	Inflow_DOC (mg/m3)')
    with open('temp') as f:
        with open(outpath, 'w') as g:
            g.write(f.read().replace('-99999999', 'NaN'))
    os.unlink('temp')

                

                        
                
    
    
    
      
                 
