#!/usr/bin/python
# -*- coding: utf-8 -*-
import sqlite3
import os
import numpy as np
import pandas as pd
import datetime
import pytz
import math

conn = sqlite3.connect(os.path.join('data', 'processed', 'laketemp.sqlite'))
c = conn.cursor

conn.execute('''create table lakes (
name text, 
provider text, 
eb_int integer primary key, 
n_total integer, 
n_depths integer, 
n_dates integer, 
min_date integer, 
max_date integer)''')

conn.execute('''create table temperature (
eb_int integer, 
date integer, 
depth real, 
temperature real)''')

## Atnsjoen
ebh = 8376627
conn.execute('insert into lakes (name, eb_int, provider) values (?, ?, ?)', 
             (u'Atnsjøen', ebh, 'NINA'))
## Atnsjoen (high frequency)

def logged2int(s):
    ret = 0
    if s == 'Logged':
        ret = 1
    elif len(s) > 0:
        ret = 2
    return(ret)

def conv_intensity(s):
    s = s.replace(',', '.').replace(' ', '')
    ret = 0 if s == '0.0' else float(s)
    return(ret)

def conv_datetime(s):
    s1, s2, s3 = s.split(' ')
    if s3 == 'AM':
        add = 0
    elif s3 == 'PM':
        add = 12
    else:
        complain
    day, month, year = s1.split('.')
    hour, minute, second = s2.split(':')
    day = int(day)
    month = int(month)
    year = int(year) + 2000
    hour = 0 + add if hour == '12' else int(hour) + add
    minute = int(minute)
    second = int(second)
    g2 = datetime.datetime(year, month, day, hour, minute, second, 0,
                           pytz.timezone('Etc/GMT+2'))
    return(g2)

atna_dd = [1, 5, 7.5, 10, 12.5, 15, 25]
for d in atna_dd:
    p = os.path.join('data', 'NINA data', 'temperaturdata', 'Atnsjø', 
                     'atna_%sm.txt' % d)
    data = pd.read_table(p, sep=';', decimal=',', skiprows=1, usecols=range(4),
                         dtype={'no':np.int32, 
                                'datetime':datetime.datetime, 
                                'temperature':np.float64, 
                                'intensity':np.float64, 
                                'bad_battery':np.int8, 
                                'good_battery':np.int8, 
                                'end_of_file':np.int8},
                         names=['no', 'datetime', 'temperature', 'intensity', 
                                'bad_battery', 'good_battery', 'end_of_file'],
                         converters={'datetime':conv_datetime, 
                                     'intensity':conv_intensity,
                                     'bad_battery':logged2int, 
                                     'good_battery':logged2int, 
                                     'end_of_file':logged2int})
    data2 = data.set_index('datetime')
    data2.index = data2.index.tz_convert(pytz.timezone('Etc/GMT+1'))
    grouped = data2.groupby(data2.index.date)
    m = grouped.mean()
    for i, r in m.iterrows():
        conn.execute('insert into temperature values (?, ?, ?, ?)', 
                     (ebh, i.isoformat(), d, r['temperature']))

## Atnsjoen (low frequency)
def conv_date(s):
    year, month, day = map(int, s.split('-'))
    return datetime.date(year, month, day)

p = os.path.join('data', 'NINA data', 'temperaturdata', 'Atnsjø', 
                 'Vanntemp 1989-2011_LakeAtna_edits.csv')
data = pd.read_table(p, sep=',', skiprows=1, usecols=range(1,4), 
                     dtype={'year':np.int8, 
                            'date':datetime.date, 
                            'detph':np.float64, 
                            'temperature':np.float64, 
                            'season':np.int8},
                     names=['year', 'date', 'depth', 'temperature', 'season'],
                     converters={'date':conv_date})
for i, r in data.iterrows():
    conn.execute('insert into temperature values (?, ?, ?, ?)', 
                 (ebh, r['date'], r['depth'], r['temperature']))

# todo remove the time after the logger came back to NINA building
# todo time zone of the loggers?

## Årungen
ebh = 2289199
conn.execute('insert into lakes (name, eb_int, provider) values (?, ?, ?)', 
             (u'Årungen', ebh, 'UMB'))
def conv_datetimeAA(s):
    s1, s2 = s.split(' ')
    day, month, year = map(int, s1.split('/'))
    hour, minute = map(int, s2.split(':'))
    return datetime.datetime(year, month, day, hour)

p = os.path.join('data', 'Årungen', 'Årungen -HOBO Data11_08-07_10.txt')
data = pd.read_table(p, sep='\t', skiprows=1, 
                     dtype={'datetime':datetime.datetime, 
                            't0.7m':np.float64, 
                            't1.3m':np.float64, 
                            't3.3m':np.float64, 
                            't4.4m':np.float64, 
                            't6.4m':np.float64, 
                            't8.4m':np.float64, 
                            't10.5m':np.float64, 
                            't12.6m':np.float64}, 
                     names=['datetime', 't0.7m', 't1.3m', 't3.3m', 
                            't4.4m', 't6.4m', 't8.4m', 't10.5m', 't12.6m'],
                     converters={'datetime':conv_datetimeAA})
