import pandas as pd
import numpy as np
import os
import datetime
import matplotlib.pyplot as plt
import seaborn as sns


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

lakemeta['WindSpeed_field_day'] = np.repeat(np.nan, lakemeta.shape[0])
lakemeta['WindSpeed_mean_JA'] = np.repeat(np.nan, lakemeta.shape[0])
lakemeta['WindSpeed_mean_annual'] = np.repeat(np.nan, lakemeta.shape[0])
iJA = (wind.index >= datetime.date(2011, 7, 1)) & \
      (wind.index <= datetime.date(2011, 8, 31))

for i, r in lakemeta.iterrows():
    comsatID = r['ID']
    if comsatID == 194:
        print('skipping Sperillen, comsatID = 194, as there is no CTD data')
        continue 
    name = r['Lake']
    date = r['Date']
    lakemeta['WindSpeed_field_day'].ix[i] = wind.ix[date]['id%s' % comsatID]
    lakemeta['WindSpeed_mean_JA'].ix[i] = wind.ix[iJA]['id%s' % comsatID].mean()
    lakemeta['WindSpeed_mean_annual'].ix[i] = wind['id%s' % comsatID].mean()
lakemeta.to_csv('Wind speed at COMSAT lakes field day and JA.csv')


sns.set_style('ticks')
fig = plt.figure()
# ax = fig.add_subplot(111)
axx = pd.tools.plotting.scatter_matrix(lakemeta[['WindSpeed_field_day', 
                                           'WindSpeed_mean_JA', 
                                           'WindSpeed_mean_annual']], 
                                       diagonal='kde')

                                       # ax=ax)
xy = [(0, 1), (0, 2), 
      (1, 0), (1, 2), 
      (2, 0), (2, 1)]
for xi, yi in xy:
    axx[xi][yi].plot([0.5, 5.3], [0.5, 5.3], 'b-')
    axx[xi][yi].set_xlim([0.5, 5.3])
    axx[xi][yi].set_ylim([0.5, 5.3])
for xyi in range(3):
    axx[xyi][xyi].set_xlim([0.5, 5.3])
    axx[xyi][xyi].set_ylim([0, 1])
        

fig2 = plt.gcf()
fig2.set_figheight(7)
fig2.set_figwidth(7)
fig2.savefig('wind speed comparison.pdf')

