import netCDF4
import numpy as np

ncfname = 'test.nc'
x = np.arange(35, 65) ## EW
y = np.arange(58, 94) ## NS
depthlevels = np.array([10])
fetchlevels = np.array([1000])
attenuationlevels = np.array([2])

r = netCDF4.Dataset(ncfname, 'w', format = 'NETCDF4')
r.createDimension('rlon', len(x))
r.createDimension('rlat', len(y))
r.createDimension('depth', len(depthlevels))
r.createDimension('fetch', len(fetchlevels))
r.createDimension('attenuation', len(attenuationlevels))
r.createDimension('time', None) ## unlimited
r.createDimension('bnds', 2) 
r.createGroup('ensembles')
r.createGroup('flake')
r.createGroup('flakeout')
r.createGroup('flakelakeanalyzer')

for g in r.groups:
    r.groups[g].createDimension('rlon', len(x))
    r.groups[g].createDimension('rlat', len(y))
    r.groups[g].createDimension('depth', len(depthlevels))
    r.groups[g].createDimension('fetch', len(fetchlevels))
    r.groups[g].createDimension('attenuation', len(attenuationlevels))
    r.groups[g].createDimension('time', None) ## unlimited
    r.groups[g].createDimension('bnds', 2) 
    r.groups[g].createVariable('rlon', 'f8', ('rlon', ))
    r.groups[g].createVariable('rlat', 'f8', ('rlat', ))
    r.groups[g].createVariable('lon', 'f8', ('rlon', 'rlat'))
    r.groups[g].createVariable('lat', 'f8', ('rlon', 'rlat'))
    r.groups[g].createVariable('time', 'f4', ('time', ))
    r.groups[g].createVariable('time_bnds', 'f4', ('time', 'bnds'))
    r.groups[g].createVariable('rotated_pole', 'S1')

r.groups['flake'].createVariable('rloni', 'i4', ('rlon', ))
r.groups['flake'].createVariable('rlati', 'i4', ('rlat', ))
r.groups['flake'].createVariable('depth', 'f4', ('depth', ))
r.groups['flake'].createVariable('fetch', 'f4', ('fetch', ))
r.groups['flake'].createVariable('attenuation', 'f4', ('attenuation', ))

fulldimensions = ('time', 'rlon', 'rlat', 'depth', 'fetch', 'attenuation')

r.groups['flakeout'].createVariable('tsfc', 'f4', fulldimensions, zlib = True, least_significant_digit = 2)
r.groups['flakeout'].createVariable('tsnow', 'f4', fulldimensions, zlib = True, least_significant_digit = 2)
r.groups['flakeout'].createVariable('tice', 'f4', fulldimensions, zlib = True, least_significant_digit = 2)
r.groups['flakeout'].createVariable('tmnw', 'f4', fulldimensions, zlib = True, least_significant_digit = 2)
r.groups['flakeout'].createVariable('twml', 'f4', fulldimensions, zlib = True, least_significant_digit = 2)
r.groups['flakeout'].createVariable('tbot', 'f4', fulldimensions, zlib = True, least_significant_digit = 2)
r.groups['flakeout'].createVariable('tb1', 'f4', fulldimensions, zlib = True, least_significant_digit = 2)
r.groups['flakeout'].createVariable('ct', 'f4', fulldimensions, zlib = True, least_significant_digit = 3)
r.groups['flakeout'].createVariable('hsnow', 'f4', fulldimensions, zlib = True, least_significant_digit = 3)
r.groups['flakeout'].createVariable('hice', 'f4', fulldimensions, zlib = True, least_significant_digit = 3)
r.groups['flakeout'].createVariable('hml', 'f4', fulldimensions, zlib = True, least_significant_digit = 3)
r.groups['flakeout'].createVariable('hb1', 'f4', fulldimensions, zlib = True, least_significant_digit = 3)
r.groups['flakelakeanalyzer'].createVariable('td', 'f4',  fulldimensions, zlib = True, least_significant_digit = 3)
r.groups['flakelakeanalyzer'].createVariable('mld', 'f4',  fulldimensions, zlib = True, least_significant_digit = 3)
r.groups['flakelakeanalyzer'].createVariable('ss', 'f4',  fulldimensions, zlib = True)
r.groups['flakelakeanalyzer'].createVariable('wn', 'f4',  fulldimensions, zlib = True)
r.groups['flakelakeanalyzer'].createVariable('ln', 'f4',  fulldimensions, zlib = True)

