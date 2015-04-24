import netCDF4
import numpy as np
import sys

vdict = {'ta_2m': 'tas'}

ncf = sys.argv[1]
ncforog = sys.argv[2]

def makedaily(ncf, ncforog):
    vname0 = '_'.join(ncf.split('_')[3:-1])
    vname = vdict[vname0]
    timeres = ncf.split('_')[1]
    ncfout = ncf.replace(timeres, '24H')
    
    r = netCDF4.Dataset(ncf)
    ro = netCDF4.Dataset(ncforog)
    r2 = netCDF4.Dataset(ncfout, mode='w')
    
    v = r.variables[vname0]
    

r = netCDF4.Dataset('NORA10_1H_11km_ta_2m_1958.nc')
ro = netCDF4.Dataset('NORA10_11km_orog_new3.nc')
r2 = netCDF4.Dataset('NORA10_24H_11km_ta_2m_1958.nc', mode='w')
varname0 = 'ta_2m'
varname = 'tas'
v = r.variables[varname0]
nhours, height, yy, xx = v.shape
ndays = nhours / 24

for ncattr in r.ncattrs():
    r2.setncattr(ncattr, r.getncattr(ncattr))

r2.createDimension('rlat', yy)
r2.createDimension('rlon', xx)
r2.createDimension('time', ndays)
r2.createVariable('rotated_pole', 
                  r.variables['rotated_pole'].datatype, 
                  dimensions=r.variables['rotated_pole'].dimensions)
r2.createVariable('rlon', 
                  r.variables['rlon'].datatype, 
                  dimensions=r.variables['rlon'].dimensions)
r2.createVariable('rlat', 
                  r.variables['rlat'].datatype, 
                  dimensions=r.variables['rlat'].dimensions)
r2.createVariable('lon', 
                  r.variables['lon'].datatype, 
                  dimensions=r.variables['lon'].dimensions)
r2.createVariable('lat', 
                  r.variables['lat'].datatype, 
                  dimensions=r.variables['lat'].dimensions)
r2.createVariable('time', 
                  int,
                  # r.variables['time'].datatype, 
                  dimensions=r.variables['time'].dimensions)
r2.createVariable(varname, 
                  r.variables[varname0].datatype, 
                  dimensions=('time', 'rlat', 'rlon'))

r2.variables['time'][:] = range(ndays)
r2.variables['rotated_pole'].setncattr('grid_mapping_name', 
                                       'rotated_latitute_longitude')
r2.variables['rotated_pole'].setncattr('grid_north_pole_latitude', 22.0)
r2.variables['rotated_pole'].setncattr('grid_north_pole_longitude', 140.0)
for vname in ['lon', 'lat']:
    r2.variables[vname][:, :] = ro.variables[vname][:, :]
for vname in ['rlon', 'rlat', 'lon', 'lat', 'time']:
    r2.variables[vname].setncattr('units', r.variables[vname].units)
    r2.variables[vname].setncattr('standard_name', r.variables[vname].standard_name)
    r2.variables[vname].setncattr('long_name', r.variables[vname].long_name)
for vname in ['rlon', 'rlat']:
    r2.variables[vname].setncattr('axis', r.variables[vname].axis)
    r2.variables[vname][:] = ro.variables[vname][:]
r2.variables['time'].setncattr('units', 'days since 1958-1-1') # overwrites
r2.variables['time'].setncattr('calendar', 'standard')   
r2.variables['time'].setncattr('axis', 'T')   
r2.variables[varname].setncattr('grid_mapping', 'rotated_pole')
r2.variables[varname].setncattr('coordinates', 'lon lat')
r2.variables[varname].setncattr('cell_methods', 'time: mean')
r2.variables[varname].setncattr('standard_name', r.variables[varname0].standard_name)
r2.variables[varname].setncattr('long_name', r.variables[varname0].long_name)
r2.variables[varname].setncattr('units', r.variables[varname0].units)
if varname0 in ['rls']:
    r2.variables[varname].setncattr('units', r.variables[varname0].units + ' day-1')



for di in range(ndays):
    if varname0 in ['ta_2m', 'ts_0m', 'wss_10m', 'hur_2m']:
        r2.variables[varname][di, :, :] = r.variables[varname0][np.arange(di * 24, (di + 1) * 24), 0, :, :].mean(axis=0)
    if varname0 in ['rls', 'rss']:
        r2.variables[varname][di, :, :] = r.variables[varname0][np.arange(di * 24, (di + 1) * 24), :, :].sum(axis=0)
    if varname0 in ['clt', 'pr', 'albedo']:
        r2.variables[varname][di, :, :] = r.variables[varname0][np.arange(di * 24, (di + 1) * 24), :, :].mean(axis=0)
    if varname0 in ['ps', 'psl']:
        r2.variables[varname][di, :, :] = r.variables[varname0][np.arange(di * 8, (di + 1) * 8), :, :].mean(axis=0)

r2.close()