data2 = data.set_index('datetime')
grouped = data2.groupby(data2.index.date)
m = grouped.mean()
for i, r in m.iterrows():
    conn.execute('insert into temperature values (?, ?, ?, ?)', 
                 (ebh, i.isoformat(), 0.7, r['t0.7m']))
    conn.execute('insert into temperature values (?, ?, ?, ?)', 
                 (ebh, i.isoformat(), 1.3, r['t1.3m']))
    conn.execute('insert into temperature values (?, ?, ?, ?)', 
                 (ebh, i.isoformat(), 3.3, r['t3.3m']))
    conn.execute('insert into temperature values (?, ?, ?, ?)', 
                 (ebh, i.isoformat(), 4.4, r['t4.4m']))
    conn.execute('insert into temperature values (?, ?, ?, ?)', 
                 (ebh, i.isoformat(), 6.4, r['t6.4m']))
    conn.execute('insert into temperature values (?, ?, ?, ?)', 
                 (ebh, i.isoformat(), 8.4, r['t8.4m']))
    conn.execute('insert into temperature values (?, ?, ?, ?)', 
                 (ebh, i.isoformat(), 10.5, r['t10.5m']))
    conn.execute('insert into temperature values (?, ?, ?, ?)', 
                 (ebh, i.isoformat(), 12.6, r['t12.6m']))

## Vansjø
ebh = 11110535
conn.execute('insert into lakes (name, eb_int, provider) values (?, ?, ?)', 
             (u'Vansjø', ebh, 'EUTROPIA-Koji'))
def conv_datetimeVansjo(s):
    s1, s2 = s.split(' ')
    year, month, day = map(int, s1.split('-'))
    hour, minute, second = s2.split(':')
    hour = int(hour)
    minute = int(minute)
    second = int(math.floor(float(second)))
    g2 = datetime.datetime(year, month, day, hour, minute, second, 0,
                           pytz.timezone('Etc/GMT+2'))
    return(g2)
    
fnames = ['vansjo_9700450_may_storefj_070910_buoy.csv',
          'vansjo_969316_may_storefj_1m_070910.csv',
          'vansjo_1058408_may_aleksandra storefj 1.1m (2m?) 070910.csv',
          'vansjo_9693117_may_storefj_3.3m_070910.csv',
          'vansjo_9700449_may_5.3m_storefj_070910.csv',
          'vansjo_1058415_may_aleksandra storefj 6.3m 070910.csv',
          'vansjo_9700452_may_storefj_9m_070910s.csv',
          'vansjo_9693115_may16.2m_storefj_070910.csv']
buoy_depth = 1.5
depthsVansjo = map(lambda(x): x + buoy_depth, 
                   [0, 1, 2, 3.3, 5.3, 6.3, 9, 16.2])
paths = [os.path.join('data', 'Vansjø', 'September 2010 Vansjø', 
                      'HOBO_Storefjorden', fname)
         for fname in fnames]
tuples = zip(depthsVansjo, paths)
for d, p in tuples:
    data = pd.read_table(p, sep=',', skiprows=2, 
                         names=['no', 'datetime', 'temperature', 
                                  'intensity', 'end_of_file'], 
                         dtype={'no':np.int64, 
                                'datetime':datetime.datetime, 
                                'temperature':np.float64, 
                                'intensity':np.float64, 
                                'end_of_file':str}, 
                         converters={'datetime':conv_datetimeVansjo})
    data2 = data.set_index('datetime')
    data2.index = data2.index.tz_convert(pytz.timezone('Etc/GMT+1'))
    grouped = data2.groupby(data2.index.date)
    m = grouped.mean()
    for i, r in m.iterrows():
        conn.execute('insert into temperature values (?, ?, ?, ?)', 
                     (ebh, i.isoformat(), d, r['temperature']))
                         

## summary stats
c = conn.execute('''select eb_int, count(), min(date), max(date) 
from temperature group by eb_int''')
for eb_int, count, min_date, max_date in c.fetchall():
    conn.execute('''update lakes set n_total = ?, min_date = ?, max_date = ?
                    where eb_int = ?''',
                 (count, min_date, max_date, eb_int))
c = conn.execute('select eb_int from lakes group by eb_int')
eb_int_list = [e[0] for e in c.fetchall()]
for eb_int in eb_int_list:
    c = conn.execute('''select depth from temperature where eb_int = ? 
                        group by depth''', (eb_int, ))
    n_depths = len(c.fetchall())
    c = conn.execute('''select date from temperature 
                        where eb_int = ? group by date''', (eb_int, ))
    n_dates = len(c.fetchall())
    conn.execute('''update lakes set n_depths = ?, n_dates = ?
                    where eb_int = ?''',
                 (n_depths, n_dates, eb_int))
    
conn.commit()
conn.close()
