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

sql = '''select l.name, p.provider_name, l.eb_int, l.station_id, 
l.n_total, l.n_depths, l.n_dates, l.min_date, l.max_date, 
l.bath_NOSE as bathymetric_data 
from lakes as l, providers as p 
where l.provider_id = p.provider_id order by eb_int;'''

summary = pd.io.sql.read_sql(sql, conn)
