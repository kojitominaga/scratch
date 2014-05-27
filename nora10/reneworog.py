import netCDF4

new = netCDF4.Dataset('NORA10_11km_orog_new.nc', 'a')
r = netCDF4.Dataset('NORA10_11km_LATLON.nc')

new.variables['lat'][:, :] = r.variables['lat'][:, :]
new.variables['lon'][:, :] = r.variables['lon'][:, :]
new.variables['rlat'][:] = r.variables['rlat'][:]
new.variables['rlon'][:] = r.variables['rlon'][:]

new.close()
r.close()
