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

conn = sqlite3.connect(os.path.join('data', 'processed', 
                                    'laketemp_working.sqlite'))

sql = '''SELECT l.name, p.provider_name, l.latitude, l.longitude, l.altitude, l.surface_area, l.n_total, 
l.n_depths, l.n_dates, l.n_years_summer, l.min_date, l.max_date, l.min_year_summer, l.max_year_summer, 
l.bath_NOSE as bathymetric_data 
from lakes as l, providers as p 
where l.provider_id = p.provider_id 
and l.provider_id = 6 
and l.n_depths > 20
and (select max(n_years_summer) from lakes) > 15
group by l.eb_int
order by l.n_years_summer desc;
'''

summary = pd.io.sql.read_sql(sql, conn)
summary.to_csv(os.path.join('data', 'processed', 'NVE summer lakes utf-8.csv'), encoding='utf-8')
summary.to_csv(os.path.join('data', 'processed', 'NVE summer lakes latin6.csv'), encoding='latin6')
