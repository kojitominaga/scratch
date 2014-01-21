import netCDF4
import numpy as np

orogncfn = 'NORA10_11km_orog.nc'

latfn = 'NORA10_11km_lat.txt'
lonfn = 'NORA10_11km_lon.txt'
orogfn = 'NORA10_11km_orog.txt'

r = netCDF4.Dataset(orogncfn)

myfmt = '%.8f' ## 8 significant digits, e.g., 53.80798340
np.savetxt(latfn, r.variables['lat'][:, :], fmt = myfmt)
np.savetxt(lonfn, r.variables['lon'][:, :], fmt = myfmt)
np.savetxt(orogfn, r.variables['orog'][0, :, :], fmt = '%.1f') # down to 10 cm

r.close()

## x: lon 248 
## y: lat 400