r.groups['flake'].variables['rloni'][:] = x
r.groups['flake'].variables['rlati'][:] = y
r.groups['flake'].variables['depth'][:] = depthlevels
r.groups['flake'].variables['fetch'][:] = fetchlevels
r.groups['flake'].variables['attenuation'][:] = attenuationlevels

times = np.loadtxt('time.txt')
time_bnds = np.loadtxt('time_bnds.txt')
lonybyx = np.loadtxt('lon.txt')
latybyx = np.loadtxt('lat.txt')
lonxbyy = lonybyx.transpose()
latxbyy = latybyx.transpose()

for g in r.groups:

    r.groups[g].variables['lon'][:, :] = lonxbyy[x.min():(x.max() + 1), y.min():(y.max() + 1)]
    r.groups[g].variables['lat'][:, :] = latxbyy[x.min():(x.max() + 1), y.min():(y.max() + 1)]
    r.groups[g].variables['time'][:] = times
    r.groups[g].variables['time_bnds'][:, :] = time_bnds

    r.groups[g].variables['lon'].setncattr('standard_name', 'longitude')
    r.groups[g].variables['lat'].setncattr('standard_name', 'latitude')
    r.groups[g].variables['rlon'].setncattr('standard_name', 'grid_longitude')
    r.groups[g].variables['rlat'].setncattr('standard_name', 'grid_latitude')
    r.groups[g].variables['time'].setncattr('standard_name', 'time')
    
    r.groups[g].variables['lon'].setncattr('long_name', 'longitude')
    r.groups[g].variables['lat'].setncattr('long_name', 'latitude')
    r.groups[g].variables['rlon'].setncattr('long_name', 'longitude in rotated grid')
    r.groups[g].variables['rlat'].setncattr('long_name', 'latitude in rotated grid')
    r.groups[g].variables['time'].setncattr('long_name', 'time')
    r.groups[g].variables['time_bnds'].setncattr('long_name', 'time bounds')
    
    r.groups[g].variables['lon'].setncattr('units', 'degrees_east')
    r.groups[g].variables['lat'].setncattr('units', 'degrees_north')
    r.groups[g].variables['rlon'].setncattr('units', 'degrees')
    r.groups[g].variables['rlat'].setncattr('units', 'degrees')
    r.groups[g].variables['time'].setncattr('units', 'days since 1950-01-01 00:00:00')
    
    r.groups[g].variables['rlon'].setncattr('axis', 'X')
    r.groups[g].variables['rlat'].setncattr('axis', 'Y')
    
    r.groups[g].variables['lon'].setncattr('coordinates', 'lon lat')
    r.groups[g].variables['lat'].setncattr('coordinates', 'lon lat')
    
    r.groups[g].variables['rotated_pole'].setncattr('grid_mapping_name', 'rotated_latitude_longitude')
    r.groups[g].variables['rotated_pole'].setncattr('grid_north_pole_latitude', 39.25)
    r.groups[g].variables['rotated_pole'].setncattr('grid_north_pole_longitude', -162.0)

    r.groups[g].variables['time'].setncattr('bounds', 'time_bnds')
    r.groups[g].variables['time'].setncattr('calendar', 'standard')

attributes = {'coordinates': 'lon lat',
              'cell_methods': 'time: depth: fetch: attenuation: mean', 
              'grid_mapping': 'rotated_pole'}

r.groups['flakeout'].variables['tsfc'].setncatts(attributes)
r.groups['flakeout'].variables['tsnow'].setncatts(attributes)
r.groups['flakeout'].variables['tice'].setncatts(attributes)
r.groups['flakeout'].variables['tmnw'].setncatts(attributes)
r.groups['flakeout'].variables['tbot'].setncatts(attributes)
r.groups['flakeout'].variables['tb1'].setncatts(attributes)
r.groups['flakeout'].variables['ct'].setncatts(attributes)
r.groups['flakeout'].variables['hsnow'].setncatts(attributes)
r.groups['flakeout'].variables['hice'].setncatts(attributes)
r.groups['flakeout'].variables['hml'].setncatts(attributes)
r.groups['flakeout'].variables['hb1'].setncatts(attributes)
r.groups['flakelakeanalyzer'].variables['td'].setncatts(attributes)
r.groups['flakelakeanalyzer'].variables['mld'].setncatts(attributes)
r.groups['flakelakeanalyzer'].variables['ss'].setncatts(attributes)
r.groups['flakelakeanalyzer'].variables['wn'].setncatts(attributes)
r.groups['flakelakeanalyzer'].variables['ln'].setncatts(attributes)

