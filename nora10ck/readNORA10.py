"""usage: python readNORA10.py ncfname timei signifdigits"""

import sys
import netCDF4
import numpy as np

def writeout(ncfname, timei, fm):
    """write out the NORA10 results at the specified time index timei"""
    outfn = '%s_%04i.txt' % (ncfname.split('.nc')[0], timei)
    print(outfn)
    r = netCDF4.Dataset(ncfname)
    varname = '_'.join(ncfname.split('_')[:-1][3:])
    v = r.variables[varname]
    if v.ndim == 4:
        out = v[timei, 0, :, :]
    elif v.ndim == 3:
        out = v[timei, :, :]
    np.savetxt(outfn, out, fmt = fm)

if __name__ == '__main__':
    ncfn = sys.argv[1]
    ti = int(sys.argv[2])
    signifdigits = int(sys.argv[3])
    writeout(ncfn, ti, '%%.%sf' % signifdigits)
