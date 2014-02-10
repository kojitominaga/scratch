"""
usage: python nora10interpmain.py ncfilepath locations.csv scratchdir

use something like $SCRATCH for scratchdir
"""

import os
import sys
import shutil
import netCDF4
import bz2
import numpy as np
import tarfile
import time

fms = {'ta_2m': '%.2f', 
       'ts_0m': '%.2f', 
       'pr': '%.8f', 
       'psl': '%d', 
       'ps': '%d', 
       'pr': '%.5g', 
       'rss': '%.5g', 
       'rls': '%.5g', 
       'wss_10m': '%.2f', 
       'hur_2m': '%.2f', 
       'albedo': '%.2f'}

def writeout(ncfpath, timei, fm, outdir):
    """write out the NORA10 results at the specified time index timei"""
    r = netCDF4.Dataset(ncfname)
    varname = '_'.join(ncfname.split('/')[-1].split('_')[:-1][3:])
    v = r.variables[varname]
    if v.ndim == 4:
        out = v[timei, 0, :, :]
    elif v.ndim == 3:
        out = v[timei, :, :]
    outfn = '%s/%s_%04i.txt.bz2' % (outdir, ncfname.split('.nc')[0], timei)
    b = bz2.BZ2File(outfn, 'w')
    np.savetxt(b, out, fmt = fm)
    b.close()

ncpath = sys.argv[1]  
## use something like /work/users/kojito/nora10/nc/__var__/netcdffilename
## NORA10_1H_11km_ta_2m_1959.nc
locationspath = sys.argv[2]
## use something like /cluster/home/kojito/nora10/locations/locations.csv
scratchdir = sys.argv[3]
## use $SCRATCH

ncfn = ncpath.split('/')[-1]
t1 = ''.join(ncfn.split(".nc")[:-1])
varname = '_'.join(t1.split('_')[3:-1])
year = t1.split('_')[-1] # string
fm = fms[varname]

## create necessary directories if not existing yet
pathprefix = "/work/users/kojito/nora10/"
path1 = '/'.join([pathprefix, "intermediate", "extracted", varname, year])
os.makedirs(path1)
path2 = '/'.join([pathprefix, "intermediate", "interpolated", varname, year])
os.makedirs(path2)
path0s = '/'.join([scratchdir, "nc"])
os.makedirs(path0s)
path1s = '/'.join([scratchdir, "intermediate", "extracted", varname, year])
os.makedirs(path1s)
path2s = '/'.join([scratchdir, "intermediate", "interpolated", varname, year])
os.makedirs(path2s)

## part 1: NetCDF to "extracted"
if os.path.exists('/'.join([path1, "COMPLETED"])):
    print('part 1 is already finished')
else: 
    ## 1) copy netcdf file from /work to $SCRATCH
    ncpathscratch = '/'.join([path0s, ncfn])
    shutil.copy2(ncpath, ncpathscratch)
    
    ## 2) get number of time points (hours or 3-h intervals)
    r = netCDF4.Dataset(ncpathscratch)
    tt = r.variables['time'].shape[0]
    
    ## 3) do or resume part1
    ## 3.1) check how many have been done
    sofar1 = [f for f in os.listdir(path1) if '.tar' in f]
    if len(sofar1) > 1:
        lastii = [int(f.split('.tar')[0].split('-')[1]) for f in sofar1]
        thelasti = max(lastii)
        print('resuming from part 1: time index %i' % (thelasti + 1, ))
    else:
        thelasti = -1
        print('starting newly from part 1')
        
    ## 3.2) run as many as what is not yet done
    for ti in range(thelasti + 1, tt):
        writeout(ncpathscratch, ti, fm, path1s)  ############# computation
        ## 3.2.1) every 100 create tar and send it to path1
        if ti % 100 == 99:
            ti1 = ti - 99
            tfname = '/'.join(path1, '%04i-%04i.tar' % (ti1, ti))
            tf = tarfile.open(tfname, 'w')
            filestoadd = ['%s/%s_%04i.txt.bz2' % (path1s, ncfn, tii) 
                          for tii in range(ti1, ti + 1)]
            for f2add in filestoadd:
                tf.add(f2add, arcname = f2add.split('/')[-1])
            tf.close()
            print('created %s' % tfname)

    ## 3.3) create tar for the last bit (n < 100) and send it to path1
    tti1 = (tt // 100) * 100 
    tfname = '/'.join(path1, '%04i-%04i.tar' % (tti1, tt))
    tf = tarfile.open(tfname, 'w')
    filestoadd = ['%s/%s_%04i.txt.bz2' % (path1s, ncfn, tii) 
                  for tii in range(tti1, tt + 1)]
    for f2add in filestoadd:
        tf.add(f2add, arcname = f2add.split('/')[-1])
    tf.close()
    print('created %s' % tfname)
        
    ## 3.4) make the file with the name COMPLETED
    f = open('/'.join([path1, 'COMPLETED']), 'w')
    f.write(time.strftime('%c', time.gmtime()))
    f.close()
    print('finished part 1 and created file COMPLETE under %s' % path1)
    
## part 2: spatial interpolation
if os.path.exists('/'.join([path2, "COMPLETED"])):
    print('part 2 is already finished')
else:
    ## 1) copy all files from path1 to $SCRATCH
    extractedtarfns = [f for f in list.dir(path1) if '.tar' in f]
    for etfn in extractedfns:
        lastiintar = int(etfn.split('.tar')[0].split('-')[-1])
        lastbz2fintar = '%s/%s_%04i.txt.bz2' % (path1s, ncfn, lastiintar)
        if not os.path.exists(lastbz2fintar):
            ## if it's not restart and following immediately from part 1, 
            ## these files already exist at path1s. This clause deals with 
            ## cases for restarting and therefore still missing .txt.bz2 files
            tf = tarfile.open(etfn, 'r') 
            ## 'rb' not needed though everything in it is binary
            tf.extractall(path = path1s)
            tf.close()
        
    ## 2) get number of time points (hours or 3-h intervals)
    ##    ** This time from file names in path1 **
    if not 'tt' in locals():
        tt = max([int(f.split('.tar')[0].split('-')[-1]) 
                  for f in extractedtarfns])
    ## 3) do or resume part2
    ## 3.1) check how many have been done
    sofar2 = [f for f in os.listdir(path2) if '.tar' in f]
    if len(sofar2) > 1:
        lastii = [int(f.split('.tar')[0].split('-')[1]) for f in sofar2]
        thelasti = max(lastii)
        print('resuming from part 2: time index %i' % (thelasti + 1, ))
    else:
        thelasti = -1
        print('starting newly from part 2')

    ## 3.2) run as many as what is not yet done 
    for ti in range(thelasti + 1, tt): 
        os.system(
