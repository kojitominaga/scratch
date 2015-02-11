#!/usr/bin/python
# -*- coding: utf-8 -*-
import sqlite3
import os
import numpy as np
import pandas as pd
import datetime
import pytz
import math
import osgeo.ogr

conn = sqlite3.connect(os.path.join('data', 'processed', 'laketemp_working.sqlite'))

## summary stats
c = conn.execute('''select provider_id, eb_int, station_id, count(), min(date), max(date) 
from temperature group by provider_id, eb_int, station_id''')
for pr_id, eb_int, station_id, count, min_date, max_date in c.fetchall():
    conn.execute('''update lakes set n_total = ?, min_date = ?, max_date = ?
                    where provider_id = ? and eb_int = ? and station_id = ?''',
                 (count, min_date, max_date, pr_id, eb_int, station_id))
c = conn.execute('select provider_id, eb_int, station_id from lakes group by provider_id, eb_int, station_id')
cfetchall = c.fetchall()
for pr_id, eb_int, station_id in cfetchall:
    c = conn.execute('''select depth from temperature where provider_id = ? and eb_int = ? and station_id = ?
                        group by depth''', (pr_id, eb_int, station_id))
    n_depths = len(c.fetchall())
    c = conn.execute('''select date from temperature 
                        where provider_id = ? and eb_int = ? and station_id  = ? group by date''', 
                     (pr_id, eb_int, station_id))
    the_dates_tup = [map(int, e[0].split('-')) for e in c.fetchall()]
    the_dates = [datetime.date(year, month, day) for year, month, day in the_dates_tup]
    n_dates = len(the_dates)
    summer_dates = [d for d in the_dates if d.month < 10 and d.month > 5]
    years_with_summer_dates = [d.year for d in summer_dates]
    n_years_summer = len(set(years_with_summer_dates))
    if n_years_summer == 0:
        min_year_summer = 0
        max_year_summer = 0
    else:
        min_year_summer = min(years_with_summer_dates)
        max_year_summer = max(years_with_summer_dates)
    conn.execute('''update lakes set n_depths = ?, n_dates = ?, n_years_summer = ?, 
                    min_year_summer = ?, max_year_summer = ?
                    where provider_id = ? and eb_int = ? and station_id = ?''',
                 (n_depths, n_dates, n_years_summer, 
                  min_year_summer, max_year_summer, 
                  pr_id, eb_int, station_id))

def getFurthest(gr):
    '''gr is GeometricReference
    returns (lon, lat)'''
    buf = np.sqrt(gr.Area())
    bufpolygon = gr.Buffer(-buf)
    bufarea = bufpolygon.Area()
    safety = 0
    while bufarea == 0 and safety < 100:
        buf = buf / 1.1
        bufpolygon = gr.Buffer(-buf)
        bufarea = bufpolygon.Area()
        safety += 1
    return bufpolygon.Centroid().GetPoints()[0]

p3 = os.path.join('..', '..', '..', '..', 'GIS_DATA', 'fenoscand_lakes', 'v.0.2')
p4 = 'ecco-biwa_lakes_v.0.2'
datasource = osgeo.ogr.Open(p3)
layer = datasource.GetLayerByName(p4)
bathkeys = set()
feat = layer.GetNextFeature()
fieldnames = feat.keys()
print('it will take a few minutes...')
features = []
while feat is not None:
    if feat.items()['EBint'] in [e[1] for e in cfetchall]:
        gr = feat.GetGeometryRef()
        lon, lat = getFurthest(gr)
        bathkeys.add((feat.items()['EBint'], 
                      feat.items()['vatn_lnr'],
                      feat.items()['cBathNO'], 
                      feat.items()['cBathSE'], 
                      feat.items()['cBathNOSE'], 
                      feat.items()['stf_mean'], 
                      feat.items()['area'], 
                      lon, lat))
        print('... found %s' % feat.items()['EBint'])
        print(getFurthest(feat.GetGeometryRef()))
        features.append(feat)
    feat = layer.GetNextFeature()
