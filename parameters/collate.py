import sqlite3
import os
import numpy as np
import pandas as pd
import datetime


conn = sqlite3.connect(os.path.join('data', 'processed', 'laketemp.sqlite'))
c = conn.cursor

conn.execute('''create table lakes (
name text, 
provider text, 
eb_int integer primary key, 
n_total integer, 
n_depths integer, 
n_times integer)''')

conn.execute('''create table temperature (
eb_int integer, 
datetime integer, 
depth real, 
temperature real)''')

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
    return(datetime.datetime(year, month, day, hour, minute, second))

atna_dd = [1, 5, 7.5, 10, 12.5, 15, 25]
ebh = 8376627
for d in atna_dd:
    p = os.path.join('data', 'NINA data', 'temperaturdata', 'Atnsjo', 
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
                                     'end_of_file':logged2int}
                         )
    for i, r in data.iterrows():
        conn.execute('insert into temperature values (?, ?, ?, ?)', 
                     (ebh, r['datetime'], d, r['temperature']))

## Atnsjoen (low frequency)
def conv_date(s):
    year, month, day = map(int, s.split('-'))
    return datetime.date(year, month, day)

p = os.path.join('data', 'NINA data', 'temperaturdata', 'Atnsjo', 
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

conn.commit()
conn.close()

# todo remove the time after the logger came back to NINA building
# todo time zone of the loggers?
