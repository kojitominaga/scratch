import os
import numpy as np
import pandas as pd
import pg8000
from sqlalchemy import create_engine
import datetime
import scipy.optimize
import scipy.interpolate

engine = create_engine('postgresql+pg8000://user:password@vm-srv-finstad.vm.ntnu.no/ecco_biwa_db')

sqlagnotdone = "select ebint from mylake.kt_orders o where o.lastaggdone is null"
orders = pd.read_sql(sqlagnotdone, engine)
if len(orders) == 0:
    os._exit(1)
ee = orders['ebint'].values
# ## just for COMSAT
# comsat = pd.read_csv('COMSAT_utf8.csv')
# ee = comsat.ebint.values

## get relevant mms
sqlgetmm = """select mm, ya0 as y0, yb1 as y1 
from mylake.mm, 
where mm = 22 or mm = 26 or mm = 27 or mm = 28"""
mms = pd.read_sql(sqlgetmm, engine)

first_time = True

ee = ee[:10]

## looped version
for ei, e in enumerate(ee):
    print(ei)
    h = hex(e).rstrip('L').lstrip('0x')
    eh = h
    while len(eh) < 6:
        eh = '0' + eh
    d1, d2, d3 = eh[:2], eh[:4], eh[:6]
    # ## acknowledge it started
    # sqlupdate1 = """update kt_orders set lastaggtry = current_timestamp 
    #                 where ebint = %s""" % e
    # _ = engine.execute(sqlupdate1)
    
    
    # going through initial decade as the reference
    print('this current version does NOT work for multiple RCMs, reference to the historical needs to be RCM specific')
    mm0, y00, y10 = mms.iloc[0, :]
    wd0 = os.path.join('/data/lakes', d1, d2, d3, '%02d' % mm0)
    ndays0 = (datetime.date(y10, 12, 31) - datetime.date(y00, 1, 1)).days + 1
    dates0 = [datetime.date(y00, 1, 1) + datetime.timedelta(d) 
              for d in range(ndays0)]
    dti0 = pd.DatetimeIndex(dates0)
    period0 = pd.PeriodIndex(dates0, freq='D')
    if not os.path.exists(os.path.join(wd0, 'Tzt.csv.gz')):
        continue
    t0 = pd.read_csv(os.path.join(wd0, 'Tzt.csv.gz'), 
                     compression='gzip', header=None)
    t0.index = period0
    h0 = pd.read_csv(os.path.join(wd0, 'His.csv.gz'), 
                     compression='gzip', header=None)
    h0.index = period0
    q0 = pd.read_csv(os.path.join(wd0, 'Qst.csv.gz'), 
                     compression='gzip', header=None)
    q0.index = period0
    k0 = pd.read_csv(os.path.join(wd0, 'Kzt.csv.gz'), 
                     compression='gzip', header=None)
    k0.index = period0
    # weqs0 = h0.iloc[:, 1] * h0.iloc[:, 5] / 1000 
    # Hs * rho_snow / rho_freshwater rho_fw
    icesnowatt0 = np.exp(-5 * h0.iloc[:, 0]) * np.exp(-15 * h0.iloc[:, 1])
    icesnowatt0.iloc[np.logical_not(h0.iloc[:, 6] == 1).values] = 1
    # exp(-lambda_i * Hi) * exp(-lambda_s * (rho_fw/rho_snow)*weqs)
    sw15 = q0.iloc[:, 0] * icesnowatt0 * 0.45 * np.exp(-1 * 15) \
           if t0.shape[1] >= 15 \
              else pd.DataFrame(np.zeros((ndays0, 1)) * np.nan)
    sw15.index = period0
    sw15 = np.log(sw15)
    sw15 = sw15.resample('M')
    sw15 = sw15.groupby(sw15.index.month).mean()
    fr15pr = sw15 # Frode's PAR level at 15m
    sw05 = q0.iloc[:, 0] * icesnowatt0 * 0.45 * np.exp(-1 * 5) \
           if t0.shape[1] >= 5 \
              else pd.DataFrame(np.zeros((ndays0, 1)) * np.nan)
    sw05.index = period0
    sw05 = np.log(sw05)
    sw05 = sw05.resample('M')
    sw05 = sw05.groupby(sw05.index.month).mean()
    fr05pr = sw05 # Frode's PAR level at 05m    fr15tr = (t0.iloc[:, 14] + t0.iloc[:, 15]) / 2 \
             if t0.shape[1] >= 16 \
                else pd.DataFrame(np.zeros((ndays0, 1)) * np.nan)
    fr15tr.index = period0
    fr15tr = fr15tr.resample('M')
    fr15troriginal = fr15tr
    fr15tr[fr15tr < 3.98] = np.nan
    grouped15 = fr15tr.groupby(fr15tr.index.month)
    allwarm15 = np.array([np.logical_not(np.isnan(g)).sum() == 10 
                          for k, g in grouped15])
    fr15tr = grouped15.mean()
    fr15tr[np.logical_not(allwarm15)] = np.nan
    ## Frode's 15m temperature ref
    fr05tr = (t0.iloc[:, 4] + t0.iloc[:, 5]) / 2 \
             if t0.shape[1] >= 6 \
                else pd.DataFrame(np.zeros((ndays0, 1)) * np.nan)
    fr05tr.index = period0
    fr05tr = fr05tr.resample('M')
    fr05troriginal = fr05tr
    fr05tr[fr05tr < 3.98] = np.nan
    grouped05 = fr05tr.groupby(fr05tr.index.month)
    allwarm05 = np.array([np.logical_not(np.isnan(g)).sum() == 10 
                          for k, g in grouped05])
    fr05tr = grouped05.mean()
    fr05tr[np.logical_not(allwarm05)] = np.nan
    ## Frode's 05m temperature ref

    print('this current version does NOT work with varying extinction coefficients')
    # Hs * rho_snow / rho_freshwater rho_fw
    icesnowatt = np.exp(-5 * h0.iloc[:, 0]) * np.exp(-15 * h0.iloc[:, 1])
    icesnowatt.iloc[np.logical_not(h0.iloc[:, 6] == 1).values] = 1
    # exp(-lambda_i * Hi) * exp(-lambda_s * (rho_fw/rho_snow)*weqs)
    sw15 = q0.iloc[:, 0] * icesnowatt * 0.45 * np.exp(-1 * 15) \
           if t0.shape[1] >= 15 \
              else pd.DataFrame(np.zeros((ndays0, 1)) * np.nan)
    sw15.index = period0
    sw15 = np.log(sw15)
    sw15 = sw15.resample('M')
    sw15 = sw15.groupby(sw15.index.month).mean()
    fr15pr = sw15
    sw05 = q0.iloc[:, 0] * icesnowatt * 0.45 * np.exp(-1 * 5) \
           if t0.shape[1] >= 5 \
              else pd.DataFrame(np.zeros((ndays0, 1)) * np.nan)
    sw05.index = period0
    sw05 = np.log(sw05)
    sw05 = sw05.resample('M')
    sw05 = sw05.groupby(sw05.index.month).mean()
    fr05pr = sw05
    
    # e: ebint
    # mm: myriadmyriad
    # sim: sim_id
    # y0: first year of the decade
    # y1: last year of the decade
    # ndays: number of days in the decade
    # dti: pd.DatetimeIndex of the dates in the decade
    # t: temperature profile [day x depth]
    # h: ice variables [day x variable]
    # q: heat variables [day x variable]
    # k: 
    # r: rho, water density [day x depth]
    # dr: delta rho [day x (depth - 1)]
    # stratified: bool [day]
    # pycd: max pycnocline or mixing depth [day]
    #       if mixed completely lake's maximum depth
    # 

    # pcn00 ... pcn12: annual and monthly mixing depth [day]
    # tsw00 ... tws12: annual and monthly temperature surface water [day]
    

    for mm, y0, y1 in mms.itertuples(index=False):
        sim = mm * 2e7 + e  # the sim_id
        wd = os.path.join('/data/lakes', d1, d2, d3, '%02d' % mm)
        # wd = os.path.join('/Users/kojito/Desktop/lakes', d1, d2, d3, '%02d' % mm)
        ndays = (datetime.date(y1, 12, 31) - datetime.date(y0, 1, 1)).days + 1
        dates = [datetime.date(y0, 1, 1) + datetime.timedelta(d) 
                 for d in range(ndays)]
        dti = pd.DatetimeIndex(dates)
        period = pd.PeriodIndex(dates, freq='D')
        if not os.path.exists(os.path.join(wd, 'Tzt.csv.gz')):
            continue
        t = pd.read_csv(os.path.join(wd, 'Tzt.csv.gz'), 
                        compression='gzip', header=None)
        t.index = period
        h = pd.read_csv(os.path.join(wd, 'His.csv.gz'), 
                        compression='gzip', header=None)
        h.index = period
        q = pd.read_csv(os.path.join(wd, 'Qst.csv.gz'), 
                        compression='gzip', header=None)
        q.index = period
        k = pd.read_csv(os.path.join(wd, 'Kzt.csv.gz'), 
                        compression='gzip', header=None)
        k.index = period
        if np.logical_not(np.isnan(t.values)).sum() == 0:
            continue 
        # rho density
        r = 999.842594 + t * (6.793952e-2 + t * (-9.09529e-3 + 
            t * (1.001685e-4 + t * (-1.120083e-6 + t * 6.536332e-9))))
        # delta rho
        dr = np.concatenate((np.repeat(np.array([[0]]), r.shape[0], axis=0), 
                             r.iloc[:, :-1].values - r.iloc[:, 1:].values), 
                            axis=1)
        dr = np.abs(dr)
        drd0, drd1 = dr.shape
        drthreshold = 0.05
        dr[dr < drthreshold] = 0
        dr[t.values < 3.98] = 0 
        ## this .values is important as pd.DataFrame < 3.98 does not work
        drz = dr * np.arange(drd1).reshape((1, drd1)).repeat(drd0, axis=0)
        pycd = drz.sum(axis=1) / dr.sum(axis=1)
        stratified = np.logical_not(np.isnan(pycd))
        stratified = pd.DataFrame(stratified)
        stratified.index = dti
        pycd[np.logical_not(stratified.iloc[:, 0].values)] = drd1 - 1.0 # if not stratified mix to the bottom 
        pycd = pd.DataFrame(pycd)
        pycd.index = dti

        # pcd01-pcd12 # depth
        pcd = pycd.resample('M').values.reshape((10, 12))
        # pcd00
        pcd00 = pcd.mean(axis=1).reshape((10, 1))
        # pcn01-pcn12 # number of stratified days in a month
        pcn = stratified.resample('M', how='sum').values.reshape((10, 12))
        # pcn00
        pcn00 = pcn.mean(axis=1).reshape((10, 1))

        # tsw01-tsw12
        tsw = t.iloc[:, 0].resample('M').reshape((10, 12))
        # tsw00
        tsw00 = tsw.mean(axis=1).reshape((10, 1))

        # icend
        icend = h.iloc[:, 6].resample('A', how='sum').reshape((10, 1))
        # icemh maximum height
        icemh = h.iloc[:, 0].resample('A', how='max').reshape((10, 1))

        # icedu duration, iceon, iceof
        # iceth number of thawing events during the icedu period
        icedu = np.zeros((10, 1)) * np.nan
        iceon = np.zeros((10, 1)) * np.nan
        iceof = np.zeros((10, 1)) * np.nan
        iceth = np.zeros((10, 1)) * np.nan
        for yi, thisy in enumerate(t.resample('A').index.year):
            ndaysthisyear = pd.to_datetime('%s-12-31' % thisy).dayofyear
            # 1. first find the warmest surface water day of year
            thisyear = t[t.index.year == thisy]
            s = thisyear.iloc[:, 0]
            if s.max() == np.nan:
                # if ice-covered whole year
                iceony = np.nan
                iceofy = np.nan
            else:
                maxdoy = s[s == s.max()].index.dayofyear[0] # just pick the 1st
                # 2. find last ice covered day of year before maxdoy
                earlier = h[(h.index.year == thisy) &
                            (h.index.dayofyear < maxdoy)].iloc[:, 6]
                if earlier.sum() == 0:
                    # no ice
                    iceofy = np.nan
                else:
                    iceofy = earlier[earlier == 1].index.dayofyear.max() + 1
                # 3. first ice covered day of year after maxdoy
                later = h[(h.index.year == thisy) & 
                          (h.index.dayofyear > maxdoy)].iloc[:, 6]
                if later.sum() == 0:
                    # no ice
                    iceony = np.nan
                else:
                    iceony = later[later == 1].index.dayofyear.min()
            # there are many possibilities:
            # 1. if there are both ice on and ice off doy
            if (not np.isnan(iceofy)) and (not np.isnan(iceony)):
                # iceduy = (iceofy - 1) + (ndaysthisyear - iceony + 1)
                iceduy = iceofy + ndaysthisyear - iceony
            # 2. if ice covered whole year
            elif np.isnan(iceofy) and np.isnan(iceony) and icend[yi] > 0:
                iceduy = ndaysthisyear
            # 3. if never ice covered this year
            elif np.isnan(iceofy) and np.isnan(iceony) and icend[yi] == 0:
                iceduy = 0
            # 4. open -> covered
            elif np.isnan(iceofy) and (not np.isnan(iceony)):
                iceduy = ndaysthisyear - iceony + 1
            # 5. covered -> open
            elif (not np.isnan(iceofy)) and np.isnan(iceony):
                iceduy = iceofy
            # starting iceth
            covered = h[(h.index.year == thisy) &
                        ((h.index.dayofyear < iceofy) | 
                         (h.index.dayofyear > (iceony - 1)))].iloc[:, 6] == 1
            if icend[yi] == 0:
                icethy = np.nan
            else: 
                icethy = 0 # initial value
                prev = True
                for ice in covered:
                    if prev and ice:
                        pass
                    elif (not prev) and (not ice):
                        pass
                    elif prev and (not ice):
                        icethy += 1
                        prev = False
                    elif (not prev) and ice:
                        prev = True
            icedu[yi, 0] = iceduy
            iceon[yi, 0] = iceony
            iceof[yi, 0] = iceofy
            iceth[yi, 0] = icethy

        ## Frode's variables
        ## reference fr15t.loc[month]
        ## target t.reample('M').iloc[13, :]
        fr15tall = np.nan * fr15troriginal
        fr15tall.index = t.resample('M').index
        for monthi in range(fr15tall.shape[0]):
            m = fr15tall.index.month[monthi]
            yt = fr15tr.loc[m]
            if np.any(np.isnan(yt)):
                continue
            if yt < 3.98:
                continue
            y = t.resample('M').iloc[monthi, :]
            x = np.arange(t0.shape[1]) + 0.5
            if np.all((y - yt) > 0):
                continue
            if np.all((y - yt) < 0):
                fr15tall[monthi] = 0
                continue
            a = max(x[((y - yt) > 0).values])
            b = min(x[((y - yt) < 0).values])
            f = scipy.interpolate.interp1d(x, y - yt)
            fr15tall[monthi] = scipy.optimize.bisect(f, a, b, xtol=0.001)
        # tttt = fr15tall.groupby(fr15tall.index.month).mean()
        # print(tttt[tttt.notnull()])
        fr15t = fr15tall.values.reshape((10, 12))

        fr05tall = np.nan * fr05troriginal
        fr05tall.index = t.resample('M').index
        for monthi in range(fr05tall.shape[0]):
            m = fr05tall.index.month[monthi]
            yt = fr05tr.loc[m]
            if np.any(np.isnan(yt)):
                continue
            if yt < 3.98:
                continue
            y = t.resample('M').iloc[monthi, :]
            x = np.arange(t0.shape[1]) + 0.5
            if np.all((y - yt) > 0):
                continue
            if np.all((y - yt) < 0):
                fr05tall[monthi] = 0
                continue
            a = max(x[((y - yt) > 0).values])
            b = min(x[((y - yt) < 0).values])
            f = scipy.interpolate.interp1d(x, y - yt)
            fr05tall[monthi] = scipy.optimize.bisect(f, a, b, xtol=0.001)
        # tttt = fr05tall.groupby(fr05tall.index.month).mean()
        # print(tttt[tttt.notnull()])       
        fr05t = fr05tall.values.reshape((10, 12))

        icesnowatt = np.exp(-5 * h.iloc[:, 0]) * np.exp(-15 * h.iloc[:, 1])
        icesnowatt.iloc[np.logical_not(h.iloc[:, 6] == 1).values] = 1
        incomingsw = q.iloc[:, 0] * icesnowatt * 0.45
        incomingsw.index = period
        fr15pall = np.nan * fr05troriginal        
        fr15pall.index = t.resample('M').index
        fr05pall = np.nan * fr05troriginal
        fr05pall.index = t.resample('M').index
        for monthi in range(fr05tall.shape[0]):
            m = fr05tall.index.month[monthi]
            year = fr05tall.index.year[monthi]
            refsw15 = fr15pr.loc[m]
            refsw05 = fr05pr.loc[m]
            sub = incomingsw[(incomingsw.index.year == year) & 
                             (incomingsw.index.month == m)]
            fr15pall[monthi] = np.mean(-1 * np.log(np.exp(refsw15) / sub))
            fr05pall[monthi] = np.mean(-1 * np.log(np.exp(refsw05) / sub))
        fr15p = fr15pall.values.reshape((10, 12))
        fr05p = fr05pall.values.reshape((10, 12))
        fr15p[np.isinf(fr15p)] = np.nan
        fr15p[fr15p > t.shape[1]] = np.nan
        fr05p[np.isinf(fr05p)] = np.nan
        fr05p[fr15p > t.shape[1]] = np.nan

        # form into shape
        a = np.concatenate((tsw00, tsw, pcd00, pcd, pcn00, pcn, 
                            icend, icemh, icedu, iceon, iceof, iceth, 
                            fr15t, fr05t, fr15p, fr05p), axis=1)
        dim0 = 10
        # dim0 = 10 + 4
        # dim1 = a.shape[1]
        # a100 = a.mean(axis=0).reshape((1, dim1))
        # a101 = np.median(a, axis=0).reshape((1, dim1))
        # a102 = a.min(axis=0).reshape((1, dim1))
        # a103 = a.max(axis=0).reshape((1, dim1))
        # y = np.array(range(10) + [100, 101, 102, 103]).reshape((dim0, 1))
        # b = np.concatenate((a, a100, a101, a102, a103), axis=0)
        y = np.array(np.arange(10).reshape((dim0, 1)))
        b = a
        c = np.concatenate((np.array([[sim]]).repeat(dim0, axis=0), y, b), 
                           axis=1)
        if first_time:
            result = c
            first_time = False
        else:
            result = np.concatenate((result, c), axis=0)