for ebi, vatnlnr, bno, bse, bnose, altitude, area, lon, lat in bathkeys:
    conn.execute('''update lakes set bath_NO = ?, bath_SE = ?, bath_NOSE = ?, 
                    longitude = ?, latitude = ?, surface_area = ?, altitude = ?, 
                    vatnlnr = ?
                    where eb_int = ?''',
                 (bno, bse, bnose, lon, lat, area, altitude, vatnlnr, ebi))

conn.commit()
conn.close()



conn = sqlite3.connect(os.path.join('data', 'processed', 'laketemp_working.sqlite'))
p5 = 'NVE lakes with 15 summer years.geojson'

dr = osgeo.ogr.GetDriverByName('KML')
ds = dr.CreateDataSource('NVE_lakes.kml')
la = ds.CreateLayer('NVE_Lakes', srs=layer.GetSpatialRef(), 
                    geom_type=osgeo.ogr.wkbMultiPolygon)
# dr = osgeo.ogr.GetDriverByName('GeoJSON')
# ds = dr.CreateDataSource('NVE_lakes.geojson')
# la = ds.CreateLayer('OGRGeoJSON', srs=layer.GetSpatialRef(), 
#                     geom_type=osgeo.ogr.wkbMultiPolygon)
# dr = osgeo.ogr.GetDriverByName('ESRI Shapefile')
# ds = dr.CreateDataSource('.')
# la = ds.CreateLayer('NVE_lakes', srs=layer.GetSpatialRef(), 
#                     geom_type=osgeo.ogr.wkbMultiPolygon)
la.CreateField(osgeo.ogr.FieldDefn('name', osgeo.ogr.OFTString))
la.CreateField(osgeo.ogr.FieldDefn('longitude', osgeo.ogr.OFTReal))
la.CreateField(osgeo.ogr.FieldDefn('latitude', osgeo.ogr.OFTReal))
la.CreateField(osgeo.ogr.FieldDefn('altitude', osgeo.ogr.OFTReal))
la.CreateField(osgeo.ogr.FieldDefn('area', osgeo.ogr.OFTReal))
la.CreateField(osgeo.ogr.FieldDefn('n_yr_summr', osgeo.ogr.OFTInteger))
la.CreateField(osgeo.ogr.FieldDefn('year0', osgeo.ogr.OFTInteger))
la.CreateField(osgeo.ogr.FieldDefn('year1', osgeo.ogr.OFTInteger))
la.CreateField(osgeo.ogr.FieldDefn('ebint', osgeo.ogr.OFTInteger))
la.CreateField(osgeo.ogr.FieldDefn('vatnlnr', osgeo.ogr.OFTInteger))
la.CreateField(osgeo.ogr.FieldDefn('bathmap', osgeo.ogr.OFTInteger))

for oldfeat in features:
    ebi = oldfeat['ebint']
    ebi, vatnlnr, bn, bs, bns, alt, area, lon, lat = \
        [tup for tup in bathkeys if tup[0] == ebi][0]
    newfeat = osgeo.ogr.Feature(la.GetLayerDefn())
    newfeat.SetGeometry(oldfeat.GetGeometryRef())
    c = conn.execute('''select name, provider_id, n_depths, 
                        min_year_summer, max_year_summer, n_years_summer
                        from lakes where eb_int = ? 
                        order by n_depths desc''', 
                     (ebi, ))
    name, pr_id, nd, min_year, max_year, n_years_summer = c.fetchone()
    if not pr_id == 6:
        continue
    if nd < 15: 
        continue
    newfeat['name'] = name.replace(u'Ø', 'Oe').replace(u'ø', 'oe').replace(u'Å', 'Aa').replace(u'å', 'aa').replace(u'Æ', 'Ae').replace(u'æ', 'ae')
    newfeat['longitude'] = lon
    newfeat['latitude'] = lat
    newfeat['altitude'] = alt
    newfeat['area'] = area
    newfeat['n_yr_summr'] = n_years_summer
    newfeat['year0'] = min_year
    newfeat['year1'] = max_year
    newfeat['ebint'] = ebi
    newfeat['vatnlnr'] = vatnlnr
    newfeat['bathmap'] = bns
    la.CreateFeature(newfeat)

ds.Destroy()



