"""usage: python nc2latlon.py yournetcdffile.nc"""

import netCDF4
import sys
import numpy as np

ncf = sys.argv[1]

r = netCDF4.Dataset(ncf)
print(r)

lon = r.variables['lon'][:, :] # y * x
lat = r.variables['lat'][:, :] # y * x
nx = r.variables['rlon'].size  # x
ny = r.variables['rlat'].size  # y

np.savetxt(ncf + '.lon.txt', lon) 
np.savetxt(ncf + '.lat.txt', lat)

# x (lon) moves fastest
xii = range(nx) * ny
yii = [yi for yi in range(ny) for _ in range(nx)]
lon1d = lon.transpose().reshape((nx * ny,)
lat1d = lat.reshape((nx * ny, ))

