import netCDF4
import numpy as np
import sys

vdict = {'ta_2m': 'tas'}
fourdimensional = ('ta_2m', 'ts_0m', 'wss_10m', 'hur_2m')

def makedaily(ncf, ncforog):
    # ncf                                  NORA10_1H_11km_ta_2m_2012.nc
    # ncforog                              NORA10_11km_orog_new3.nc
    vn0 = '_'.join(ncf.split('_')[3:-1])   # ta_2m
    vn = vdict[vn0]                        # tas
    timeres = ncf.split('_')[1]            # 1H
    ncfout = ncf.replace(timeres, '24H')   # NORA10_24H_11km_ta_2m_2012.nc
    year = ncf.strip('.nc').split('_')[-1] # 2012 (string)
    
    print('opening %s for reading' % ncf)
    print('opening %s for reading' % ncforog)
    print('opening %s for writing' % ncfout)
    r = netCDF4.Dataset(ncf)
    ro = netCDF4.Dataset(ncforog)
    r2 = netCDF4.Dataset(ncfout, mode='w')

    v = r.variables[vn0]
    if vn0 in fourdimensional:
        nhours, height, yy, xx = v.shape
    else: 
        nhours, yy, xx = v.shape
    npd = int(timeres.replace('H', '')) # number of data timings per day
    ndays = nhours / (24 / npd)
    
    print('copying root NetCDF attributes')
    for ncattr in r.ncattrs():
        r2.setncattr(ncattr, r.getncattr(ncattr))

    print('creating dimensions and variables')
    r2.createDimension('rlat', yy)
    r2.createDimension('rlon', xx)
    r2.createDimension('time', ndays)
    for vn_ in ('rotated_pole', 'rlon', 'rlat', 'lon', 'lat'):
        r2.createVariable(vn_, r.variables[vn_].datatype, 
                          dimensions=r.variables[vn_].dimensions)
    r2.createVariable('time', int, dimensions=r.variables['time'].dimensions)
    r2.createVariable(vn, r.variables[vn0].datatype, 
                      dimensions=('time', 'rlat', 'rlon'))
    
    print('setting variable specific attributes')
    r2.variables['rotated_pole'].setncattr('grid_north_pole_latitude', 22.0)
    r2.variables['rotated_pole'].setncattr('grid_north_pole_longitude', 140.0)
    r2.variables['rotated_pole'].setncattr('grid_mapping_name', 
                                           'rotated_latitute_longitude')
    for vn_ in ('rlon', 'rlat', 'lon', 'lat', 'time'):
        r2.variables[vn_].setncattr('units', r.variables[vn_].units)
        r2.variables[vn_].setncattr('standard_name', r.variables[vn_].standard_name)
        r2.variables[vn_].setncattr('long_name', r.variables[vn_].long_name)
    for vn_ in ('rlon', 'rlat'):
        r2.variables[vn_].setncattr('axis', r.variables[vn_].axis)
    r2.variables['time'].setncattr('units', 'days since %s-1-1' % year) # overwrites
    r2.variables['time'].setncattr('calendar', 'standard')   
    r2.variables['time'].setncattr('axis', 'T')   
    r2.variables[vn].setncattr('grid_mapping', 'rotated_pole')
    r2.variables[vn].setncattr('coordinates', 'lon lat')
    r2.variables[vn].setncattr('cell_methods', 'time: mean')
    r2.variables[vn].setncattr('standard_name', r.variables[vn0].standard_name)
    r2.variables[vn].setncattr('long_name', r.variables[vn0].long_name)
    r2.variables[vn].setncattr('units', r.variables[vn0].units)
    if vn0 in ('rls', ):
        r2.variables[vn].setncattr('units', r.variables[vn0].units + ' day-1')

    print('copying geographic data')
    for vn_ in ('rlon', 'rlat'):
        r2.variables[vn_][:] = ro.variables[vn_][:]
    for vn_ in ('lon', 'lat'):
        r2.variables[vn_][:, :] = ro.variables[vn_][:, :]

    print('writing day of the year')
    r2.variables['time'][:] = range(ndays)

    print('aggregating and writing daily data')
    for di in range(ndays):
        if di % 100 == 0:
            print('... calculating %sth day' % di)
        ti = np.arange(di * npd, (di + 1) * npd)
        if vn0 in fourdimensional:
            d = r.variables[vn0][ti, 0, :, :].mean(axis=0)
        else:
            d = r.variables[vn0][ti, :, :].mean(axis=0)
        r2.variables[vn][di, :, :] = d

    print('closing all .nc files')
    r.close()
    ro.close()
    r2.close()

if __name__ == '__main__':
    ncf = sys.argv[1]
    ncforog = sys.argv[2]
    makedaily(ncf, ncforog)




