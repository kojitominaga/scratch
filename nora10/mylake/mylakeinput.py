import os
import numpy as np

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
for location, interpmethod, f1H, f3H in names:
    varnames1 = '_'.join(f1H.split('.')[0].split('_')[3:-5]).split('-')
    varnames3 = '_'.join(f3H.split('.')[0].split('_')[3:-5]).split('-')
    ta_2m_i = varnames1.index('ta_2m')
    hur_2m_i = varnames1.index('hur_2m')
    wss_10m_i = varnames1.index('wss_10m')
    pr_i = varnames1.index('pr')
    ps_i = varnames3.index('ps')
    ta_2m, hur_2m, wss_10m, pr = \
      np.loadtxt(os.path.join(origindir, f1H), skiprows = 1, unpack = True, 
                 usecols = (ta_2m_i, hur_2m_i, wss_10m_i, pr_i))
    ps = \
      np.loadtxt(os.path.join(origindir, f3H), skiprows = 1, unpack = True,
                 usecols = (ps_i, ))
    print(' '.join([location, interpmethod, str(ta_2m.mean())]))
    
      
                 
