'''usage: python cordexabel.py ncpath lname llon llat prefix n onlygeog

with default values for prefix = . and n = 500.
'''
import sys
import os
import numpy as np
import netCDF4
import datetime
import time

sys.path.append('/cluster/home/kojito/lib/python/site-packages')

import geopy.distance

myfmt = '%.8f' ## 8 significant digits, e.g., 53.80798340
nstats = 42

with open('RCMModelName.txt') as f:
    RCMlist = [l.rstrip().split()[:2] for l in f.readlines() if not l[0] == '#']
    RCMdict = dict(RCMlist)

def parsefn(fn, prefix = '.'):
    '''parses the cordex file name and returns 
    (the directory directory path, VariableName, StartTime, EndTime)
    StartTime and EndTime are None if Frequency is not day'''
    
    assert fn[-3:] == '.nc', 'the file name has to have .nc'
    elements = fn.strip()[:-3].split('_')
    VariableName = elements[0]
    Domain = elements[1]
    GCMModelName = elements[2]
    CMIP5ExperimentName = elements[3]
    CMIP5EnsembleMember = elements[4]
    RCMModelName = elements[5]
    try:
        Institute = RCMdict[RCMModelName]
    except KeyError:
        sys.exit('RCM Model name not found')
    RCMVersionID = elements[6]
    Frequency = elements[7]
    StartTime = None
    EndTime = None
    if Frequency == 'day':
        StartTime, EndTime = elements[8].split('-')
    dirpath = os.path.join(prefix, Domain, Institute, GCMModelName, 
                           CMIP5ExperimentName, CMIP5EnsembleMember, 
                           RCMModelName, RCMVersionID, Frequency, VariableName)
    return (dirpath, VariableName, StartTime, EndTime)


def getorogfn(fn):
    '''returns the corresponding orography .nc file name'''
    
    assert fn[-3:] == '.nc', 'the file name has to have .nc'
    elements = fn.strip()[:-3].split('_')
    # VariableName = 'orog'
    # Domain = elements[1]
    # GCMModelName = elements[2]
    # CMIP5ExperimentName = elements[3]
    # CMIP5EnsembleMember = elements[4]
    # RCMModelName = elements[5]
    # RCMVersionID = elements[6]
    # Frequency = 'fx'
    orogfn = '_'.join(['orog'] + elements[1:7] + ['fx']) + '.nc'
    return orogfn


def writegeog(orogfn, dirname, lname, llat, llon, n, dummy = False):
    '''extracts geographical information (longitude, latitude, altitude)
    from orography .nc file. 
    
    Writes 3 files in dirname. "near-LOCATION-altitude.txt.gz" etc. 
    
    It also returns tuple of 4 elements:
    
    1) the boolean ndarray isnearby, the nearest n vertices being True
    2) latpath
    3) lonpath
    4) altpath
    '''
    
    latfn = 'near-%s_latitude.txt.gz' % lname
    latpath = os.path.join(dirname, latfn)
    lonfn = 'near-%s_longitude.txt.gz' % lname
    lonpath = os.path.join(dirname, lonfn)
    altfn = 'near-%s_altitude.txt.gz' % lname
    altpath = os.path.join(dirname, altfn)
    # distfn = 'near_%s-distance.txt.gz' % lname
    # distpath = os.path.join(dirname, distfn)
    r = netCDF4.Dataset(orogfn)
    lon = r.variables['lon'][:, :].flatten()
    lat = r.variables['lat'][:, :].flatten()
    dist = np.array([geopy.distance.great_circle((llat, llon), (la, lo)).km
                     for lo, la in zip(lon.tolist(), lat.tolist())])
    
    ## get the rank
    temp = dist.argsort()
    ranks = np.empty(len(dist), int)
    ranks[temp] = np.arange(len(dist)) # smaller number closer to the loc
    isnearby = ranks < n
    
    if not os.path.exists(dirname): os.makedirs(dirname)
    if not dummy:
        orog = r.variables['orog'][:, :].flatten()
        np.savetxt(lonpath, lon[isnearby], fmt = myfmt)
        np.savetxt(latpath, lat[isnearby], fmt = myfmt)
        np.savetxt(altpath, orog[isnearby], fmt = '%.2f')
        # np.savetxt(distpath, dist[isnearby], fmt = myfmt) 

    r.close()
    return (isnearby, latpath, lonpath, altpath)


