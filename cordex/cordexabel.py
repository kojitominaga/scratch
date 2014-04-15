import os
import sys
import numpy as np
import netCDF4
import geopy.distance

myfmt = '%.8f' ## 8 significant digits, e.g., 53.80798340

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


def writegeog(orogfn, dirname, lname, llat, llon, n):
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
    orog = r.variables['orog'][:, :].flatten()
    dist = np.array([geopy.distance.great_circle((llat, llon), (la, lo)).km
                     for lo, la in zip(lon.tolist(), lat.tolist())])

    ## get the rank
    temp = dist.argsort()
    ranks = np.empty(len(dist), int)
    ranks[temp] = np.arange(len(dist)) # smaller number closer to the loc
    isnearby = ranks < n
    
    if not os.path.exists(dirname): os.makedirs(dirname)
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
    print('[cordexabel.py] writing geography files...')
    isnearby, latpath, lonpath, altpath = \
      writegeog(orogpath, geogdir, lname, llat, llon, n)
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
    if not os.path.exists(resultsdir): os.makedirs(resultsdir)
    print('[cordexabel.py] interpolating -- calling R...')
    command = '%s \\\n%s \\\n%s \\\n%s \\\n%s \\\n%s %s %s \\\n%s' % (
        'Rscript spinterp_cordex.R --args', 
        lonpath, latpath, altpath, txtgzpath, llon, llat, lalt, resultspath)
    print(command)
    return os.system(command)
    
    
    
## usage: Rscript spinterp_cordex.R --args \
##          lonpath latpath orogpath varpath llon llat lalt resultspath

