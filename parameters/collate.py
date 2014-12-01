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
ebi = 8376627
conn.execute('insert into lakes (name, eb_int, provider) values (?, ?, ?)', 
             (u'Atnsjøen', ebi, 'NINA'))
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
                     (ebi, i.isoformat(), d, r['temperature']))

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
                 (ebi, r['date'], r['depth'], r['temperature']))

# todo remove the time after the logger came back to NINA building
# todo time zone of the loggers?

## Årungen
ebi = 2289199
conn.execute('insert into lakes (name, eb_int, provider) values (?, ?, ?)', 
             (u'Årungen', ebi, 'UMB-Aleksandra'))
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
                 (ebi, i.isoformat(), 0.7, r['t0.7m']))
    conn.execute('insert into temperature values (?, ?, ?, ?)', 
                 (ebi, i.isoformat(), 1.3, r['t1.3m']))
    conn.execute('insert into temperature values (?, ?, ?, ?)', 
                 (ebi, i.isoformat(), 3.3, r['t3.3m']))
    conn.execute('insert into temperature values (?, ?, ?, ?)', 
                 (ebi, i.isoformat(), 4.4, r['t4.4m']))
    conn.execute('insert into temperature values (?, ?, ?, ?)', 
                 (ebi, i.isoformat(), 6.4, r['t6.4m']))
    conn.execute('insert into temperature values (?, ?, ?, ?)', 
                 (ebi, i.isoformat(), 8.4, r['t8.4m']))
    conn.execute('insert into temperature values (?, ?, ?, ?)', 
                 (ebi, i.isoformat(), 10.5, r['t10.5m']))
    conn.execute('insert into temperature values (?, ?, ?, ?)', 
                 (ebi, i.isoformat(), 12.6, r['t12.6m']))

## Vansjø
ebi = 11110535
conn.execute('insert into lakes (name, eb_int, provider) values (?, ?, ?)', 
             (u'Vansjø', ebi, 'EUTROPIA-Koji'))
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
                     (ebi, i.isoformat(), d, r['temperature']))

## COMSAT lakes
p1 = os.path.join('data', 'COMSAT', 'COMSAT 2011 lakes utf8.txt')
def conv_datecomsat(s):
    day, month, year = map(int, s.split('.'))
    return(datetime.date(year, month, day))
def conv_timecomsat(s):
    hour, minute = map(int, s.split(':'))
    return(datetime.time(hour, minute))
def empty2none(s):
    ret = None if s == '' else s
    return(ret)
lakemeta = pd.read_table(p1, sep='\t', skiprows=1, 
                         names=['ID', 'Lake', 'Date', 'Time', 
                                'Latitude', 'Longitude', 'Altitude', 
                                'Area', 'NVEID', 'NVEREGINE', 
                                'SMHIID', 'EUCD', 'VDRID'], 
                         dtype={'ID':np.int16, 
                                'Lake':str, 
                                'Date':datetime.date, 
                                'Time':datetime.time, 
                                'Latitude':np.float64, 
                                'Longitude':np.float64, 
                                'Altitude':np.float64, 
                                'Area':np.float64, 
                                'NVEID':np.int64,
                                'NVEREGINE':str,
                                'SMHIID':str, 
                                'EUCD':str, 
                                'VDRID':str},
                         converters={'Date':conv_datecomsat, 
                                     'Time':conv_timecomsat, 
                                     'NVEID':empty2none, 
                                     'NVEREGINE':empty2none,
                                     'SMHIID':empty2none, 
                                     'EUCD':empty2none, 
                                     'VDRID':empty2none})
p2 = os.path.join('data', 'COMSAT', 'CTD', 'ctd.all.fixed.txt')
def conv2_date(s):
    s1, month, s3 = map(int, s.split('/'))
    if s3 > 999:
        year = s3 ; day = s1
    else:
        year = s1 ; day = s3
    return datetime.date(year + 2000, month, day)
def conv2_time(s):
    hour, minute, second = s.split(':')
    hour = int(hour)
    minute = int(minute)
    second, decimalsecond = map(int, second.split('.'))
    microsecond = decimalsecond * 1000
    return datetime.time(hour, minute, second, microsecond)
ctd = pd.read_table(p2, sep=' ', skiprows=1, quotechar = '"', quoting=1,
                    encoding='utf-8',
                    names=['rownames', 'l', 'year', 'Lake', 'Date', 'Time', 'Cond', 
                           'Temp', 'Pres', 'RTemp', 'PAR', 'RDO2',
                           'TFlCa', 'TFlEa', 'TFlPa', 'Depth', 'Salin',
                           'SpecCond', 'DensAnom', 'SoS', 'rdO2C'], 
                    dtype={'rownames':np.int64, 
                           'l':np.int64, 'year':np.int64, 'Lake':str, 
                           'Date':datetime.date, 'Time':datetime.time,
                           'Cond':np.float64, 'Temp':np.float64, 
                           'Pres':np.float64, 'RTemp':np.float64, 
                           'PAR':np.float64, 'RDO2':np.float64,
                           'TFlCa':np.float64, 'TFlEa':np.float64, 
                           'TFlPa':np.float64, 'Depth':np.float64, 
                           'Salin':np.float64, 'SpecCond':np.float64, 
                           'DensAnom':np.float64, 'SoS':np.float64, 
                           'rdO2C':np.float64},
                    na_values = ['Inf'],
                    converters={'Date':conv2_date, 'Time':conv2_time})

