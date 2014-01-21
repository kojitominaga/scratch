"""
usage: python readNORA10.py ncfname timei signifdigits alldays(logical) outdir

if alldays == True, then timei is ignored (all days written out)
"""

import sys
import os
import netCDF4
import numpy as np
import bz2

def writeout(ncfname, timei, fm, outdir):
    """write out the NORA10 results at the specified time index timei"""
    r = netCDF4.Dataset(ncfname)
    varname = '_'.join(ncfname.split('_')[:-1][3:])
    v = r.variables[varname]
    if v.ndim == 4:
        out = v[timei, 0, :, :]
    elif v.ndim == 3:
        out = v[timei, :, :]
    outfn = '%s/%s_%04i.txt.bz2' % (outdir, ncfname.split('.nc')[0], timei)
    b = bz2.BZ2File(outfn, 'w')
    np.savetxt(b, out, fmt = fm)
    b.close()

def writeoutalldays(ncfname, fm, outdir):
    r = netCDF4.Dataset(ncfname)
    varname = '_'.join(ncfname.split('_')[:-1][3:])
    v = r.variables[varname]
    tt = r.variables['time'].shape[0] 
    for timei in range(tt):
        if v.ndim == 4:
            out = v[timei, 0, :, :]
        elif v.ndim == 3:
            out = v[timei, :, :]
        outfn = '%s/%s_%04i.txt.bz2' % (outdir, ncfname.split('.nc')[0], timei)
        b = bz2.BZ2File(outfn, 'w')
        np.savetxt(b, out, fmt = fm)
        b.close()

if __name__ == '__main__':
    ncfn = sys.argv[1]
    signifdigits = int(sys.argv[3])
    alldays = bool(sys.argv[4] == 'True')
    outdir = sys.argv[5]
    if not os.path.exists(outdir):
        os.makedirs(outdir)
    if alldays:
        writeoutalldays(ncfn, '%%.%sf' % signifdigits, outdir)
    else:
        writeout(ncfn, ti, '%%.%sf' % signifdigits, outdir)
        ti = int(sys.argv[2])
    