def spinterp(ncpath, lname, llat, llon, lalt, prefix = '.', n = 500):
    '''runs the spatial interpolation Rscript for all data along time unit
    in ncfn, using the geography files (see writegeog()) in the directory
    parsefn(getorogfn(ncfn), '.')[0], 
    with the prediction at a new location with longitude (llon), 
    latitude (llat) and altitude (lalt), and write outputs in 
    os.path.join(parsefn(ncfn, '.')[0], lname). 

    llat, llon, lalt: float

    It will create necessary directories.'''

    ncdir, ncfn = os.path.split(ncpath)
    orogfn = getorogfn(ncfn)
    orogpath = os.path.join(ncdir, orogfn)
    geogdir = parsefn(orogfn, prefix)[0]
    outdir, VariableName, StartTime, EndTime = parsefn(ncfn, prefix)
    if not os.path.exists(outdir): os.makedirs(outdir)
    print('[cordexabel.py] orogpath is %s' % orogpath)
    if not os.path.exists(orogpath):
        print('[cordexabel.py] orogpath does not exist')
        prefix = '_'.join(orogfn.split('_')[:4])
        suffix = '_'.join(orogfn.split('_')[-3:])
        filelist = os.listdir(ncdir)
        alternatives = [f for f in filelist if prefix in f and suffix in f]
        if len(alternatives) > 0:
            print('[cordexabel.py] found %s instead' % alternatives[0])
            orogfn = alternatives[0]
            orogpath = os.path.join(ncdir, orogfn)
        else: 
            sys.exit('[cordexabel.py] ERROR: could not find the orog file')
            
    isnearby, latpath, lonpath, altpath = \
      writegeog(orogpath, geogdir, lname, llat, llon, n, dummy = True)

    # make_geog_flag = True
    # wait_flag = False
    # flag1 = False
    # flag2 = False
    # flag3 = False

    # if os.path.exists(latpath):
    #     wait_flag = True
    #     print('[cordexabel.py] latpath already exists')
    #     lat = np.loadtxt(latpath)
    #     condition1 = lat.shape[0] == n
    #     condition2 = np.isnan(lat).sum() == 0
    #     if condition1 and condition2:
    #         print('[cordexabel.py] latpath is already a complete file')
    #         flag1 = True
    # if os.path.exists(lonpath):
    #     wait_flag = True
    #     print('[cordexabel.py] lonpath already exists')
    #     lon = np.loadtxt(latpath)
    #     condition1 = lon.shape[0] == n
    #     condition2 = np.isnan(lon).sum() == 0
    #     if condition1 and condition2:
    #         print('[cordexabel.py] lonpath is already a complete file')
    #         flag2 = True
    # if os.path.exists(altpath):
    #     wait_flag = True
    #     print('[cordexabel.py] altpath already exists')
    #     alt = np.genfromtxt(altpath)
    #     condition1 = alt.shape[0] == n
    #     condition2 = np.isnan(alt).sum() == 0
    #     if condition1 and condition2:
    #         print('[cordexabel.py] altpath is already a complete file')
    #         flag3 = True
    # if flag1 and flag2 and flag3:
    #     make_geo_flag = False
    #     print('[cordexabel.py] all geog files already exists and therefore will not be made this time')
    # if make_geog_flag and wait_flag:
    #     time.sleep(20)
    # if make_geog_flag:
    #     print('[cordexabel.py] writing geography files...')
    #     isnearby, latpath, lonpath, altpath = \
    #       writegeog(orogpath, geogdir, lname, llat, llon, n, dummy = False)
          
    # writes 3 .txt.gz files     
    txtgzpath = os.path.join(outdir, 'near-%s_%s.txt.gz' % (
        lname, os.path.splitext(ncfn)[0]))
    r = netCDF4.Dataset(ncpath)
    v = r.variables[VariableName]
    t, y, x = v.shape
    print('[cordexabel.py] writing variable file from the .nc file...')
    np.savetxt(txtgzpath, v[:, :, :].reshape((t, y * x))[:, isnearby], fmt = myfmt)
    r.close()
    resultspath = os.path.join(outdir, 'interpolated', lname, 
                               'interpolated-%s_%s.txt.gz' % (
                                   lname, os.path.splitext(ncfn)[0]))
    resultsdir = os.path.dirname(resultspath)

    do_interp_flag = True
    
    if not os.path.exists(resultsdir): os.makedirs(resultsdir)
        
    # if os.path.exists(resultspath):
    #     print('[cordexabel.py] resultspath already exists')
    #     print('[cordexabel.py] checking whether it appears to be complete...')
    #     startdate_s, enddate_s = \
    #       os.path.basename(resultspath).split('.txt.gz')[0].split('_')[-1].split('-')
    #     n_days = 1 + \
    #       (datetime.date(int(enddate_s[:4]), 
    #                      int(enddate_s[4:6]), 
    #                      int(enddate_s[6:])) - 
    #        datetime.date(int(startdate_s[:4]), 
    #                      int(startdate_s[4:6]), 
    #                      int(startdate_s[6:]))).days
    #     print('[cordexabel.py] %s to %s, %s days' % (
    #         startdate_s, enddate_s, n_days))
    #     results = np.loadtxt(resultspath)
    #     nrow, ncol = results.shape
    #     if (nrow == n_days and ncol == nstats):
    #         print('[cordexabel.py] the already existing results looks complete, finishing')
    #         do_interp_flag = False
    #     else:
    #         print('[cordexabel.py] the already existing results is imcomplete')
    #     return None
    if do_interp_flag:
        print('[cordexabel.py] interpolating -- calling R...')
        ## usage: Rscript spinterp_cordex.R --args \
        ##        lonpath latpath orogpath varpath llon llat lalt resultspath
        command = '%s \\\n%s \\\n%s \\\n%s \\\n%s \\\n%s %s %s \\\n%s' % (
          'Rscript spinterp_cordex.R --args', 
          lonpath, latpath, altpath, txtgzpath, llon, llat, lalt, resultspath)
        print(command)
        os.system(command)
    os.unlink(txtgzpath)