r.groups['flakeout'].variables['tsfc'].setncattr('long_name', 'surface temperature')
r.groups['flakeout'].variables['tsnow'].setncattr('long_name', 'snow surface temperature')
r.groups['flakeout'].variables['tice'].setncattr('long_name', 'ice surface temperature')
r.groups['flakeout'].variables['tmnw'].setncattr('long_name', 'mean water temperature')
r.groups['flakeout'].variables['tbot'].setncattr('long_name', 'lake bottom temperature')
r.groups['flakeout'].variables['tb1'].setncattr('long_name', 'temperature bottom of upper sediment')
r.groups['flakeout'].variables['ct'].setncattr('long_name', 'shape factor')
r.groups['flakeout'].variables['hsnow'].setncattr('long_name', 'snow thickness')
r.groups['flakeout'].variables['hice'].setncattr('long_name', 'ice thickness')
r.groups['flakeout'].variables['hml'].setncattr('long_name', 'mixing layer depth')
r.groups['flakeout'].variables['hb1'].setncattr('long_name', 'thickness of upper sediment')
r.groups['flakelakeanalyzer'].variables['td'].setncattr('long_name', 'thermocline depth')
r.groups['flakelakeanalyzer'].variables['mld'].setncattr('long_name', 'mixing layer depth')
r.groups['flakelakeanalyzer'].variables['ss'].setncattr('long_name', "Schmidts's stability")
r.groups['flakelakeanalyzer'].variables['wn'].setncattr('long_name', 'Wedderburn number')
r.groups['flakelakeanalyzer'].variables['ln'].setncattr('long_name', 'lake number')

r.groups['flakeout'].variables['tsfc'].setncattr('units', 'K')
r.groups['flakeout'].variables['tsnow'].setncattr('units', 'K')
r.groups['flakeout'].variables['tice'].setncattr('units', 'K')
r.groups['flakeout'].variables['tmnw'].setncattr('units', 'K')
r.groups['flakeout'].variables['tbot'].setncattr('units', 'K')
r.groups['flakeout'].variables['tb1'].setncattr('units', 'K')
r.groups['flakeout'].variables['ct'].setncattr('units', '(unit)')
r.groups['flakeout'].variables['hsnow'].setncattr('units', 'm')
r.groups['flakeout'].variables['hice'].setncattr('units', 'm')
r.groups['flakeout'].variables['hml'].setncattr('units', 'm')
r.groups['flakeout'].variables['hb1'].setncattr('units', 'm')
r.groups['flakelakeanalyzer'].variables['td'].setncattr('units', 'm')
r.groups['flakelakeanalyzer'].variables['mld'].setncattr('units', 'm')
r.groups['flakelakeanalyzer'].variables['ss'].setncattr('units', '(unit)')
r.groups['flakelakeanalyzer'].variables['wn'].setncattr('units', '(unit)')
r.groups['flakelakeanalyzer'].variables['ln'].setncattr('units', '(unit)')

r.groups['flakeout'].variables['tsfc'].setncattr('standard_name', 'tsfc')
r.groups['flakeout'].variables['tsnow'].setncattr('standard_name', 'tsnow')
r.groups['flakeout'].variables['tice'].setncattr('standard_name', 'tice')
r.groups['flakeout'].variables['tmnw'].setncattr('standard_name', 'tmnw')
r.groups['flakeout'].variables['tbot'].setncattr('standard_name', 'tbot')
r.groups['flakeout'].variables['tb1'].setncattr('standard_name', 'tb1')
r.groups['flakeout'].variables['ct'].setncattr('standard_name', 'ct')
r.groups['flakeout'].variables['hsnow'].setncattr('standard_name', 'hsnow')
r.groups['flakeout'].variables['hice'].setncattr('standard_name', 'hice')
r.groups['flakeout'].variables['hml'].setncattr('standard_name', 'hml')
r.groups['flakeout'].variables['hb1'].setncattr('standard_name', 'hb1')
r.groups['flakelakeanalyzer'].variables['td'].setncattr('standard_name', 'td')
r.groups['flakelakeanalyzer'].variables['mld'].setncattr('standard_name', 'mld')
r.groups['flakelakeanalyzer'].variables['ss'].setncattr('standard_name', 'ss')
r.groups['flakelakeanalyzer'].variables['wn'].setncattr('standard_name', 'wn')
r.groups['flakelakeanalyzer'].variables['ln'].setncattr('standard_name', 'ln')
    