p3 = os.path.join('..', '..', '..', '..', 'GIS_DATA', 'fenoscand_lakes')
p4 = 'ecco-biwa_lakes_v.0.1'
datasource = osgeo.ogr.Open(p3)
layer = datasource.GetLayerByName(p4)
comsatgeom = set()
feat = layer.GetNextFeature()
fieldnames = feat.keys()
print('it will take a few minute...')
while feat is not None:
    if feat.items()['cCOMSAT'] == 1:
        comsatgeom.add(feat)
        print('... found %s' % feat.items()['EBint'])
    feat = layer.GetNextFeature()
comsatgeom = list(comsatgeom)
coords = [f.GetGeometryRef().GetGeometryRef(0).GetPoints() 
          for f in comsatgeom]
ebint = [f.items()['EBint'] for f in comsatgeom]
vatnlnr = [f.items()['vatn_lnr'] for f in comsatgeom]
altitude = [f.items()['vfp_mean'] for f in comsatgeom]
meancoords = [np.array(c).mean(axis=0) for c in coords]
# indices0 = []
# indices1 = []
lakemeta['ebint'] = np.repeat(0, len(lakemeta))
for i, a in enumerate(meancoords):
    flag = False
    the_index = -1
    longitude = a[0]
    latitude = a[1]
    diff = (lakemeta['Longitude'] - longitude) ** 2 + \
           ((lakemeta['Latitude'] - latitude) * 2) ** 2
    diff.sort()
    # indices0.append(diff.index[0])
    # indices1.append(diff.index[1])
    altdiff = (lakemeta['Altitude'] - float(altitude[i])).abs()
    altdiff.sort()
    print(i, vatnlnr[i],
          lakemeta.NVEID.ix[diff.index[0]], diff.index[0], 
          lakemeta.NVEID.ix[diff.index[1]], diff.index[1], 
          ebint[i])
    if vatnlnr[i] == 374:
            the_index = 48
    elif not vatnlnr[i] == 0:
        if vatnlnr[i] == 65804:
            flag = True
            vatnlnr[i] = 65803
        if lakemeta.NVEID.ix[diff.index[0]] is not None:
            if vatnlnr[i] == int(lakemeta.NVEID.ix[diff.index[0]]):
                the_index = diff.index[0]
        if lakemeta.NVEID.ix[diff.index[1]] is not None:
            if vatnlnr[i] == int(lakemeta.NVEID.ix[diff.index[1]]):
                the_index = diff.index[1]
        if lakemeta.NVEID.ix[diff.index[2]] is not None:
            if vatnlnr[i] == int(lakemeta.NVEID.ix[diff.index[2]]):
                the_index = diff.index[2]
        if lakemeta.NVEID.ix[diff.index[3]] is not None:
            if vatnlnr[i] == int(lakemeta.NVEID.ix[diff.index[3]]):
                the_index = diff.index[3]
    else:
        the_index_by_dist = diff.index[0]
        # the_index_by_elev = altdiff.index[0]
        # exception = [0, 7, 12, 16, 22, 24, 26, 28, 33, 35, 37, 39, 40, 44, 46, 
        #              50, 51, 55, 60, 62, 64, 65, 66, 67, 69, 72, 74, 76, 77]
        # if i in exception:
        #     the_index = the_index_by_dist
        # elif the_index_by_dist == the_index_by_elev:
        #     the_index = the_index_by_dist
        # else:
        the_index = the_index_by_dist
            # print(i, the_index_by_dist, the_index_by_elev, 
            #       diff[diff.index[0]], diff[diff.index[1]], 
            #       altdiff[altdiff.index[0]], altdiff[altdiff.index[1]])
    if not flag:
        lakemeta['ebint'].ix[the_index] = ebint[i]
# do not know 58 and 59 and 60
# do not know i = 60 
# looks okay actually
for i, r in lakemeta.iterrows():
    comsatID = str(r['ID'])
    if comsatID == '194':
        print('skipping Sperillen, comsatID = 194, as there is no CTD data')
        continue 
    name = r['Lake']
    date = r['Date']
    ebi = r['ebint']
    ctdsub = ctd[ctd['Lake'] == comsatID][['Date', 'Time', 'Temp', 'Depth']]
    assert date == ctdsub['Date'].tolist()[0]
    ctdsub = ctdsub[['Time', 'Temp', 'Depth']]
    print(comsatID, name, date, ebi)
    print(ctdsub)
    for subi, subr in ctdsub.iterrows():
        # time = subr['Time']
        # dt = datetime.datetime(date.year, date.month, date.day, time.hour, 
        #                        time.minute, time.second, time.microsecond, 
        #                        pytz.timezone('Etc/GMT+2'))
        conn.execute('insert into temperature values (?, ?, ?, ?)', 
                     (ebi, date, subr['Depth'], subr['Temp']))
    conn.execute('insert into lakes (name, eb_int, provider) values (?, ?, ?)', 
                 (name.decode('utf-8'), ebi, 'COMSAT'))
    
                      

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
