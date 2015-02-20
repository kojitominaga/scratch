import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

lakes = pd.read_table('Feb2015GoranList.csv', sep=',')
empty = pd.Series(index = lakes.index)
yearranges = [(1971, 1980), (2001, 2010), (2031, 2040), 
              (2061, 2070), (2091, 2100)]
yearrangesstr = ['%s-%s' % (y0, y1) for y0, y1 in yearranges]
for yy in yearrangesstr:
    lakes['dd%sKNMI' % yy] = empty
    lakes['dd%sDMI' % yy] = empty
for yy in yearrangesstr:
    lakes['d%sKNMI' % yy] = empty
    lakes['d%sDMI' % yy] = empty
for yy in yearrangesstr:
    lakes['sw%sKNMI' % yy] = empty
    lakes['sw%sDMI' % yy] = empty
for y0, y1 in yearranges:
    for y in range(y0, y1 + 1):
        lakes['dd%sKNMI' % y] = empty
        lakes['dd%sDMI' % y] = empty
for y0, y1 in yearranges:
    for y in range(y0, y1 + 1):
        lakes['d%sKNMI' % y] = empty
        lakes['d%sDMI' % y] = empty
for y0, y1 in yearranges:
    for y in range(y0, y1 + 1):
        lakes['sw%sKNMI' % y] = empty
        lakes['sw%sDMI' % y] = empty
scenarios = ['EUR-11_ICHEC-EC-EARTH_historical-historical_r1i1p1_KNMI-RACMO22E_v1_day_19710101-19801231',
             'EUR-11_ICHEC-EC-EARTH_historical-historical_r3i1p1_DMI-HIRHAM5_v1_day_19710101-19801231', 
             'EUR-11_ICHEC-EC-EARTH_historical-rcp45_r1i1p1_KNMI-RACMO22E_v1_day_20010101-20101231', 
             'EUR-11_ICHEC-EC-EARTH_historical-rcp45_r3i1p1_DMI-HIRHAM5_v1_day_20010101-20101231',
             'EUR-11_ICHEC-EC-EARTH_rcp45-rcp45_r1i1p1_KNMI-RACMO22E_v1_day_20310101-20401231',
             'EUR-11_ICHEC-EC-EARTH_rcp45-rcp45_r1i1p1_KNMI-RACMO22E_v1_day_20610101-20701231',
             'EUR-11_ICHEC-EC-EARTH_rcp45-rcp45_r1i1p1_KNMI-RACMO22E_v1_day_20910101-21001231',
             'EUR-11_ICHEC-EC-EARTH_rcp45-rcp45_r3i1p1_DMI-HIRHAM5_v1_day_20310101-20401231',
             'EUR-11_ICHEC-EC-EARTH_rcp45-rcp45_r3i1p1_DMI-HIRHAM5_v1_day_20610101-20701231',
             'EUR-11_ICHEC-EC-EARTH_rcp45-rcp45_r3i1p1_DMI-HIRHAM5_v1_day_20910101-21001231']

prefix = os.path.join('..', '..', '..', '..', 'lakesGoranREDO')



# ## based on extremes
# for lakei, r in lakes.iterrows():
#     ebh = r['ebhex']
#     ebh2 = ebh.lstrip('0x')
#     while len(ebh2) < 6:
#         ebh2 = '0' + ebh2
#     s1 = ebh2[:2]
#     s2 = ebh2[:4]
#     print(ebh2)

#     Secchi = r['secchi']
#     la = 1.7 / Secchi # light attenuation

#     for sc in scenarios:
#         date0, date1 = sc.split('_')[-1].split('-')
#         yearrangestr = '%s-%s' % (date0[:4], date1[:4])
#         model = sc.split('_')[4]
#         inst = model.split('-')[0]

#         d0 = os.path.join(prefix, s1, s2, ebh2, sc)
#         tzt = pd.read_table(os.path.join(d0, 'TztGoran.csv.gz'), 
#                             header=None, compression='gzip', sep=',')
#         tzt.index = pd.date_range(start=date0, end=date1, freq='D')
#         qst = pd.read_table(os.path.join(d0, 'QstGoran.csv.gz'), 
#                             header=None, compression='gzip', sep=',', 
#                             names=['sw', 'lw', 'sl'])
#         qst.index = pd.date_range(start=date0, end=date1, freq='D')

#         dd = tzt.shape[1]
#         jjasp = np.logical_and(tzt.index.month > 5, tzt.index.month < 10)
#         depth10c = []
#         light10c = []
#         years = list(set(tzt.index.year))
#         for y in years:
#             dlist = [] ; swlist = []
#             for i, r in tzt[np.logical_and(jjasp, tzt.index.year == y)].iterrows():
#                 d10c = min(np.arange(dd)[r.values < 10]) if np.any(r.values < 10) else np.nan
#                 I0 = qst['sw'][i]
#                 sw10c = I0 * np.exp(-la * d10c) if not d10c == np.nan else np.nan
#                 dlist.append(d10c) ; swlist.append(sw10c)
#             depth10c.append(np.max(dlist)) # NB max
#             light10c.append(np.min(swlist)) # NB min
#             lakes['d%s%s' % (y, inst)][lakei] = np.max(dlist)
#             lakes['sw%s%s' % (y, inst)][lakei] = np.min(swlist)
#         lakes['d%s%s' % (yearrangestr, inst)][lakei] = np.max(depth10c)
#         lakes['sw%s%s' % (yearrangestr, inst)][lakei] = np.min(light10c)

