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
cbathnose = 1 or
ebint in (select ebint from "bath_lake_poly_NOSEFI_v5") or
ebint in (select ebint_old from "bath_lake_poly_NOSEFI_v5")
'''

ee = pd.read_sql(ebintsql, engine)

mrrosA = ['Catchment_mrros_EUR-11_ICHEC-EC-EARTH_%s_r3i1p1_DMI-HIRHAM5_v1_day_%s0101-%s1231.h5' % (e, y, y+4) for e, y in zip(['historical', 'rcp45', 'rcp45', 'rcp45'], [2001, 2031, 2061, 2091])]
mrrosB = ['Catchment_mrros_EUR-11_ICHEC-EC-EARTH_%s_r3i1p1_DMI-HIRHAM5_v1_day_%s0101-%s1231.h5' % (e, y+5, y+9) for e, y in zip(['rcp45', 'rcp45', 'rcp45', 'rcp45'], [2001, 2031, 2061, 2091])]
# tasA = 'Catchment_tas_EUR-11_ICHEC-EC-EARTH_historical_r3i1p1_DMI-HIRHAM5_v1_day_20010101-20051231.h5'
# tasB = 'Catchment_tas_EUR-11_ICHEC-EC-EARTH_rcp45_r3i1p1_DMI-HIRHAM5_v1_day_20060101-20101231.h5'
ya0list = [2001, 2031, 2061, 2091]
ya1list = [y+4 for y in ya0list]
yb0list = [y+5 for y in ya0list]
yb1list = [y+9 for y in ya0list]
yyy = zip(ya0list, ya1list, yb0list, yb1list)

f = h5py.File(mrrosA[0], mode='r')
k = f.keys()
f.close()

for i, ebint in enumerate(ee['ebint']):
    print('%s %s' % (i, ebint))
    results = np.nan * np.arange(4)
    for i, yy in enumerate(yyy):
        ya0, ya1, yb0, yb1 = yy
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
        dfA['mrros'] = h5py.File(mrrosA[i], mode='r')[h][:]
        dfB['mrros'] = h5py.File(mrrosB[i], mode='r')[h][:]
        df = pd.concat([dfA, dfB])
        df['mrros'] *= (60 * 60 * 24 * 1e-3) # daily in m-1
        period = pd.PeriodIndex(df['date'], freq='D')
        df.index = period
        results[i] = df['mrros'].sum()
    if np.all(np.isnan(np.array(results))):
        continue
    else:
        outsql = 'insert into catchment_cordex_oct2015 values (%s, %f, %f, %f, %f);' % (
            ebint, results[0], results[1], results[2], results[3])
        _ = engine.execute(outsql)
        
