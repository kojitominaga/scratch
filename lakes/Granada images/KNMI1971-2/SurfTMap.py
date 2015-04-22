import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap
import matplotlib as mpl
import gzip

def surft(ax, scenario, di, lakeplist, laketable):
    '''draws a map of surface temperature on ax
    scenario: scenario dir name
    di: day index
    lakeplist: path the the lakes (under this we find the scenario)
    laketable: pandas.DataFrame with names latitude and longitude
    ** order of lakes in lakeplist and laketable needs to be the same
    '''
    flist = [os.path.join(lp, scenario, 'Tzt.csv.gz') for lp in lakeplist]
    out = np.zeros(shape=(len(lakeplist), )) * np.nan
    for i, gzp in enumerate(flist):
        if i % 1000 == 0: 
            print('... running %sth lake' % i)
        with gzip.open(gzp, 'rb') as gzf:
            for _ in xrange(di):
                next(gzf)
            line = gzf.readline()
            out[i] = line.split(',')[0]
    outfloat = map(float, out)
    m = Basemap(width=1.65e6, height=1.95e6, lat_0=63, lon_0=18, projection='lcc') 
    # m.shadedrelief()
    m.drawlsmask(land_color='gray', ocean_color='lightblue', 
                 lakes=False, resolution='f', grid=1.25)
    # m.drawcoastlines()
    # m.drawcountries()
    # m.drawmapboundary(fill_color='lightgray')
    # m.drawmeridians(range(-10, 45, 2))
    # m.drawparallels(range(50, 80, 5))
    # m.fillcontinents(color='white')
    colours = []
    alpha = 0.7
    for temperature in outfloat:
        if temperature == 0.0:
            colours.append([0.9, 0.9, 0.9, alpha]), 
        else:
            colours.append(mpl.cm.coolwarm(min(1, temperature/23.0), alpha=alpha))
    m.scatter(laketable['longitude'].values, laketable['latitude'].values,
              s=np.sqrt(laketable['area'].values)/50, c=colours, 
              marker='.', # linestyle='None', 
              linewidths=0,         
              latlon=True)
    
lakes = pd.read_table('Feb2015GranadaList9k.csv', sep=',')
sc = 'EUR-11_ICHEC-EC-EARTH_historical-historical_r1i1p1_KNMI-RACMO22E_v1_day_19710101-19801231'

prefix = '../../../../lakes/'
lakeplist = []
for i, v in lakes['ebhex'].iteritems():
    ebh0 = v.lstrip('0x')
    while len(ebh0) < 6:
        ebh0 = '0' + ebh0
    s0 = ebh0[:2]
    s1 = ebh0[:4]
    lakeplist.append(os.path.join(prefix, s0, s1, ebh0))

for di in range(0, 365, 10):
    print('running %03i day of year' % di)
    plt.cla()
    fig = plt.figure(1)
    fig.set_figheight(11)
    fig.set_figwidth(9)
    ax = fig.add_subplot(111)
    surft(ax, sc, di, lakeplist, lakes)
    fig.savefig('%03d.png' % di, dpi=150)
