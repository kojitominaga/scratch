'''usage: python cordexabel.py ncpath orogpath lname llon llat prefix n onlygeog

with default values for prefix = . and n = 500.
'''
import sys
import os
import numpy as np
import netCDF4
import datetime
import time
import pandas as pd

sys.path.append('/cluster/home/kojito/lib/python/site-packages')

import geopy.distance

myfmt = '%.8f' ## 8 significant digits, e.g., 53.80798340
nstats = 42

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
        print('[nora10abel.writegeog()] writing to %s' % lonpath)
        np.savetxt(lonpath, lon[isnearby], fmt = myfmt)
        print('[nora10abel.writegeog()] writing to %s' % latpath)
        np.savetxt(latpath, lat[isnearby], fmt = myfmt)
        print('[nora10abel.writegeog()] writing to %s' % altpath)
        np.savetxt(altpath, orog[isnearby], fmt = '%.2f')
        # np.savetxt(distpath, dist[isnearby], fmt = myfmt) 

    r.close()
    return (isnearby, latpath, lonpath, altpath)


def spinterp(ncpath, orogpath, lname, llat, llon, lalt, 
             prefix = '.', n = 500):
    '''runs the spatial interpolation Rscript for all data along time unit
    in ncfn, using the geography files (see writegeog()) in the directory
    parsefn(getorogfn(ncfn), '.')[0], 
    with the prediction at a new location with longitude (llon), 
    latitude (llat) and altitude (lalt), and write outputs in 
    os.path.join(parsefn(ncfn, '.')[0], lname). 

    llat, llon, lalt: float

    It will create necessary directories.'''

    ncdir, ncfn = os.path.split(ncpath)
    VariableName = '_'.join(ncfn.split('_')[3:-1])
    outdir = '.'
    geogdir = os.path.dirname(orogpath)
    isnearby, latpath, lonpath, altpath = \
      writegeog(orogpath, geogdir, lname, llat, llon, n, dummy = False)
    # writes 3 .txt.gz files     
    txtgzpath = os.path.join(outdir, 'near-%s_%s.txt.gz' % (
        lname, os.path.splitext(ncfn)[0]))
    r = netCDF4.Dataset(ncpath)
    v = r.variables[VariableName]
    t, y, x = v.shape
    print('[nora10abel.py] writing variable file from the .nc file...')
    
    timeres = int(ncfn.split('_')[1][0])
    new = v[:, :, :].reshape((t, y * x))[:, isnearby]
    newdf = pd.DataFrame(new, index = np.repeat(np.arange(t / (24 / timeres)), 
                                                (24 / timeres)))
    dailymean = newdf.groupby(newdf.index).mean().values
    
    np.savetxt(txtgzpath, dailymean, fmt = myfmt)
    # np.savetxt(txtgzpath, v[:, :, :].reshape((t, y * x))[:, isnearby], fmt = myfmt)

    r.close()
    resultspath = os.path.join(outdir, 'interpolated', lname, 
                               'interpolated-%s_%s.txt.gz' % (
                                   lname, os.path.splitext(ncfn)[0]))
    resultsdir = os.path.dirname(resultspath)

    do_interp_flag = True
    
    if not os.path.exists(resultsdir): os.makedirs(resultsdir)
        
    if do_interp_flag:
        print('[nora10abel.py] interpolating -- calling R...')
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
    orogpath = a[2]
    lname = a[3]
    llon = a[4]
    llat = a[5]
    lalt = a[6]
    prefix = '.' if len(a) <= 7 else a[7]
    n = 500 if len(a) <= 8 else int(a[8])
    onlygeog = False if len(a) <= 9 else bool(a[9])
    if onlygeog:
        print('not implemented yet!')
        # print('[nora10abel.py] creating geog files only')
        # ncdir, ncfn = os.path.split(ncpath)
        # orogfn = getorogfn(ncfn)
        # orogpath = os.path.join(ncdir, orogfn)
        # geogdir = parsefn(orogfn, prefix)[0]
        # outdir, VariableName, StartTime, EndTime = parsefn(ncfn, prefix)
        # if not os.path.exists(outdir): os.makedirs(outdir)
        # print('[nora10abel.py] orogpath is %s' % orogpath)
        # if not os.path.exists(orogpath):
        #     print('[nora10abel.py] orogpath does not exist')
        #     pref = '_'.join(orogfn.split('_')[:4])
        #     suff = '_'.join(orogfn.split('_')[-3:])
        #     filelist = os.listdir(ncdir)
        #     alternatives = [f for f in filelist if pref in f and suff in f]
        #     if len(alternatives) > 0:
        #         print('[nora10abel.py] found %s instead' % alternatives[0])
        #         orogfn = alternatives[0]
        #         orogpath = os.path.join(ncdir, orogfn)
        #     else: 
        #         sys.exit('[nora10abel.py] ERROR: could not find the orog file')
        # isnearby, latpath, lonpath, altpath = \
        #   writegeog(orogpath, geogdir, lname, llat, llon, n, dummy = False)
    else:
        spinterp(ncpath, orogpath, lname, llat, llon, lalt, prefix, n)
