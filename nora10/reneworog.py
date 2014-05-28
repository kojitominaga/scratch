import netCDF4

new = netCDF4.Dataset('NORA10_11km_orog_new3.nc', 'a')
r = netCDF4.Dataset('NORA10_11km_LATLON.nc')

rlat = r.variables['rlat'][:]
new.variables['rlat'][:] = rlat
# rlon = r.variables['rlon'][:]
# new.variables['rlon'][:] = rlon
lat = r.variables['lat'][:, :]
new.variables['lat'][:, :] = lat
lon = r.variables['lon'][:, :]
new.variables['lon'][:, :] = lon

new.close()
r.close()
