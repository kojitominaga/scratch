import sys
sys.path.insert(0, '..')
import os
import nora10util
import mylakeinput
import mylakeinitpar
import numpy as np

names = [d for d in os.listdir(os.path.join('..', 'interpolated'))
         if d[:6] == 'COMSAT']

for location in names:
    outdir = os.path.join('..', 'collated', location)
    if not os.path.exists(outdir): os.makedirs(outdir)
    nora10util.byinterpmethodVariables(
        location, 'mean24', 'DM', range(2007, 2013),
        interpmethod='last', varnames='all', outdir=outdir, prefix='..')
    
for location in names:
    origindir = os.path.join('..', 'collated', location)
    outdir = os.path.join('..', 'mylake_inputs')
    print(origindir)
    mylakeinput.mylakeinput(origindir, outdir)

data1 = np.genfromtxt('../comsat/NSD/COMSAT 2011 field.data.txt', 
                      skip_header = 1,
                      dtype = 'S50,i4,S50,S50,S50,S50,f8,f8,f8,f8,f8',
                      names = ("rowname", "ID", "Lake.name", "Date", 
                               "Start.time", "End.time",
                               "Station.depth", "Zooplankton.Depth", 
                               "Secchi.depth" "Latitude" "Longitude"),
                      usecols = (1, 6, 8, 9, 10))
data2 = np.genfromtxt('../comsat/NSD/COMSAT 2011 lakes.txt', 
                      names = True, usecols = (0, 7), 
                      dtype = 'i4,S50,S50,S50,f8,f8,f8,f8,S50,S50,S50,S50,S50', 
                      delimiter = '\t')
good_ids = set(data1['ID']) & set(data2['ID'])

for lake_id in good_ids:
    depth, secchi_depth, latitude, longitude = \
      data1[data1['ID'] == lake_id][0].tolist()[1:]
    area = data2[data2['ID'] == lake_id][0].tolist()[1]
    lakedir = os.path.join('..', 'mylake_inputs', 'COMSAT' + str(lake_id))
    initdir = os.path.join(lakedir, 'init')
    if not os.path.exists(initdir): os.makedirs(initdir)
    pardir = os.path.join(lakedir, 'par')
    if not os.path.exists(pardir): os.makedirs(pardir)
    with open(os.path.join(initdir, '1.5fielddepth_cone.mlinit'), 'w') as f:
        f.write(mylakeinitpar.mylakeinit(depth * 1.5, area * 1e6))
    with open(os.path.join(pardir, '18secchi_Minnesota.mlpar'), 'w') as f:
        f.write(mylakeinitpar.mylakepar(1.8 / secchi_depth, longitude, latitude))
    with open(os.path.join(pardir, 'LA018_Minnesota.mlpar'), 'w') as f:
        f.write(mylakeinitpar.mylakepar(0.18, longitude, latitude))
    with open(os.path.join(pardir, 'LA090_Minnesota.mlpar'), 'w') as f:
        f.write(mylakeinitpar.mylakepar(0.90, longitude, latitude))
    with open(os.path.join(pardir, 'LA450_Minnesota.mlpar'), 'w') as f:
        f.write(mylakeinitpar.mylakepar(4.50, longitude, latitude))
    
