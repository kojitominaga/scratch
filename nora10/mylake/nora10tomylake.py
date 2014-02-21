'''usage: python nora10tomylake.py locationname year interpolationmethod

interpolation method defaults to the last method
universal kriging with vgm-everything 100 in scope 50 cutoff
otherwise refer to the column 0 for the first column 

for the moment only single year simulation is implemented'''

import os
import sys

loc = sys.argv[1]
year = sys.argv[2] # string
interp = int(sys.argv[3]) if sys.argv is not None else 'last'

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


def takedaily(path, locationname, varname, year, interpolationmethod = 'last'):
    '''
    from the path that contains many .tar files such as 
    0000-0009.tar, 0010-0019.tar. 
    interpolation method defaults to 'last', otherwise provide int

    returns nubmers but in strings
    '''
    
    if interpolationmethod == 'last':
        interpolationmethod = -1
    tarfs = [f for f in os.listdir(path) if os.path.splitext(f)[1] == '.tar']
    tarfw.sort() # sort in-place
    ntarfs = len(tarfs)
    i1 = [int(os.path.splitext(f)[0].split('-')[0]) for f in tarfs] 
    # 0, 10, 20, ...
    i2 = [int(os.path.splitext(f)[0].split('-')[1]) for f in tarfs]
    # 9, 19, 29, ... 
    ntime = max(i2) + 1
    out = [None] * ntime
    for i in range(ntarfs):
        with tarfile.open(os.path.join(path, tarfs[i])) as tf:
            for j in range(i1[i], i2[i] + 1):
                membername = 'NORA10_%s_11km_%s_%s_%04i_%s_%s' % (
                    varH[varname], varname, year, j, locationname, 
                    'interpolated_cutoff_100_nlocal_50.txt')
                g = tf.extractfile(membername)
                out[j] = g.read().strip().split()[interpolationmethod]
                g.close()
    return out
            
