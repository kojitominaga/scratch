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
        'albedo': '1H', 
        'clt':    '1H'}
interpnames = ('i1a', 'i1b', 'i1c', 
               'i3an', 'i3ao', 
               'i3bn', 'i3bo', 
               'i3cn', 'i3co')
statsnames = ('locallyhomog3', 
              'maxgamma3', 
              'maxgamma3o',
              'maxdist3', 
              'maxdist3o', 
              'vfl3Lin', 
              'vfl3oLin', 
              'vfe3Nug', 
              'vfe3Lin', 
              'vfe3Gau', 
              'vfe3Exp', 
              'vfe3S50', 
              'vfe3S75', 
              'vfe3oNug', 
              'vfe3oLin', 
              'vfe3oGau', 
              'vfe3oExp', 
              'vfe3oS50', 
              'vfe3oS75', 
              'vfl3SSE', 
              'vfl3oSSE', 
              'vfe3SSE', 
              'vfe3oSSE', 
              'vfl3RSSE', 
              'vfl3oRSSE', 
              'vfe3RSSE', 
              'vfe3oRSSE', 
              'var3an',
              'var3ao', 
              'var3bn', 
              'var3bo', 
              'var3cn', 
              'var3co')

def bylocation(location, var, timestat, years):
    '''
    all interpolation methods for a location
    writes a table with
    rows: time steps
    columns: interpolation methods

    years: list of years
    '''
    years = [int(y) for y in years]
    years.sort()
    if not len(set(years)) == len(years):
        sys.exit('give unique years')
    if not len(years) == 1:
        if not all([years[1:][e] - years[:-1][e] == 1 
                    for e in range(len(years) - 1)]):
            sys.exit('give continuous sequence of years')
    pp = [os.path.join('interpolated', location, var, timestat, str(year)) 
          for year in years]
    p_exists = [os.path.exists(p) for p in pp]
    if not all(p_exists):
        sys.exit('not all years of simulations are finished')
        
    outfname = 'NORA10_%s_11km_%s_%s_%s_%s_%s' % (
        varH[var], var, '%s-%s' % (min(years), max(years)), timestat, location,
        'interpolated_cutoff_100_nlocal_50.txt')
    
    with open(outfname, 'w') as g:
        g.write(' '.join(interpnames))
        g.write('\n')
        for yi in range(len(pp)):
            p = pp[yi]
            year = str(years[yi])
            tarfs = [tarf for tarf in os.listdir(p) 
                     if os.path.splitext(tarf)[1] == '.tar']
            tarfs.sort()
            for tarf in tarfs:
                i1, i2 = [int(i) for i in os.path.splitext(tarf)[0].split('-')]
                with tarfile.open(os.path.join(p, tarf)) as tf:
                    for j in range(i1, i2 + 1):
                        membername = 'NORA10_%s_11km_%s_%s_%04i_%s_%s' % (
                            varH[var], var, year, j, location, 
                            'interpolated_cutoff_100_nlocal_50.txt')
                        memberf = tf.extractfile(membername)
                        g.write(memberf.read().strip())
                        g.write('\n')
                        memberf.close()
                    
def byinterpmethodLocations(var, timestat, years, 
                            interpmethod = 'last', locations = 'all'):
    '''
    for the specified locations, and for the specified interp method, 
    write a table with
    rows: time steps
    columns: locations

    years: list of years
    '''
    years = [int(y) for y in years]
    years.sort()
    if not len(set(years)) == len(years):
        sys.exit('give unique years')
    if not len(years) == 1:
        if all([diff == 1 for diff in (years[1:] - years[:-1])]):
            sys.exit('give continuous sequence of years')

    interpmethod = -1 if interpmethod == 'last' else int(interpmethod)
    locations = os.listdir('interpolated') if locations == 'all' else locations

    outfname = 'NORA10_%s_11km_%s_%s_%s_interpolated_%s.txt' % (
        varH[var], var, '%s-%s' % (min(years), max(years)), timestat,
        interpnames[interpmethod])

    with open(outfname, 'w') as g:
        g.write(' '.join(locations))
        g.write('\n')
        for year in years:
            year = str(year)
            outdict = {}
            for location in locations:
                p = os.path.join('interpolated', location, var, timestat, year)
                tarfs = [tarf for tarf in os.listdir(p)
                         if os.path.splitext(f)[1] == '.tar']
                tarfs.sort()
                jj = max([int(os.path.splitext(tarf)[0].split('-')[1]) 
                          for tarf in tarfs])
                v = [None] * jj
                for tarf in tarfs:
                    i1, i2 = [int(i) for i 
                              in os.path.splitext(tarf)[0].split('-')]
                    with tarfile.open(os.path.join(p, tarf)) as tf:
                        for j in range(i1, i2 + 1):
                            membername = 'NORA10_%s_11km_%s_%s_%04i_%s_%s' % (
                                varH[var], var, year, j, location, 
                                'interpolated_cutoff_100_nlocal_50.txt')
                            memberf = tf.extractfile(membername)
                            v[j] = memberf.read().strip().split()[interpmethod]
                            memberf.close()
                outdict[location] = v
            ## jj is still alive and I use it here
            for j in range(jj):
                g.write(' '.join([outdict[loc][j] for loc in locations]))
                g.write('\n')
            
                
def byinterpmethodVariables(location, timestat, years, 
                            interpmethod = 'last', varnames = 'all'):
    '''
    for a specified location, and for the specified interp method, 
    write a table with
    rows: time steps
    columns: variables

    years: list of years
    '''            
    years = [int(y) for y in years]
    years.sort()
    if not len(set(years)) == len(years):
        sys.exit('give unique years')
    if not len(years) == 1: 
        if all([diff == 1 for diff in (years[1:] - years[:-1])]):
            sys.exit('give continuous sequence of years')

    interpmethod = -1 if interpmethod == 'last' else int(interpmethod)
    varnames = os.listdir(os.path.join('interpolated', location)) \
      if varnames == 'all' else varnames  

    outfname = 'NORA10_%s_11km_%s_%s_%s_interpolated_%s.txt' % (
        varH[var], location, '%s-%s' % (min(years), max(years)), timestat,
        interpnames[interpmethod])

    with open(outfname, 'w') as g:
        g.write(' '.join(varnames))
        g.write('\n')
        for year in years:
            year = str(year)
            outdict = {}
            for var in varnames:
                p = os.path.join('interpolated', location, var, timestat, year)
                tarfs = [tarf for tarf in os.listdir(p)
                         if os.path.splitext(f)[1] == '.tar']
                tarfs.sort()
                jj = max([int(os.path.splitext(tarf)[0].split('-')[1]) 
                          for tarf in tarfs])
                v = [None] * jj
                for tarf in tarfs:
                    i1, i2 = [int(i) for i 
                              in os.path.splitext(tarf)[0].split('-')]
                    with tarfile.open(os.path.join(p, tarf)) as tf:
                        for j in range(i1, i2 + 1):
                            membername = 'NORA10_%s_11km_%s_%s_%04i_%s_%s' % (
                                varH[var], var, year, j, location, 
                                'interpolated_cutoff_100_nlocal_50.txt')
                            memberf = tf.extractfile(membername)
                            v[j] = memberf.read().strip().split()[interpmethod]
                            memberf.close()
                outdict[var] = v
            ## jj is still alive and I use it here
            for j in range(jj):
                g.write(' '.join([outdict[var][j] for var in varnames]))
                g.write('\n')
            
