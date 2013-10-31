import netCDF4
import numpy as np

ncfname = 'test.nc'
x = np.arange(58, 61)
y = np.arange(35, 39)
depthlevels = np.array([10])
fetchlevels = np.array([1000])
attenuationlevels = np.array([2])

r = netCDF4.Dataset(ncfname, 'w', format = 'NETCDF4')
r.createDimension('rlat', len(x))
r.createDimension('rlon', len(y))
r.createDimension('depth', len(depthlevels))
r.createDimension('fetch', len(fetchlevels))
r.createDimension('attenuation', len(attenuationlevels))
r.createDimension('time', None) ## unlimited
r.createDimension('bnds', 2) 
r.createGroup('ensembles')
r.createGroup('flake')
r.createGroup('flakeout')
r.createGroup('flakelakeanalyzer')
r.groups['ensembles'].createVariable('rlat', 'f8', ('rlat', ))
r.groups['ensembles'].createVariable('rlon', 'f8', ('rlon', ))
r.groups['ensembles'].createVariable('lat', 'f8', ('rlat', ))
r.groups['ensembles'].createVariable('lon', 'f8', ('rlon', ))
r.groups['ensembles'].createVariable('time', 'f8', ('time', ))
r.groups['ensembles'].createVariable('time_bnds', 'f8', ('time', 'bnds'))
r.groups['flake'].createVariable('rlati', 'i8', ('rlat', ))
r.groups['flake'].createVariable('rloni', 'i8', ('rlon', ))
r.groups['flake'].createVariable('depth', 'f8', ('depth', ))
r.groups['flake'].createVariable('fetch', 'f8', ('fetch', ))
r.groups['flake'].createVariable('attenuation', 'f8', ('attenuation', ))
r.groups['flakeout'].createVariable(
    'twml', 'f8', ('time', 'rlat', 'rlon', 'depth', 'fetch', 'attenuation'))
r.groups['flakeout'].createVariable(
    'tsfc', 'f8', ('time', 'rlat', 'rlon', 'depth', 'fetch', 'attenuation'))
r.groups['flakelakeanalyzer'].createVariable(
    'ln', 'f8',  ('time', 'rlat', 'rlon', 'depth', 'fetch', 'attenuation'))

r.groups['flake'].variables['rlati'][:] = x
r.groups['flake'].variables['rloni'][:] = y
r.groups['flake'].variables['depth'][:] = depthlevels
r.groups['flake'].variables['fetch'][:] = fetchlevels
r.groups['flake'].variables['attenuation'][:] = attenuationlevels
r.close()