if __name__ == '__main__':
    a = sys.argv
    ncpath = a[1]
    lname = a[2]
    llon = a[3]
    llat = a[4]
    lalt = a[5]
    prefix = '.' if len(a) <= 6 else a[6]
    n = 500 if len(a) <= 7 else int(a[7])
    onlygeog = False if len(a) <= 8 else bool(a[8])
    if onlygeog:
        print('[cordexabel.py] creating geog files only')
        ncdir, ncfn = os.path.split(ncpath)
        orogfn = getorogfn(ncfn)
        orogpath = os.path.join(ncdir, orogfn)
        geogdir = parsefn(orogfn, prefix)[0]
        outdir, VariableName, StartTime, EndTime = parsefn(ncfn, prefix)
        if not os.path.exists(outdir): os.makedirs(outdir)
        print('[cordexabel.py] orogpath is %s' % orogpath)
        if not os.path.exists(orogpath):
            print('[cordexabel.py] orogpath does not exist')
            prefix = '_'.join(orogfn.split('_')[:4])
            suffix = '_'.join(orogfn.split('_')[-3:])
            filelist = os.listdir(ncdir)
            alternatives = [f for f in filelist if prefix in f and suffix in f]
            if len(alternatives) > 0:
                print('[cordexabel.py] found %s instead' % alternatives[0])
                orogfn = alternatives[0]
                orogpath = os.path.join(ncdir, orogfn)
            else: 
                sys.exit('[cordexabel.py] ERROR: could not find the orog file')
        isnearby, latpath, lonpath, altpath = \
          writegeog(orogpath, geogdir, lname, llat, llon, n, dummy = False)
    else:
        spinterp(ncpath, lname, llat, llon, lalt, prefix, n)
