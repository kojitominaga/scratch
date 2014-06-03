'''
utilities for the interpolated data from NORA10
'''

import os
import sys
import tarfile
import gzip

varH = {'ta_2m':  '1H', 
        'ts_0m':  '1H', 
        'pr':     '1H',
        'psl':    '1H', 
        'ps':     '3H', 
        'wss_10m': '1H', 
        'hur_2m': '1H', 
        'rss':    '1H', 
        'rls':    '1H', 
        'albedo': '1H', 
        'clt':    '1H'}
interpnames = ('i1a', 'i1b', 'i1c', 
               'i3an', 'i3ao', 
               'i3bn', 'i3bo', 
               'i3cn', 'i3co')
statnames = ('locallyhomog3', 
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

def bylocation(location, var, timestat, years, outdir = '.'):
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
        
    outfname = 'NORA10_%s_11km_%s_%s_%s_%s_%s.gz' % (
        varH[var], var, '%s-%s' % (min(years), max(years)), timestat, location,
        'interpolated_cutoff_100_nlocal_50.txt') 
    outpath = os.path.join(outdir, outfname)
    
    with gzip.GzipFile(outpath, 'wb') as g:
        g.write(' '.join(interpnames))
        g.write(' ')  
        g.write(' '.join(statnames))      
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
                        membername1 = 'NORA10_%s_11km_%s_%s_%04i_%s_%s' % (
                            varH[var], var, year, j, location, 
                            'interpolated_cutoff_100_nlocal_50.txt')
                        memberf1 = tf.extractfile(membername1)
                        g.write(memberf1.read().strip())
                        memberf1.close()
                        g.write(' ')
                        membername2 = 'NORA10_%s_11km_%s_%s_%04i_%s_%s' % (
                            varH[var], var, year, j, location, 
                            'metadatainterp_cutoff_100_nlocal_50.txt')
                        memberf2 = tf.extractfile(membername2)
                        g.write(memberf2.read().strip())
                        memberf2.close()
                        g.write('\n')
                    
def byinterpmethodLocations(var, timestat, years, 
                            interpmethod = 'last', locations = 'all',
                            outdir = '.'):
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
        if not all([years[1:][e] - years[:-1][e] == 1 
                    for e in range(len(years) - 1)]):
            sys.exit('give continuous sequence of years')
    interpmethod = -1 if interpmethod == 'last' else int(interpmethod)
    locations = [d for d in os.listdir('interpolated') 
                 if os.path.isdir(os.path.join('interpolated', d))] \
      if locations == 'all' else locations
    
    outfname = 'NORA10_%s_11km_%s_%s_%s_interpolated_%s.txt.gz' % (
        varH[var], var, '%s-%s' % (min(years), max(years)), timestat,
        interpnames[interpmethod])
    outpath = os.path.join(outdir, outfname)

    with gzip.GzipFile(outpath, 'wb') as g:
        g.write(' '.join(locations))
        g.write('\n')
        for year in years:
            year = str(year)
            outdict = {}
            for location in locations:
                p = os.path.join('interpolated', location, var, timestat, year)
                tarfs = [tarf for tarf in os.listdir(p)
                         if os.path.splitext(tarf)[1] == '.tar']
                tarfs.sort()
                jj = max([int(os.path.splitext(tarf)[0].split('-')[1]) 
                          for tarf in tarfs]) + 1
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

            
                
def byinterpmethodVariables(location, timestat, H, years,
                            interpmethod = 'last', varnames = 'all',
                            outdir = '.'):
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
        if not all([years[1:][e] - years[:-1][e] == 1 
                    for e in range(len(years) - 1)]):
            sys.exit('give continuous sequence of years')
    interpmethod = 8 if interpmethod == 'last' else int(interpmethod)
    varnames = set(['_'.join(f.split('_')[4:-1])
                    for f in os.listdir(os.path.join('interpolated', 
                                                     location))
                    if f[-7:] == '.txt.gz']) if varnames == 'all' else varnames
    outfname = 'NORA10_%s_11km_%s_%s_%s_%s_interpolated_%s.txt.gz' % (
        H, '-'.join(varnames), location, 
        '%s-%s' % (min(years), max(years)), timestat,
        interpnames[interpmethod]) 
    outpath = os.path.join(outdir, outfname)
    print(varnames)

    with gzip.GzipFile(outpath, 'w') as g:
        g.write(' '.join(varnames))
        g.write('\n')
        for year in years:
            year = str(year)
            outdict = {}
            for var in varnames:
                txtgzfn = 'interpolated-%s_NORA10_%s_11km_%s_%s.txt.gz' % (
                    location, varH[var], var, year)
                txtgzpath = os.path.join('interpolated', location, txtgzfn)
                print(txtgzpath)
                with gzip.GzipFile(txtgzpath) as txtgzf:
                    v = [l.split()[interpmethod] for l in txtgzf.readlines()]
                outdict[var] = v
            for j in range(len(v)):
                g.write(' '.join([outdict[var][j] for var in varnames]))
                g.write('\n')
            
if __name__ == '__main__':
    d1 = 'collated/by var by loc all interps and stats'
    if not os.path.exists(d1): os.makedirs(d1)
    d2 = 'collated/by var all locs by interp'
    if not os.path.exists(d2): os.makedirs(d2)
    d3 = 'collated/all vars by loc by interp'   
    if not os.path.exists(d3): os.makedirs(d3)
    years = range(2009, 2013)
    takedailymean, timestat = (True, None)
    ## if false define timestat here 
    ## takedailymean, timestat == (False, 'all')
    locations = [d for d in os.listdir('interpolated') 
                 if os.path.isdir(os.path.join('interpolated', d))]
    ## d1 all years exist
    for location in locations:
        for (var, H) in varH.items():
            timestat = {'1H': 'mean24', '3H': 'mean8'}.setdefault(H, timestat)
            paths = [os.path.join('interpolated', location, var, timestat,
                     str(year), 'COMPLETED') for year in years]
            allpathsexist = all([os.path.exists(path) for path in paths])
            if allpathsexist:
                expectedoutfn = \
                  os.path.join(d1, 'NORA10_%s_11km_%s_%s_%s_%s_%s.gz' % (
                      varH[var], var, '%s-%s' % (min(years), max(years)), 
                      timestat, location,
                      'interpolated_cutoff_100_nlocal_50.txt'))
                if not os.path.exists(expectedoutfn):
                    bylocation(location, var, timestat, years, outpath = d1)
    ## d2 all years exist
    for interpmethod in range(len(interpnames)):
        for (var, H) in varH.items():
            timestat = {'1H': 'mean24', '3H': 'mean8'}.setdefault(H, timestat)
            paths = [os.path.join('interpolated', location, var, timestat,
                     str(year), 'COMPLETED')
                     for location in locations
                     for year in years]
            allpathsexist = all([os.path.exists(path) for path in paths])
            if allpathsexist:
                expectedoutfn = \
                  os.path.join(d2, 
                               'NORA10_%s_11km_%s_%s_%s_interpolated_%s.txt.gz'\
                               % (varH[var], var, 
                                  '%s-%s' % (min(years), max(years)), timestat,
                                  interpnames[interpmethod]))
                if not os.path.exists(expectedoutfn):
                    byinterpmethodLocations(var, timestat, years, 
                                            interpmethod = interpmethod, 
                                            outdir = d2)
    ## d3 all years exist
    timestatdict = {'1H': 'mean24', '3H': 'mean8'}
    for interpmethod in range(len(interpnames)):
        for location in locations:
            for (H, timestat) in timestatdict.items():
                varnames = 'all'
                varnames = \
                  [d for d in 
                   os.listdir(os.path.join('interpolated', location)) 
                   if os.path.isdir(os.path.join('interpolated', 
                                                 location, d))] \
                   if varnames == 'all' else varnames
                varnames = [var for var in varnames if varH[var] == H]
                paths = [os.path.join('interpolated', location, var, timestat, 
                         str(year), 'COMPLETED') 
                         for var in varnames
                         for year in years]
                allpathsexist = all([os.path.exists(path) for path in paths])
                if allpathsexist:
                    expectedoutfn = \
                      os.path.join(d3,
                        'NORA10_%s_11km_%s_%s_%s_%s_interpolated_%s.txt.gz' % (
                            H, '-'.join(varnames), location, 
                            '%s-%s' % (min(years), max(years)), timestat,
                            interpnames[interpmethod]))
                    if not os.path.exists(expectedoutfn):
                        byinterpmethodVariables(location, timestat, H, years, 
                                                interpmethod = interpmethod,
                                                outdir = d3)



