import os
import netCDF4

firstncfn = [fn for fn in os.listdir('.') if fn.split('.')[-1] == 'nc'][0]
r = netCDF4.Dataset(firstncfn)
lat = r.variables['lat'][:, :]
lon = r.variables['lon'][:, :]

np.savetxt('lat.txt', lat, fmt = '%.18f')
np.savetxt('lon.txt', lon, fmt = '%.18f')
