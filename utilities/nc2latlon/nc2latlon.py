"""usage: python nc2latlon.py yournetcdffile.nc"""
## x lon EW
## y lat NS

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

np.savetxt(ncf + '.lon.txt', lon.transpose(), fmt = '%.6f') # x * y
np.savetxt(ncf + '.lat.txt', lat.transpose(), fmt = '%.6f') # x * y

# x (lon) moves fastest
xii = range(nx) * ny 
# x0, x1, x2, x3, x4, ...
yii = [yi for yi in range(ny) for _ in range(nx)]
# y0, y0, y0, y0, y0, ...
lon1d = lon.reshape((nx * ny, )) # x0y0, x1y0, x2y0, x3y0, ... 
lat1d = lat.reshape((nx * ny, )) # x0y0, x1y0, x2y0, x3y0, ... 
f1out = '\n'.join(['%s-%s %.6f %.6f' % (xii[i], yii[i], lon1d[i], lat1d[i])
                   for i in range(len(xii))])
f2out = '\n'.join(['%s-%s %.6f %.6f' % (xii[i], yii[i], lat1d[i], lon1d[i])
                   for i in range(len(xii))])
f1 = open(ncf + '.lonlat.txt', 'w')
f1.write(f1out)
f1.close()
f2 = open(ncf + '.latlon.txt', 'w')
f2.write(f2out)
f2.close()

    

