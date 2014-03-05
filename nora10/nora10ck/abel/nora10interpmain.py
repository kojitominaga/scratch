"""
usage: python nora10interpmain.py ncfilepath locations.csv scratchdir tarsplitn ntime

ntime == all means to do all hours or 3h intervals
ntime == mean24 means to do the interpolation on daily mean
ntime == 120 means to do the first 120 hours or 5 days (for 1H data)

use something like $SCRATCH for scratchdir
"""

import os
import sys
import shutil
import netCDF4
import bz2
import gzip
import numpy as np
import tarfile
import time

fms = {'ta_2m':  '%.2f', 
       'ts_0m':  '%.2f', 
       'pr':     '%.8f', 
       'psl':    '%d', 
       'ps':     '%d', 
       'rss':    '%.5g', 
       'rls':    '%.3f', 
       'wss_10m': '%.2f', 
       'wfds_10m': '%.1f'
       'hur_2m': '%.2f', 
       'albedo': '%.2f', 
       'clt':    '%.4f'}

testingflag = True


def writeout(ncfpath, timei, fm, outdir, interval = None, appendfn = None):
    """write out the NORA10 results at the specified time index timei
    if appendfn: write plan text simply append to os.path.join(outdir, appendfn)
    else: write a gz file in outdir
    """
    r = netCDF4.Dataset(ncfpath)
    varname = '_'.join(os.path.basename(ncfpath).split('_')[:-1][3:])
    v = r.variables[varname]
    if interval:
        iinterval = int(interval)
        if v.ndim == 4:
            out2 = v[(timei * iinterval):((timei + 1) * iinterval), 0, :, :]
        elif v.ndim == 3:
            out2 = v[(timei * iinterval):((timei + 1) * iinterval), :, :]
        out = out2.mean(axis = 0) # takes daily mean 
    else:
        if v.ndim == 4:
            out = v[timei, 0, :, :]
        elif v.ndim == 3:
            out = v[timei, :, :]
    if appendfn:
        g = gzip.GzipFile(os.path.join(outdir, appendfn), 'ab')
        np.savetxt(g, out, fmt = fm)
        g.close()
    else:
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
lbfn = os.path.splitext(os.path.basename(locationspath))[0] 
## location file base name

scratchdir = sys.argv[3]
## use $SCRATCH

tarsplitn = int(sys.argv[4]) ## for example 10
ntimearg = sys.argv[5] ## will handle later, see part1, 2) and variable tt

f = open(locationspath, 'r')
throwaway = f.readline()
locations = [l.strip().split(',')[0] 
             for l in f.readlines() if len(l.strip()) > 0]
print(locations)
f.close()

if not len(locations) == 1:
    sys.exit('I have decided not to support to do more than 1 locations')
else: 
    lbfn = locations[0]

ncfn = os.path.basename(ncpath)
ncfn2 = os.path.splitext(ncfn)[0]
varname = '_'.join(ncfn2.split('_')[3:-1])
year = ncfn2.split('_')[-1] # string
fm = fms[varname]

## create necessary directories if not existing yet
pathprefix = "/work/users/kojito/nora10"
path1 = os.path.join(pathprefix, "intermediate", lbfn, varname, ntimearg, year)
if not os.path.exists(path1): os.makedirs(path1)
path2 = os.path.join(pathprefix, "interpolated", lbfn, varname, ntimearg, year)
if not os.path.exists(path2): os.makedirs(path2)
path0s = os.path.join(scratchdir, "nc", lbfn, varname, ntimearg, year)
if not os.path.exists(path0s): os.makedirs(path0s)
path1s = os.path.join(scratchdir, "intermediate", lbfn, varname, ntimearg, year)
if not os.path.exists(path1s): os.makedirs(path1s)
path2s = os.path.join(scratchdir, "interpolated", lbfn, varname, ntimearg, year)
if not os.path.exists(path2s): os.makedirs(path2s)

## part 1: NetCDF to "extracted"
completedexists = os.path.exists(os.path.join(path1, "COMPLETED"))
# sofar0 = [f for f in os.listdir(path1) if os.path.splitext(f)[1] == '.tar']
# sofar0empty = [os.path.getsize(os.path.join(path1, f)) for f in sofar0]
# if completedexists and not any(sofar0empty):
if completedexists:
    print('part 1 is already finished')
