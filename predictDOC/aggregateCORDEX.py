import os
import numpy as np
import pandas as pd
import pg8000
from sqlalchemy import create_engine
import h5py
import datetime

engine = create_engine('postgresql+pg8000://user:password@vm-srv-finstad.vm.ntnu.no/ecco_biwa_db')

ebintsql = '''
select ebint from ecco_biwa_lakes_v_0_1
where 
ccluster30 = 1 or 
ccomsat = 1 or 
ebint in (select ebint from north_euro_lake_surv_1995);
'''

ee = pd.read_sql(ebintsql, engine)

mrrosA = 'Catchment_mrros_EUR-11_ICHEC-EC-EARTH_historical_r3i1p1_DMI-HIRHAM5_v1_day_20010101-20051231.h5'
mrrosB = 'Catchment_mrros_EUR-11_ICHEC-EC-EARTH_rcp45_r3i1p1_DMI-HIRHAM5_v1_day_20060101-20101231.h5'
tasA = 'Catchment_tas_EUR-11_ICHEC-EC-EARTH_historical_r3i1p1_DMI-HIRHAM5_v1_day_20010101-20051231.h5'
tasB = 'Catchment_tas_EUR-11_ICHEC-EC-EARTH_rcp45_r3i1p1_DMI-HIRHAM5_v1_day_20060101-20101231.h5'
ya0 = 2001
ya1 = 2005
yb0 = 2006
yb1 = 2010

f = h5py.File(mrrosA, mode='r')
k = f.keys()
f.close()

for i, ebint in enumerate(ee['ebint']):
    print('%s %s' % (i, ebint))
    h = hex(int(ebint)).rstrip('L').lstrip('0x')
    if not (h in k):
        continue 
    ndaysA = (datetime.date(ya1, 12, 31) - datetime.date(ya0, 1, 1)).days + 1
    datesA = [datetime.date(ya0, 1, 1) + datetime.timedelta(d) 
              for d in range(ndaysA)]
    ndaysB = (datetime.date(yb1, 12, 31) - datetime.date(yb0, 1, 1)).days + 1
    datesB = [datetime.date(yb0, 1, 1) + datetime.timedelta(d)
              for d in range(ndaysB)]
    dfA = pd.DataFrame(datesA, columns = ['date'])
    dfB = pd.DataFrame(datesB, columns = ['date'])
    dfA['mrros'] = h5py.File(mrrosA, mode='r')[h][:]
    dfB['mrros'] = h5py.File(mrrosB, mode='r')[h][:]
    dfA['tas'] = h5py.File(tasA, mode='r')[h][:]
    dfB['tas'] = h5py.File(tasB, mode='r')[h][:]
    df = pd.concat([dfA, dfB])
    df['tas'] -= 273.15
    df['mrros'] *= (60 * 60 * 24 * 1e-3) # daily in m-1
    period = pd.PeriodIndex(df['date'], freq='D')
    df.index = period
    jj = df[(df.index.month > 5) & (df.index.month < 8)]
    mjja = df[(df.index.month > 4) & (df.index.month < 9)]
    mrrosjj = jj['mrros'].mean()
    mrrosmjja = mjja['mrros'].mean()
    tasjj = jj['tas'].mean()
    tasmjja = mjja['tas'].mean()
    outsql = 'insert into catchment_cordex_sept2015 values (%s, %f, %f, %f, %f);' % (
        ebint, mrrosjj, mrrosmjja, tasjj, tasmjja)
    _ = engine.execute(outsql)