# lakes.to_csv('test.csv')
# lakes.to_csv('test-latin8.csv', encoding='latin8')



## medians
for lakei, r in lakes.iterrows():
    ebh = r['ebhex']
    ebh2 = ebh.lstrip('0x')
    while len(ebh2) < 6:
        ebh2 = '0' + ebh2
    s1 = ebh2[:2]
    s2 = ebh2[:4]
    print(ebh2)

    Secchi = r['secchi']
    la = 1.7 / Secchi # light attenuation

    for sc in scenarios:
        date0, date1 = sc.split('_')[-1].split('-')
        yearrangestr = '%s-%s' % (date0[:4], date1[:4])
        model = sc.split('_')[4]
        inst = model.split('-')[0]

        d0 = os.path.join(prefix, s1, s2, ebh2, sc)
        tzt = pd.read_table(os.path.join(d0, 'TztGoran.csv.gz'), 
                            header=None, compression='gzip', sep=',')
        tzt.index = pd.date_range(start=date0, end=date1, freq='D')
        qst = pd.read_table(os.path.join(d0, 'QstGoran.csv.gz'), 
                            header=None, compression='gzip', sep=',', 
                            names=['sw', 'lw', 'sl'])
        qst.index = pd.date_range(start=date0, end=date1, freq='D')

        dd = tzt.shape[1]
        jjas = np.logical_and(tzt.index.month > 5, tzt.index.month < 10)
        jj = np.logical_and(tzt.index.month > 5, tzt.index.month < 8)
        depthdays10c = []
        depth10c = []
        light10c = []
        years = list(set(tzt.index.year))
        for y in years:
            dlist = [] ; swlist = []
            for i, r in tzt[np.logical_and(jjas, tzt.index.year == y)].iterrows():
                d10c = min(np.arange(dd)[r.values < 10]) if np.any(r.values < 10) else 9999
                I0 = qst['sw'][i]
                sw10c = I0 * np.exp(-la * d10c) if not d10c == 9999 else -99
                dlist.append(d10c) ; swlist.append(sw10c)
            depth10c.append(np.max(dlist)) # NB max
            light10c.append(np.min(swlist)) # NB min
            lakes['d%s%s' % (y, inst)][lakei] = np.max(dlist)
            lakes['sw%s%s' % (y, inst)][lakei] = np.min(swlist)

            ## depth-days
            the_dd = 0
            for i, r in tzt[np.logical_and(jj, tzt.index.year == y)].iterrows():
                d10c = min(np.arange(dd)[r.values < 10]) if np.any(r.values < 10) else 9999
                dd10c = dd - d10c if not d10c == 9999 else 0
                the_dd += dd10c
            depthdays10c.append(the_dd)
            lakes['dd%s%s' % (y, inst)][lakei] = the_dd
        lakes['dd%s%s' % (yearrangestr, inst)][lakei] = np.median(depthdays10c)
        lakes['d%s%s' % (yearrangestr, inst)][lakei] = np.median(depth10c)
        lakes['sw%s%s' % (yearrangestr, inst)][lakei] = np.median(light10c)

lakes.to_csv('test-dd-median.csv')
lakes.to_csv('test-dd-median-latin8.csv', encoding='latin8')


# mlin = pd.read_table(os.path.join(d0, 'vanillainput.bz2'), 
#                      sep='\t', 
#                      dtype={'year':np.int32, 
#                             'month':np.int32, 
#                             'day':np.int32, 
#                             'radiation':np.float64, 
#                             'cloudcov':np.float64, 
#                             'airtemp':np.float64, 
#                             'relhumid':np.float64, 
#                             'airpress':np.float64, 
#                             'windspeed':np.float64, 
#                             'precip':np.float64, 
#                             'ex1':np.float64, 
#                             'ex2':np.float64, 
#                             'ex3':np.float64, 
#                             'ex4':np.float64, 
#                             'ex5':np.float64, 
#                             'ex6':np.float64, 
#                             'ex7':np.float64, 
#                             'ex8':np.float64}, 
#                      names = ['year', 'month', 'day', 
#                               'radiation', 'cloudcov', 'airtemp', 'relhumid', 
#                               'airpress', 'windspeed', 'precip',
#                               'ex1', 'ex2', 'ex3', 'ex4', 
#                               'ex5', 'ex6', 'ex7', 'ex8'], 
#                      compression='bz2', header=None, 
#                      skiprows = 2 + 365 + 365)
# mlin.index = pd.date_range(start=date0, end=date1, freq='D')

