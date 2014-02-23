'''
utilities for the interpolated data from NORA10
'''

import os
import sys
import tarfile

varH = {'ta_2m':  '1H', 
        'ts_0m':  '1H', 
        'pr':     '1H',
        'psl':    '1H', 
        'ps':     '3H', 
        'wss_10m': '1H', 
        'hur_2m': '1H', 
        'rss':    '3H', 
        'rls':    '3H', 
        'albedo': '1H'}

def allinterpmethods(location, var, timestat, years):
    '''
    writes a table with
    rows: time steps
    columns: interpolation methods

    years: list of years
    '''
    years = [int(y) for y in years]
    years.sort()
    if not len(set(years)) == len(years):
        sys.exit('give unique years')
    if not len(years) == 1 
        if all([diff == 1 for diff in (years[1:] - years[:-1])]):
            sys.exit('give continuous sequence of years')
    pp = [os.path.join('interpolated', location, var, timestat, str(year)) 
          for year in years]
    p_exists = [os.path.exists(p) for p in pp]
    if not all p_exists:
        sys.exit('not all years of simulations are finished')
    outfname = 'NORA10_%s_11km_%s_%s_%s_%s_%s' % (
        varH[var], var, '%s-%s' % (min(year), max(year)), timestat, location, 
        'interpolated_cutoff_100_nlocal_50.txt')
    with open(outfname, 'w') as g:
        for yi in range(len(pp)):
            p = pp[yi]
            year = str(years[yi])
            tarfs = [tarf for tarf in os.listdir(p) 
                     if os.path.splitext(f)[1] == '.tar']
            tarfs.sort()
            for tarf in tarfs:
                i1, i2 = [int(i) for i in os.path.splitext(tarf)[0].split('-')]
                with tarfile.open(os.path.join(p, tarf)) as tf:
                    for j in range(i1, i2 + 1):
                        membername = 'NORA10_%s_11km_%s_%s_%04i_%s_%s' % (
                            varH[var], var, year, j, location, 
                            'interpolated_cutoff_100_nlocal_50.txt')
                        memberf = tf.extractfile(membername)
                        g.writelines([memberf.read().strip(), '\n'])
                        memberf.close()
                        
                    
        
                    
def allintermediates(years):
    pass

def
