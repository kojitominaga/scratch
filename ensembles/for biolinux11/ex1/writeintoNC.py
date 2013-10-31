import netCDF4
import numpy as np

ncfname = 'test.nc'
depthi = [0]
fetchi = [0]
attenuationi = [0]

r = netCDF4.Dataset(ncfname, 'a', format = 'NETCDF4')

r.groups['flake'].variables['rlati'].set_auto_maskandscale(False)
r.groups['flake'].variables['rloni'].set_auto_maskandscale(False)

x = r.groups['flake'].variables['rlati'][:]
y = r.groups['flake'].variables['rloni'][:]

converters0 = {0: lambda s: s.strip('"'), 
               1: lambda s: '0'}

converters1 = {0: lambda s: s.strip('"'), 
               4: lambda s: float(s.replace('NA', '1e18')), 
               5: lambda s: float(s.replace('NA', '1e18'))}

for xi in range(len(x)):
    for yi in range(len(y)):
        dname = '%03d-%03d' % (x[xi], y[yi])
        print(dname)
        r.groups['flakeout'].variables['twml']\
          [:, xi, yi, depthi, fetchi, attenuationi] = \
          a = np.loadtxt(''.join([dname, '/csv/dm_simple.csv.bz2']), 
                         skiprows = 1, delimiter = ',', converters = converters1,
                         usecols = (14, ))
        r.groups['flakeout'].variables['tsfc']\
          [:, xi, yi, depthi, fetchi, attenuationi] = \
          a = np.loadtxt(''.join([dname, '/csv/dm_simple.csv.bz2']), 
                         skiprows = 1, delimiter = ',', converters = converters1,
                         usecols = (22, ))
        r.groups['flakelakeanalyzer'].variables['ln']\
          [:, xi, yi, depthi, fetchi, attenuationi] = \
          a = np.loadtxt(''.join([dname, '/csv/dm_simple_lais.csv.bz2']), 
                         skiprows = 1, delimiter = ',', converters = converters1,
                         usecols = (5, ))

r.close()

                             
        
        