cols = ['sim_id', 'y',
        'tws00', 'tws01', 'tws02', 'tws03', 'tws04', 'tws05', 'tws06', 
        'tws07', 'tws08', 'tws09', 'tws10', 'tws11', 'tws12',  
        'pcd00', 'pcd01', 'pcd02', 'pcd03', 'pcd04', 'pcd05', 'pcd06',  
        'pcd07', 'pcd08', 'pcd09', 'pcd10', 'pcd11', 'pcd12',  
        'pcn00', 'pcn01', 'pcn02', 'pcn03', 'pcn04', 'pcn05', 'pcn06',  
        'pcn07', 'pcn08', 'pcn09', 'pcn10', 'pcn11', 'pcn12',
        'icend', 'icemh', 'icedu', 'iceon', 'iceof', 'iceth', 
        'f15t01', 'f15t02', 'f15t03', 'f15t04', 'f15t05', 'f15t06', 
        'f15t07', 'f15t08', 'f15t09', 'f15t10', 'f15t11', 'f15t12', 
        'f05t01', 'f05t02', 'f05t03', 'f05t04', 'f05t05', 'f05t06', 
        'f05t07', 'f05t08', 'f05t09', 'f05t10', 'f05t11', 'f05t12', 
        'f15p01', 'f15p02', 'f15p03', 'f15p04', 'f15p05', 'f15p06', 
        'f15p07', 'f15p08', 'f15p09', 'f15p10', 'f15p11', 'f15p12', 
        'f05p01', 'f05p02', 'f05p03', 'f05p04', 'f05p05', 'f05p06', 
        'f05p07', 'f05p08', 'f05p09', 'f05p10', 'f05p11', 'f05p12']

result = pd.DataFrame(result, columns=cols)
                                        
## still need to do something with the iceon after 31st December

## comsat
# In [63]: result22 = result
# In [64]: result22['ebint'] = result.sim_id - 440000000
# In [65]: agg = result22.groupby('sim_id').mean()
# In [66]: agg.to_csv('comsat_DMI_mean-2001-2010.csv')
# In [67]: m = agg.merge(comsat)

result.to_sql(name='sim2', con=engine, schema='mylake',
              if_exists='append', index=False)


