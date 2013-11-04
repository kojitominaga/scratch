import netCDF4
import numpy as np
r = netCDF4.Dataset('SMHIRCA_CTR_ERA40_DM_50km_1991-2000_tas.nc')
time = r.variables['time'][:]
time_bnds = r.variables['time_bnds'][:, :]
np.savetxt('time.txt', time)
np.savetxt('time_bnds.txt', time_bnds)
