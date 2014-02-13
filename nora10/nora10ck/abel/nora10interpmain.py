"""
usage: python nora10interpmain.py ncfilepath locations.csv scratchdir tarsplitn ntime

ntime == all means to do all hours or 3h intervals
ntime == 120 means to do the first 120 hours or 5 days (for 1H data)

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

fms = {'ta_2m':  '%.2f', 
       'ts_0m':  '%.2f', 
       'pr':     '%.8f', 
       'psl':    '%d', 
       'ps':     '%d', 
       'rss':    '%.5g', 
       'rls':    '%.5g', 
       'wss_10m': '%.2f', 
       'hur_2m': '%.2f', 
       'albedo': '%.2f'}

def writeout(ncfpath, timei, fm, outdir):
    """write out the NORA10 results at the specified time index timei"""
    r = netCDF4.Dataset(ncfpath)
    varname = '_'.join(os.path.basename(ncfpath).split('_')[:-1][3:])
    v = r.variables[varname]
    if v.ndim == 4:
        out = v[timei, 0, :, :]
    elif v.ndim == 3:
        out = v[timei, :, :]
    ncfname = os.path.basename(ncfpath)
    outfn = '%s_%04i.txt.bz2' % (os.path.splitext(ncfname)[0], timei)
    outpath = os.path.join(outdir, outfn)
    b = bz2.BZ2File(outpath, 'w')
    np.savetxt(b, out, fmt = fm)
    b.close()

ncpath = sys.argv[1]  
## use something like /work/users/kojito/nora10/nc/__var__/netcdffilename
## NORA10_1H_11km_ta_2m_1959.nc

locationspath = sys.argv[2]
## use something like /cluster/home/kojito/nora10/locations/locations.csv
lbfn = os.path.splitext(os.path.basename(locationspath))[0] # location file base name

scratchdir = sys.argv[3]
## use $SCRATCH

tarsplitn = int(sys.argv[4]) ## for example 10
ntimearg = sys.argv[5] ## will handle later, see part1, 2) and variable tt

f = open(locationspath, 'r')
throwaway = f.readline()
locations = [l.strip().split(',')[0] for l in f.readlines() if len(l.strip()) > 0]
print(locations)
f.close()

ncfn = os.path.basename(ncpath)
ncfn2 = os.path.splitext(ncfn)[0]
varname = '_'.join(ncfn2.split('_')[3:-1])
year = ncfn2.split('_')[-1] # string
fm = fms[varname]

## create necessary directories if not existing yet
pathprefix = "/work/users/kojito/nora10"
path1 = os.path.join(pathprefix, "intermediate", lbfn, varname, year)
if not os.path.exists(path1): os.makedirs(path1)
path2 = os.path.join(pathprefix, "interpolated", lbfn, varname, year)
if not os.path.exists(path2): os.makedirs(path2)
path0s = os.path.join(scratchdir, "nc")
if not os.path.exists(path0s): os.makedirs(path0s)
path1s = os.path.join(scratchdir, "intermediate", lbfn, varname, year)
if not os.path.exists(path1s): os.makedirs(path1s)
path2s = os.path.join(scratchdir, "interpolated", lbfn, varname, year)
if not os.path.exists(path2s): os.makedirs(path2s)

## part 1: NetCDF to "extracted"
if os.path.exists(os.path.join(path1, "COMPLETED")):
    print('part 1 is already finished')
else: 
    ## 1) copy netcdf file from /work to $SCRATCH
    ncpathscratch = os.path.join(path0s, ncfn)
    print('copying NetCDF file...')
    shutil.copy2(ncpath, ncpathscratch)
    print('... done')
    
    ## 2) get number of time points (hours or 3-h intervals)
    if ntimearg == 'all':
        r = netCDF4.Dataset(ncpathscratch)
        tt = r.variables['time'].shape[0]
    else:
        tt = int(ntimearg)
    
    ## 3) do or resume part1
    ## 3.1) check how many have been done
    sofar1 = [f for f in os.listdir(path1) if os.path.splitext(f)[1] == '.tar']
    if len(sofar1) > 1:
        lastii = [int(os.path.splitext(f)[0].split('-')[1]) for f in sofar1]
        ## expecting name like 0000-0010.tar
        thelasti = max(lastii)
        print('resuming from part 1: time index %i' % (thelasti + 1, ))
    else:
        thelasti = -1
        print('starting newly from part 1')
        
    ## 3.2) run as many as what is not yet done
    for ti in range(thelasti + 1, tt):
        print(ti)
        writeout(ncpathscratch, ti, fm, path1s)  ############# computation
        ## 3.2.1) every __tarsplitn__ create tar and send it to path1
        if ti % tarsplitn == (tarsplitn - 1):
            ti1 = ti - (tarsplitn - 1)
            tfname = os.path.join(path1, '%04i-%04i.tar' % (ti1, ti))
            tf = tarfile.open(tfname, 'w')
            filestoadd = [os.path.join(path1s, '%s_%04i.txt.bz2' % (ncfn2, tii)) 
                          for tii in range(ti1, ti + 1)]
            for f2add in filestoadd:
                tf.add(f2add, arcname = os.path.basename(f2add))
            tf.close()
            print('created %s' % tfname)

    ## 3.3) create tar for the last bit (n < __tarsplitn__) and send it to path1
    tti1 = (tt // tarsplitn) * tarsplitn 
    tfname = os.path.join(path1, '%04i-%04i.tar' % (tti1, tt - 1))
    tf = tarfile.open(tfname, 'w')
    filestoadd = [os.path.join(path1s, '%s_%04i.txt.bz2' % (ncfn2, tii)) 
                  for tii in range(tti1, tt)]
    for f2add in filestoadd:
        print(f2add)
        tf.add(f2add, arcname = os.path.basename(f2add))
    tf.close()
    print('created %s' % tfname)
        
    ## 3.4) make the file with the name COMPLETED
    f = open(os.path.join(path1, 'COMPLETED'), 'w')
    f.write(time.strftime('%c', time.gmtime()))
    f.close()
    print('finished part 1 and created file COMPLETE under %s' % path1)
    
## part 2: spatial interpolation
if os.path.exists(os.path.join(path2, "COMPLETED")):
    print('part 2 is already finished')
else:
    ## 1) copy all files from path1 to $SCRATCH
    extractedtarfns = [f for f in os.listdir(path1) 
                       if os.path.splitext(f)[1] == '.tar']
    print(extractedtarfns)
    for etfn in extractedtarfns:
        lastiintar = int(os.path.splitext(etfn)[0].split('-')[-1])
        lastbz2fintar = os.path.join(path1s, 
                                     '%s_%04i.txt.bz2' % (ncfn, lastiintar))
        if not os.path.exists(lastbz2fintar):
            ## if it's not restart and following immediately from part 1, 
            ## these files already exist at path1s. This clause deals with 
            ## cases for restarting and therefore still missing .txt.bz2 files
            toopen = os.path.join(path1, etfn)
            print(toopen)
            tf = tarfile.open(toopen, 'r') 
            ## 'rb' not needed though everything in it is binary
            tf.extractall(path = path1s)
            tf.close()
        
    ## 2) get number of time points (hours or 3-h intervals)
    ##    ** This time from file names in path1 **
    if not 'tt' in locals():
        tt = max([int(os.path.splitext(f)[0].split('-')[-1]) 
                  for f in extractedtarfns])
    ## 3) do or resume part2
    ## 3.1) check how many have been done
    sofar2 = [f for f in os.listdir(path2) if os.path.splitext(f)[1] == '.tar']
    if len(sofar2) > 1:
        lastii = [int(os.path.splitext(f)[0].split('-')[1]) for f in sofar2]
        thelasti = max(lastii)
        print('resuming from part 2: time index %i' % (thelasti + 1, ))
    else:
        thelasti = -1
        print('starting newly from part 2')

    ## suffices preparation for 3.2.1 and 3.3
    suffix1 = 'interpolated_cutoff_100_nlocal_50.txt'
    suffix2 = 'metadatainterp_cutoff_100_nlocal_50.txt'
    suffix3 = 'variograms_cutoff_50.RData'
    ## 3.2) run as many as what is not yet done 
    for ti in range(thelasti + 1, tt): 
        cmd = 'Rscript %s --args %s %s %s %s %s %s %s' % (
            'spatial_interpolation_abel.R',
            varname, year, ti, 
            os.path.join(path1s, '/%s_%04i' % (ncfn2, ti) + '.txt.bz2'), 
            path2s, ncfn, locationspath)
        print(cmd)
        os.system(cmd)
        ## 3.2.1) every __tarsplitn__ create tar and send it to path2
        if ti % tarsplitn == (tarsplitn - 1):
            ti1 = ti - (tarsplitn - 1)
            tfname = os.path.join(path2, '%04i-%04i.tar' % (ti1, ti))
            tf = tarfile.open(tfname, 'w')
            filestoadd1 = [os.path.join(path2s, location, varname, 'pred', 
                            '%s_%04i_%s_%s' % (ncfn2, tii, location, suffix1)) 
                            for tii in range(ti1, ti + 1) 
                            for location in locations]
            filestoadd2 = [os.path.join(path2s, location, varname, 'meta', 
                            '%s_%04i_%s_%s' % (ncfn2, tii, location, suffix2))
                            for tii in range(ti1, ti + 1) 
                            for location in locations]
            filestoadd3 = [os.path.join(path2s, location, varname, 'vario', 
                            '%s_%04i_%s_%s' % (ncfn2, tii, location, suffix3))
                            for tii in range(ti1, ti + 1) 
                            for location in locations]
            filestoadd = filestoadd1 + filestoadd2 + filestoadd3
            for f2add in filestoadd:
                print(f2add)
                tf.add(f2add, arcname = os.path.basename(f2add))
            tf.close()
            print('created %s' % tfname)

    ## 3.3) create tar for the last bit (n < __tarsplitn__) and send it to path1
    tti1 = (tt // tarsplitn) * tarsplitn 
    tfname = os.path.join(path2, '%04i-%04i.tar' % (tti1, tt - 1))
    tf = tarfile.open(tfname, 'w')
    filestoadd1 = [os.path.join(path2s, location, varname, 'pred', 
                    '%s_%04i_%s_%s' % (ncfn2, tii, location, suffix1)) 
                    for tii in range(tti1, tt) 
                    for location in locations]
    filestoadd2 = [os.path.join(path2s, location, varname, 'meta', 
                    '%s_%04i_%s_%s' % (ncfn2, tii, location, suffix2))
                    for tii in range(tti1, tt) 
                    for location in locations]
    filestoadd3 = [os.path.join(path2s, location, varname, 'vario', 
                    '%s_%04i_%s_%s' % (ncfn2, tii, location, suffix3))
                    for tii in range(tti1, tt) 
                    for location in locations]
    filestoadd = filestoadd1 + filestoadd2 + filestoadd3
    for f2add in filestoadd:
        print(f2add)
        tf.add(f2add, arcname = os.path.basename(f2add))
    tf.close()
    print('created %s' % tfname)
        
    ## 3.4) make the file with the name COMPLETED
    f = open(os.path.join(path2, 'COMPLETED'), 'w')
    f.write(time.strftime('%c', time.gmtime()))
    f.close()
    print('finished part 2 and created file COMPLETE under %s' % path2)