else: 
    ## 1) copy netcdf file from /work to $SCRATCH
    ncpathscratch = os.path.join(path0s, ncfn)
    print('copying NetCDF file...')
    shutil.copy2(ncpath, ncpathscratch)
    print('... done')

    flagmean = False
    ## 2) get number of time points (hours or 3-h intervals)
    if ntimearg == 'all':
        r = netCDF4.Dataset(ncpathscratch)
        tt = r.variables['time'].shape[0]
    elif 'mean' in ntimearg:
        r = netCDF4.Dataset(ncpathscratch)
        tt = r.variables['time'].shape[0]
        interval = int(ntimearg[4:])
        tt /= interval
        flagmean = True
    else:
        tt = int(ntimearg)
    print('ntimearg: ' + str(ntimearg))
    print('tt: ' + str(tt))
    
    ## 3) do or resume part1
    ## 3.1) check how many have been done
    if testingflag:
        sofar1 = [f for f in os.listdir(path1) 
                  if os.path.splitext(f)[1] == '.gz']
    else:
        sofar1 = [f for f in os.listdir(path1) 
                  if os.path.splitext(f)[1] == '.tar']


    # if len(sofar1) > 1:
    #     if testingflag:
    #         lastii = [int(f.split('.')[0].split('-')[1]) for f in sofar1]
    #     else:
    #         lastii = [int(os.path.splitext(f)[0].split('-')[1]) for f in sofar1]
    #     ## expecting name like 0000-0009.tar
    #     thelasti = max(lastii)
    #     print('resuming from part 1: time index %i' % (thelasti + 1, ))
    # else:
    #     thelasti = -1
    #     print('starting newly from part 1')
        
    ## temporary fix: these files may result unfinished so we should always 
    ## do it from the beginning unless COMPLETED is seen
    thelasti = -1
    print('starting newly from part 1')


    
    ## 3.2) run as many as what is not yet done
    if testingflag:
        gzfname = '%04i-%04i.txt.gz' % (
            thelasti + 1, 
            thelasti + tarsplitn if thelasti + tarsplitn <= tt - 1 else tt - 1)
        print(gzfname)
    for ti in range(thelasti + 1, tt):
        print(ti)
        if testingflag:
            if flagmean:
                writeout(ncpathscratch, ti, fm, path1s, interval = interval, 
                         appendfn = os.path.join(path1s, gzfname))
            else:
                writeout(ncpathscratch, ti, fm, path1s, interval = None, 
                         appendfn = os.path.join(path1s, gzfname))
            ## every __tarsplitn__, send .txt.gz and update gzfname
            if ti == tt - 1:
                shutil.copy(os.path.join(path1s, gzfname), 
                            os.path.join(path1, gzfname))
            if ti % tarsplitn == (tarsplitn - 1): 
                shutil.copy(os.path.join(path1s, gzfname), 
                            os.path.join(path1, gzfname))
                gzfname = '%04i-%04i.txt.gz' % (
                    ti + 1, 
                    ti + tarsplitn if ti + tarsplitn <= tt - 1 else tt - 1)
                print(gzfname)
        else:
            if flagmean:
                writeout(ncpathscratch, ti, fm, path1s, interval = interval)
            else:
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
    if not testingflag:
        if not (tt % tarsplitn == 0):
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
    if testingflag:
        gzfiles = [f for f in os.listdir(path1)
                   if os.path.splitext(f)[1] == '.gz']
        for gzfile in gzfiles:
            if not os.path.exists(os.path.join(path1s, gzfile)):
                shutil.copy(os.path.join(path1, gzfile), 
                            os.path.join(path1s, gzfile))
    else:
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
        if testingflag:
            tt = 1 + max([int(f.split('.')[0].split('-')[-1]) 
                          for f in gzfiles])
        else:
            tt = 1 + max([int(os.path.splitext(f)[0].split('-')[-1]) 
                          for f in extractedtarfns])
    print('tt %s' % tt)
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
    suffix3 = 'variograms_cutoff_100.RData'
    ## 3.2) run as many as what is not yet done
    indices1 = range(thelasti + 1, tt, tarsplitn)
    indices2 = indices1[1:] + [tt]
    indiceszip = zip(indices1, indices2)
    for indices in indiceszip:
        tis = range(indices[0], indices[1])
        argument_ti = ','.join([str(ti) for ti in tis])
        if testingflag:
            argument_rawpath = \
              os.path.join(path1s, 
                           '%04i-%04i.txt.gz' % (indices[0], indices[1] - 1))
        else:
            argument_rawpath = \
              ','.join([os.path.join(path1s, '%s_%04i' % (ncfn2, ti) 
                                     + '.txt.bz2')
                        for ti in tis])
        cmd = 'Rscript %s --args %s %s %s %s %s %s %s' % (
            'spatial_interpolation_abel.R',
            varname, year, argument_ti, argument_rawpath, 
            path2s, ncfn, locationspath)
        print(cmd)
        os.system(cmd)
        tfname = os.path.join(path2, '%04i-%04i.tar' % (indices[0], indices[1] - 1))
        print('...creating %s' % tfname)
        tf = tarfile.open(tfname, 'w')
        filestoadd1 = [os.path.join(path2s, 'pred', 
                       '%s_%04i_%s_%s' % (ncfn2, ti, location, suffix1)) 
                       for ti in tis for location in locations]
        filestoadd2 = [os.path.join(path2s, 'meta', 
                       '%s_%04i_%s_%s' % (ncfn2, ti, location, suffix2))
                       for ti in tis for location in locations]
        filestoadd3 = [os.path.join(path2s, 'vario', 
                       '%s_%04i_%s_%s' % (ncfn2, ti, location, suffix3))
                       for ti in tis for location in locations]
        filestoadd = filestoadd1 + filestoadd2 + filestoadd3
        for f2add in filestoadd:
            print(f2add)
            tf.add(f2add, arcname = os.path.basename(f2add))
        tf.close()
        print('...created %s' % tfname)

    # ## 3.2) run as many as what is not yet done 
    # for ti in range(thelasti + 1, tt): 
    #     cmd = 'Rscript %s --args %s %s %s %s %s %s %s' % (
    #         'spatial_interpolation_abel.R',
    #         varname, year, ti, 
    #         os.path.join(path1s, '%s_%04i' % (ncfn2, ti) + '.txt.bz2'), 
    #         path2s, ncfn, locationspath)
    #     print(cmd)
    #     os.system(cmd)
    #     ## 3.2.1) every __tarsplitn__ create tar and send it to path2
    #     if ti % tarsplitn == (tarsplitn - 1):
    #         ti1 = ti - (tarsplitn - 1)
    #         tfname = os.path.join(path2, '%04i-%04i.tar' % (ti1, ti))
    #         tf = tarfile.open(tfname, 'w')
    #         filestoadd1 = [os.path.join(path2s, location, varname, 'pred', 
    #                         '%s_%04i_%s_%s' % (ncfn2, tii, location, suffix1)) 
    #                         for tii in range(ti1, ti + 1) 
    #                         for location in locations]
    #         filestoadd2 = [os.path.join(path2s, location, varname, 'meta', 
    #                         '%s_%04i_%s_%s' % (ncfn2, tii, location, suffix2))
    #                         for tii in range(ti1, ti + 1) 
    #                         for location in locations]
    #         filestoadd3 = [os.path.join(path2s, location, varname, 'vario', 
    #                         '%s_%04i_%s_%s' % (ncfn2, tii, location, suffix3))
    #                         for tii in range(ti1, ti + 1) 
    #                         for location in locations]
    #         filestoadd = filestoadd1 + filestoadd2 + filestoadd3
    #         for f2add in filestoadd:
    #             print(f2add)
    #             tf.add(f2add, arcname = os.path.basename(f2add))
    #         tf.close()
    #         print('created %s' % tfname)

    # ## 3.3) create tar for the last bit (n < __tarsplitn__) and send it to path1
    # if not (tt % tarsplitn == 0):
    #     tti1 = (tt // tarsplitn) * tarsplitn 
    #     tfname = os.path.join(path2, '%04i-%04i.tar' % (tti1, tt - 1))
    #     tf = tarfile.open(tfname, 'w')
    #     filestoadd1 = [os.path.join(path2s, location, varname, 'pred', 
    #                                 '%s_%04i_%s_%s' % (ncfn2, tii, 
    #                                                    location, suffix1)) 
    #                                 for tii in range(tti1, tt) 
    #                                 for location in locations]
    #     filestoadd2 = [os.path.join(path2s, location, varname, 'meta', 
    #                                 '%s_%04i_%s_%s' % (ncfn2, tii, 
    #                                                    location, suffix2))
    #                                 for tii in range(tti1, tt) 
    #                                 for location in locations]
    #     filestoadd3 = [os.path.join(path2s, location, varname, 'vario', 
    #                                 '%s_%04i_%s_%s' % (ncfn2, tii, 
    #                                                    location, suffix3))
    #                                 for tii in range(tti1, tt) 
    #                                 for location in locations]
    #     filestoadd = filestoadd1 + filestoadd2 + filestoadd3
    #     for f2add in filestoadd:
    #         print(f2add)
    #         tf.add(f2add, arcname = os.path.basename(f2add))
    #     tf.close()
    #     print('created %s' % tfname)
        
    ## 3.4) make the file with the name COMPLETED
    f = open(os.path.join(path2, 'COMPLETED'), 'w')
    f.write(time.strftime('%c', time.gmtime()))
    f.close()
    print('finished part 2 and created file COMPLETE under %s' % path2)
