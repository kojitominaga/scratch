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

# from bokeh.mpl import to_bokeh

#####################################
# d0 = pd.read_csv('test20151110a.csv.gz')
# d = d0.loc[:, ['sim_id', 'tws02', 'tws08']]
# d['ebint'] = (d.sim_id % 2e7).astype(int)
# d['mm'] = np.floor(d.sim_id / 2e7).astype(int)
# g = d[['ebint', 'mm', 'tws02', 'tws08']].groupby(['ebint', 'mm'])
# m = g.median()
# m.to_csv('median_tws02_tws08.csv', index=False)

m = pd.read_csv('median_tws02_tws08.csv', index_col=['ebint', 'mm'])

####################################
# sqlgeog = '''select
# 	a.ebint, 
# 	a.clust30, 
# 	a.clust30a, 
# 	st_x(c.geom) as longitude, 
# 	st_y(c.geom) as latitude, 
# 	b.maxdepth, 
# 	b.area
# from 
#      bathymetry_predicted             b, 
#      ecco_biwa_lakes_v_0_1_centroids  c, 
#      ecco_biwa_lakes_v_0_1            a
# where
# 	b.ebint = a.ebint and
# 	b.ebint = c.ebint and
# 	a.ccluster30 > 0'''

# engine = create_engine('postgresql+pg8000://user:password@vm-srv-finstad.vm.ntnu.no/ecco_biwa_db')

# geog = pd.read_sql(sqlgeog, engine)
# geog.to_csv('9k_geography.csv', index=False)

geog = pd.read_csv('9k_geography.csv')
geog = geog.set_index('ebint')


### get unique mm
mms = list(set([mm for ebint, mm in m.index.values]))
mms.sort()


fig = plt.figure()
for i, mm in enumerate(mms):

    period = ['2001-2010', '2031-2040', '2061-2070', '2091-2100'][i]

    # select a decade, and join geography
    sub = m.xs(mm, level='mm').join(geog)
    # In [138]: sub.columns
    # Out[138]: 
    # Index([    u'tws02',     u'tws08',   u'clust30',  u'clust30a',  u'latitude',
    #            u'longitude',  u'maxdepth',      u'area'],
    # dtype='object')
    
    ax02 = fig.add_subplot(2, 4, i+1)
    ax08 = fig.add_subplot(2, 4, i+5)

    ## UTM33n
    map02 = Basemap(lon_0=17.5, lat_0=63.2, width=1.45e6, height=1.85e6, 
                    # llcrnrlon=5.0, llcrnrlat=40.0, urcrnrlon=50.0, urcrnrlat=70.0,
                    resolution='i', projection='tmerc',
                    k_0=0.9996, rsphere=(6378137.00, 6356752.314245179), 
                    ax=ax02)
    map08 = Basemap(lon_0=17.5, lat_0=63.2, width=1.45e6, height=1.85e6, 
                    # llcrnrlon=5.0, llcrnrlat=40.0, urcrnrlon=50.0, urcrnrlat=70.0,
                    resolution='i', projection='tmerc',
                    k_0=0.9996, rsphere=(6378137.00, 6356752.314245179), 
                    ax=ax08)

    # map.drawcountries()
    # map02.drawcoastlines(color='lightgray')
    # map08.drawcoastlines(color='lightgray')
    map02.drawlsmask(land_color='gray', ocean_color='lightblue', 
                     lakes=False, resolution='f', grid=1.25)
    map08.drawlsmask(land_color='gray', ocean_color='lightblue', 
                     lakes=False, resolution='f', grid=1.25)
    
    alpha = 0.7
    colours02 = [[0.9, 0.9, 0.9, alpha] if t == 0.0 else 
                 mpl.cm.coolwarm(min(1, t/23.0), alpha=alpha) 
                 for t in sub.tws02.values]
    colours08 = [[0.9, 0.9, 0.9, alpha] if t == 0.0 else 
                 mpl.cm.coolwarm(min(1, t/23.0), alpha=alpha) 
                 for t in sub.tws08.values]

    map02.scatter(sub.longitude.values, sub.latitude.values, 
                  s=np.sqrt(sub.area.values)/50.0+10, 
                  c=colours02, 
                  marker='.',
                  linewidths=0, 
                  latlon=True)
    map08.scatter(sub.longitude.values, sub.latitude.values, 
                  s=np.sqrt(sub.area.values)/50.0+10, 
                  c=colours08, 
                  marker='.',
                  linewidths=0, 
                  latlon=True)
    
    ax02.set_title('February %s' % period)
    ax08.set_title('August %s' % period)

fig.set_figheight(6)
fig.set_figwidth(11)

fig.savefig('water surface temperature.png' % mm, dpi=1200)

