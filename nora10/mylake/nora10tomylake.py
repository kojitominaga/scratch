'''usage: python nora10tomylake.py path locationname 
varname stat year interpolationmethod

interpolation method defaults to the last method
universal kriging with vgm-everything 100 in scope 50 cutoff
otherwise refer to the column 0 for the first column 

for the moment only single year simulation is implemented
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

def temporalsequence(locationname, varname, timestat, year,
                     interpmethod = 'last', path = 'default'):
    '''
    from the path that contains many .tar files such as 
    0000-0009.tar, 0010-0019.tar. 
    interpolation method defaults to 'last', otherwise provide int

    path defaults to 
    os.path.join('interpolated', locationname, varname, timestat, year)
    
    returns nubmers but in strings
    '''

    if path == 'default':
        path = os.path.join('interpolated', locationname, 
                            varname, timestat, year)
    if interpmethod == 'last':
        intermethod = -1
    tarfs = [f for f in os.listdir(path) if os.path.splitext(f)[1] == '.tar']
    tarfs.sort() # sort in-place
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
                out[j] = g.read().strip().split()[interpmethod]
                g.close()
    sys.exit('do a bit more so it writes to a file')
    return out
            
if __name__ == '__main__':
    path = sys.argv[1]
    loc = sys.argv[2]
    varname = sys.argv[3]
    timestat = sys.argv[4]
    year = sys.argv[5] # string
    interp = int(sys.argv[6]) if sys.argv[6] is not None else 'last'