converters0 = {0: lambda s: s.strip('"'), 
               1: lambda s: '0'}  
## 1: is the date column. Guess we don't need it

converters1 = {0: lambda s: s.strip('"'), 
               4: lambda s: float(s.replace('NA', '1e18')), 
               5: lambda s: float(s.replace('NA', '1e18'))}

for xi in range(len(x)):
    for yi in range(len(y)):

        ## could have loops for depth, fetch, and attenuation
        depthi = depthlevels[0]
        fetchi = fetchlevels[0]
        attenuationi = attenuationlevels[0]

        dname = '%03d-%03d' % (x[xi], y[yi])
        print(dname)

        flakeout = \
          np.loadtxt(''.join([dname, '/csv/dm_simple.csv.bz2']), 
                     skiprows = 1, delimiter = ',', converters = converters0,
                     usecols = (22, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21))
        lakeanalyzer = \
          np.loadtxt(''.join([dname, '/csv/dm_simple_lais.csv.bz2']), 
                     skiprows = 1, delimiter = ',', converters = converters1,
                     usecols = (1, 2, 3, 4, 5))
        r.groups['flakeout'].variables['tsfc'][:, xi, yi, depthi, fetchi, attenuationi] = flakeout[:, 0]
        r.groups['flakeout'].variables['tsnow'][:, xi, yi, depthi, fetchi, attenuationi] = flakeout[:, 1]
        r.groups['flakeout'].variables['tice'][:, xi, yi, depthi, fetchi, attenuationi] = flakeout[:, 2]
        r.groups['flakeout'].variables['tmnw'][:, xi, yi, depthi, fetchi, attenuationi] = flakeout[:, 3]
        r.groups['flakeout'].variables['twml'][:, xi, yi, depthi, fetchi, attenuationi] = flakeout[:, 4]
        r.groups['flakeout'].variables['tbot'][:, xi, yi, depthi, fetchi, attenuationi] = flakeout[:, 5]
        r.groups['flakeout'].variables['tb1'][:, xi, yi, depthi, fetchi, attenuationi] = flakeout[:, 6]
        r.groups['flakeout'].variables['ct'][:, xi, yi, depthi, fetchi, attenuationi] = flakeout[:, 7]
        r.groups['flakeout'].variables['hsnow'][:, xi, yi, depthi, fetchi, attenuationi] = flakeout[:, 8]
        r.groups['flakeout'].variables['hice'][:, xi, yi, depthi, fetchi, attenuationi] = flakeout[:, 9]
        r.groups['flakeout'].variables['hml'][:, xi, yi, depthi, fetchi, attenuationi] = flakeout[:, 10]
        r.groups['flakeout'].variables['hb1'][:, xi, yi, depthi, fetchi, attenuationi] = flakeout[:, 11]
        r.groups['flakelakeanalyzer'].variables['td'] [:, xi, yi, depthi, fetchi, attenuationi] = lakeanalyzer[:, 0]
        r.groups['flakelakeanalyzer'].variables['mld'][:, xi, yi, depthi, fetchi, attenuationi] = lakeanalyzer[:, 1]
        r.groups['flakelakeanalyzer'].variables['ss'][:, xi, yi, depthi, fetchi, attenuationi] = lakeanalyzer[:, 2]
        r.groups['flakelakeanalyzer'].variables['wn'][:, xi, yi, depthi, fetchi, attenuationi] = lakeanalyzer[:, 3]
        r.groups['flakelakeanalyzer'].variables['ln'][:, xi, yi, depthi, fetchi, attenuationi] = lakeanalyzer[:, 4]

r.close()

                             
        
        




        











