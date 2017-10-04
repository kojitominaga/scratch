import os
import numpy as np
import pandas as pd
# import pg8000
# from sqlalchemy import create_engine
import datetime
# import scipy.optimize
# import scipy.interpolate

from mpl_toolkits.basemap import Basemap
import matplotlib.pyplot as plt
import matplotlib as mpl

geog = pd.read_csv('9k_geography.csv')
geog = geog.set_index('ebint')

fig = plt.figure()

ax1 = fig.add_subplot(1, 3, 1)
ax2 = fig.add_subplot(1, 3, 2)
ax3 = fig.add_subplot(1, 3, 3)

map1 = Basemap(lon_0=17.5, lat_0=63.2, width=1.45e6, height=1.85e6, 
               # llcrnrlon=5.0, llcrnrlat=40.0, urcrnrlon=50.0, urcrnrlat=70.0,
               resolution='i', projection='tmerc',
               k_0=0.9996, rsphere=(6378137.00, 6356752.314245179), 
               ax=ax1)
map2 = Basemap(lon_0=17.5, lat_0=63.2, width=1.45e6, height=1.85e6, 
               # llcrnrlon=5.0, llcrnrlat=40.0, urcrnrlon=50.0, urcrnrlat=70.0,
               resolution='i', projection='tmerc',
               k_0=0.9996, rsphere=(6378137.00, 6356752.314245179), 
               ax=ax2)
map3 = Basemap(lon_0=17.5, lat_0=63.2, width=1.45e6, height=1.85e6, 
               # llcrnrlon=5.0, llcrnrlat=40.0, urcrnrlon=50.0, urcrnrlat=70.0,
               resolution='i', projection='tmerc',
               k_0=0.9996, rsphere=(6378137.00, 6356752.314245179), 
               ax=ax3)

map1.drawlsmask(land_color='gray', ocean_color='lightblue', 
                lakes=False, resolution='f', grid=1.25)
map2.drawlsmask(land_color='gray', ocean_color='lightblue', 
                lakes=False, resolution='f', grid=1.25)
map3.drawlsmask(land_color='gray', ocean_color='lightblue', 
                lakes=False, resolution='f', grid=1.25)

map1.scatter(geog.longitude.values, geog.latitude.values, 
             s=np.sqrt(geog.area.values)/200.0+0.5, 
             marker='o',
             edgecolors=[0.1, 0.1, 0.1, 0.8], 
             facecolors=mpl.cm.Blues(0.01, alpha=0.8),
             linewidths=0.2, 
             latlon=True)
ax1.set_title('lake area\ncan we tell lakes\nsmall in NO and\nlarge in FI?')

colours2 = [mpl.cm.YlGnBu(min(1, depth/50.0), alpha=0.7) 
            for depth in geog.maxdepth.values]
map2.scatter(geog.longitude.values, geog.latitude.values, 
             s=15.0, 
             c=colours2, 
             marker='.',
             linewidths=0, 
             latlon=True)
ax2.set_title('lake maximum depth\n[shallow]yellow-green-blue[deep]\nI think we can see Norway\ndeep lakes')

colours3 = [mpl.cm.Accent(min(0.95, max(0.05, cl/30*0.8)), alpha=0.7)
          for cl in geog.clust30a.values]
map3.scatter(geog.longitude.values, geog.latitude.values, 
             s=15.0, 
             c=colours3, 
             marker='.',
             linewidths=0, 
             latlon=True)
ax3.set_title('k-means clusters\nbasis for selecting 9000 lakes\n(not sure if we present this)')

fig.set_figheight(6)
fig.set_figwidth(11)

fig.savefig('lake morphology.png', dpi=600)
fig.savefig('lake morphology low DPI.png', dpi=150)

