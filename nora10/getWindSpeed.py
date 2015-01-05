import pandas as pd
import numpy as np
import os
import datetime


p1 = os.path.join('..', 'parameters', 'data', 'COMSAT', 
                  'COMSAT 2011 lakes utf8.txt')
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
for i, r in lakemeta.iterrows():
    comsatID = r['ID']
    if comsatID == 194:
        print('skipping Sperillen, comsatID = 194, as there is no CTD data')
        continue 
    name = r['Lake']
    date = r['Date']
    wfn = 'interpolated-COMSAT%s_NORA10_1H_11km_wss_10m_2011.txt.gz' % comsatID
    windp = os.path.join('interpolated', 'COMSAT%s' % comsatID, wfn)
    windlake = pd.read_table(windp, sep=' ', header=None, skiprows=0, 
                             compression='gzip', na_values='NA')
    tfn = 'interpolated-COMSAT%s_NORA10_1H_11km_ta_2m_2011.txt.gz' % comsatID
    tp = os.path.join('interpolated', 'COMSAT%s' % comsatID, tfn)
    tlake = pd.read_table(tp, sep=' ', header=None, skiprows=0, 
                          compression='gzip', na_values='NA')

    if i == 0:
        wind = pd.DataFrame(windlake[0], columns=['id%s' % comsatID])
    else:
        wind['id%s' % comsatID] = windlake[0]
wind.index = [datetime.date(2011, 1, 1) + datetime.timedelta(d) 
              for d in range(365)]

wind.to_csv('Wind speed at COMSAT lakes 2011.csv')

lakemeta['WindSpeed'] = np.repeat(np.nan, lakemeta.shape[0])
for i, r in lakemeta.iterrows():
    comsatID = r['ID']
    if comsatID == 194:
        print('skipping Sperillen, comsatID = 194, as there is no CTD data')
        continue 
    name = r['Lake']
    date = r['Date']
    lakemeta['WindSpeed'].ix[i] = wind.ix[date]['id%s' % comsatID]
lakemeta.to_csv('Wind speed at COMSAT lakes field day.csv')

