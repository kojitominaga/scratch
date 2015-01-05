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
    n_dates = len(c.fetchall())
    conn.execute('''update lakes set n_depths = ?, n_dates = ?
                    where provider_id = ? and eb_int = ? and station_id = ?''',
                 (n_depths, n_dates, pr_id, eb_int, station_id))
p3 = os.path.join('..', '..', '..', '..', 'GIS_DATA', 'fenoscand_lakes')
p4 = 'ecco-biwa_lakes_v.0.1'
datasource = osgeo.ogr.Open(p3)
layer = datasource.GetLayerByName(p4)
bathkeys = set()
feat = layer.GetNextFeature()
fieldnames = feat.keys()
print('it will take a few minutes...')
while feat is not None:
    if feat.items()['EBint'] in [e[1] for e in cfetchall]:
        bathkeys.add((feat.items()['EBint'], 
                      feat.items()['cBathNO'], 
                      feat.items()['cBathSE'], 
                      feat.items()['cBathNOSE']))
        print('... found %s' % feat.items()['EBint'])
    feat = layer.GetNextFeature()
for ebi, bno, bse, bnose in bathkeys:
    conn.execute('''update lakes set bath_NO = ?, bath_SE = ?, bath_NOSE = ?
                    where eb_int = ?''',
                 (bno, bse, bnose, ebi))

conn.commit()
conn.close()
