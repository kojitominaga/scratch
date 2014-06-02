import numpy as np
import scipy as sp
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
from matplotlib.backends.backend_pdf import PdfPages
import datetime
import os
import pandas as pd
import seaborn as sns
sns.set_style('whitegrid')

def runningmean(x, N):
    return np.convolve(x, np.ones((N,))/N)[(N-1):]

def eurodate2datetime(x):
    d, m, y = [int(e) for e in x.strip().split('.')]
    return datetime.date(y, m, d)

def missingorzero(x):
    xs = x.strip()
    if xs == '.': 
        out = 0.0
    elif xs == 'NA': 
        out = np.nan
    else:
        out = float(xs)
    return(out)

stationraw = \
  np.genfromtxt('Dognverdier_(for_dognintervall).txt', 
                dtype = 'i4,<M8[D],f8,f8,f8,f8,f8,f8,f8,f8', 
                converters = {1: eurodate2datetime, 
                              2: missingorzero, 
                              3: missingorzero, 
                              4: missingorzero, 
                              5: missingorzero, 
                              6: missingorzero, 
                              7: missingorzero, 
                              8: missingorzero, 
                              9: missingorzero},
                skip_header = 34, 
                skip_footer = 20106,
                names = ('St.no', 'Date', 'FFM', 'NNM', 'POM',
                         'PRM', 'RR', 'SH', 'TAM', 'UUM'))   

years = np.array([int(a.astype('S').split('-')[0]) for a in stationraw['Date']])
                              
station = stationraw[years >= 1993, :]

sdf = pd.DataFrame.from_records(station, \
    index = pd.date_range('1993-01-01', '2012-12-31', freq = 'D'))

ta = np.genfromtxt('NORA10_old/NORA10_1H_11km_ta_2m_1993-2012_mean24_' + 
                   'OsloBlindern_interpolated_cutoff_100_nlocal_50.txt.gz', 
                   dtype = 'f8', names = True)
hur = np.genfromtxt('NORA10_old/NORA10_1H_11km_hur_2m_1993-2012_mean24_' + 
                   'OsloBlindern_interpolated_cutoff_100_nlocal_50.txt.gz', 
                   dtype = 'f8', names = True)
wss = np.genfromtxt('NORA10_old/NORA10_1H_11km_wss_10m_1993-2012_mean24_' + 
                   'OsloBlindern_interpolated_cutoff_100_nlocal_50.txt.gz', 
                   dtype = 'f8', names = True)
clt = np.genfromtxt('NORA10_old/NORA10_1H_11km_clt_1993-2012_mean24_' + 
                   'OsloBlindern_interpolated_cutoff_100_nlocal_50.txt.gz', 
                   dtype = 'f8', names = True)
pr = np.genfromtxt('NORA10_old/NORA10_1H_11km_pr_1993-2012_mean24_' + 
                   'OsloBlindern_interpolated_cutoff_100_nlocal_50.txt.gz', 
                   dtype = 'f8', names = True)
ps = np.genfromtxt('NORA10_old/NORA10_3H_11km_ps_1993-2012_mean8_' + 
                   'OsloBlindern_interpolated_cutoff_100_nlocal_50.txt.gz', 
                   dtype = 'f8', names = True)


stationdf = pd.DataFrame.from_records(station, 
    index = pd.date_range('1993-01-01', '2012-12-31', freq = 'D'))

tasklist = [(ta, 'TAM', 'air temperature (degree C)'), 
            (pr, 'RR', 'precipitation (mm)'), 
            (clt, 'NNM', 'cloud cover (octas)'), 
            (hur, 'UUM', 'relative humidity (percent)'), 
            (wss, 'FFM', 'wind speed (m s-1)'), 
            (ps, 'POM', 'atm. pres. at station level (hPa)')]

for data, name, long_name in tasklist:

    df = pd.DataFrame.from_records(data, 
        index = pd.date_range('1993-01-01', '2012-12-31', freq = 'D'))

    stationv = pd.DataFrame(data = {'station': stationdf[name]}, 
        index = pd.date_range('1993-01-01', '2012-12-31', freq = 'D'))
                        

    df = pd.concat([df, stationv], axis = 1)

    interps = list(df.columns[:9])
    # ['i1a', 'i1b', 'i1c', 'i3an', 'i3ao', 'i3bn', 'i3bo', 'i3cn', 'i3co']

    modified = dict()

    for interpi in range(9):
        interp = interps[interpi]

        n_outliers = 0
        n_llimit = 0
        n_ulimit = 0
    
        #### data manipulation 
        if name == 'TAM':
            df[interp] = df[interp] - 273.15
            is_outlier = sp.stats.mstats.zscore(df[interp]).abs() > 5
            # change if not air temperature, for example to limits (0 to 100)
        if name == 'RR':
            df[interp] = df[interp] * (60 * 60 * 24)
            is_llimit = df[interp] < 0
            n_llimit = is_llimit.sum()
            df.ix[is_llimit, interp] = 0
        if name == 'NNM':
            df[interp] = df[interp] * 8
            is_llimit = df[interp] < 0
            n_llimit = is_llimit.sum()
            df.ix[is_llimit, interp] = 0
            is_ulimit = df[interp] > 8
            n_ulimit = is_ulimit.sum()
            df.ix[is_ulimit, interp] = 8
        if name == 'UUM':
            is_llimit = df[interp] < 0
            n_llimit = is_llimit.sum()
            df.ix[is_llimit, interp] = 0
            is_ulimit = df[interp] > 100
            n_ulimit = is_ulimit.sum()
            df.ix[is_ulimit, interp] = 100
        if name == 'FFM':
            is_llimit = df[interp] < 0
            n_llimit = is_llimit.sum()
            df.ix[is_llimit, interp] = 0
        if name == 'POM':
            df[interp] = df[interp] * 0.01
            
            
        mm = df[interp].values
        ## during interpolation, work with np.ndarray, not pd.DataFrame
        mm[is_outlier] = np.nan
        x = np.arange(mm.size)
        n_outliers = is_outlier.sum()
        is_not_outlier = np.logical_not(is_outlier)
        f = sp.interpolate.interp1d(x[is_not_outlier], mm[is_not_outlier])
        df.ix[is_outlier, interp] = f(x[is_outlier])

        modified[interp] = (n_outliers, n_llimit, n_ulimit)

        bias = 'b' + interp[1:]
        df[bias] = df[interp] - df['station'] # bias
        var_exists = interp in ['i3ao', 'i3bn', 'i3bo', 'i3cn', 'i3co']
        if var_exists:
            var = 'var' + interp[1:]
            interpupper = 'iu' + interp[1:]
            interplower = 'il' + interp[1:]
            biasupper = 'bu' + interp[1:]
            biaslower = 'bl' + interp[1:]
            df[interpupper] = df[interp] + 2 * np.sqrt(df[var])
            df[interplower] = df[interp] - 2 * np.sqrt(df[var])
            df[biasupper] = df[bias] + 2 * np.sqrt(df[var])
            df[biaslower] = df[bias] - 2 * np.sqrt(df[var])
            
        m_min = df.values[:, :9].min()
        m_max = df.values[:, :9].max()
        m_limit = [m_min, m_max]
        b_reach = np.abs(df.ix[:, \
        [e for e in df.columns if e[0] == 'b'  
         and (not 'u' in e) and (not 'l' in e)]]).max().max()
        b_limit = [-1.0 * b_reach, b_reach]

    for interpi in range(9):
        interp = interps[interpi]
        
        #### figure
        fig = plt.figure(figsize = (11, 7))
        gs = gridspec.GridSpec(4, 4, width_ratios = [1, 3, 3, 1], 
                               hspace = 0.5)
        bias = 'b' + interp[1:]

        var_exists = interp in ['i3ao', 'i3bn', 'i3bo', 'i3cn', 'i3co']

        if var_exists:
            var = 'var' + interp[1:]
            interpupper = 'iu' + interp[1:]
            interplower = 'il' + interp[1:]
            biasupper = 'bu' + interp[1:]
            biaslower = 'bl' + interp[1:]
            df[interpupper] = df[interp] + 2 * np.sqrt(df[var])
            df[interplower] = df[interp] - 2 * np.sqrt(df[var])
            df[biasupper] = df[bias] + 2 * np.sqrt(df[var])
            df[biaslower] = df[bias] - 2 * np.sqrt(df[var])
    
        m = df[interp]
        m2y = df.ix[:730, interp]
        m5rm = pd.DataFrame(data = {'m5rm': runningmean(m, 5)}, index = m.index)['m5rm']
        m5rm2y = m5rm[:730]
        mM = m.resample('M', how = 'mean')
        mA = m.resample('A', how = 'mean')

        o = df['station']
        o2y = o[:730]
        o5rm = pd.DataFrame(data = {'o5rm': runningmean(o, 5)}, index = m.index)['o5rm']
        o5rm2y = o5rm[:730]
        oM = o.resample('M', how = 'mean')
        oA = o.resample('A', how = 'mean')
        
        b = df[bias]
        b2y = b[:730]
        b5rm = pd.DataFrame(data = {'b5rm': runningmean(b, 5)}, index = m.index)['b5rm']
        b5rm2y = b5rm[:730]
        bM = b.resample('M', how = 'mean')
        bA = b.resample('A', how = 'mean')

        if var_exists:
        
            bu = df[biasupper]
            bu2y = bu[:730]
            bu5rm = pd.DataFrame(data = {'bu5rm': runningmean(bu, 5)}, index = m.index)['bu5rm']
            bu5rm2y = bu5rm[:730]
            buM = bu.resample('M', how = 'mean')
            buA = bu.resample('A', how = 'mean')
        
            bl = df[biaslower]
            bl2y = bl[:730]
            bl5rm = pd.DataFrame(data = {'bl5rm': runningmean(b, 5)}, index = m.index)['bl5rm']
            bl5rm2y = bl5rm[:730]
            blM = bl.resample('M', how = 'mean')
            blA = bl.resample('A', how = 'mean')
            
        ax00, ax01, ax02, ax03, ax10, ax11, ax12, ax13, \
          ax20, ax21, ax22, ax23, ax30, ax31, ax32, ax33 \
          = [plt.subplot(g) for g in list(gs)]
    
        ax00.plot(o, m, '.', alpha = 0.2)
        m2y.plot(ax = ax01)
        if var_exists:
            b2y.plot(ax = ax02, color = 'white', alpha = 0.02)
            ax02.fill_between(bu2y.index, bu2y, bl2y)
        else:
            b2y.plot(ax = ax02)
        ax03.plot(o, b, '.', alpha = 0.2)

        ax10.plot(o5rm, m5rm, '.', alpha = 0.2)
        m5rm2y.plot(ax = ax11)
        if var_exists:
            b5rm2y.plot(ax = ax12, color = 'white', alpha = 0.02)
            ax12.fill_between(bu5rm2y.index, bu5rm2y, bl5rm2y)
        else:
            b5rm2y.plot(ax = ax12)
        ax13.plot(o5rm, m5rm - o5rm, '.', alpha = 0.2)
    
        ax20.plot(oM, mM, '.', alpha = 0.3)
        mM[:60].plot(ax = ax21, label = interp)
        oM[:60].plot(ax = ax21, label = 'obs.')
        ax21.legend(loc = 0)
        if var_exists:
            bM[:60].plot(ax = ax22, color = 'white', alpha = 0.02)
            ax22.fill_between(buM.index[:60], buM[:60], blM[:60])
        else:
            bM[:60].plot(ax = ax22)
        ax23.plot(oM, bM, '.', alpha = 0.3)
    
        ax30.plot(oA, mA, '.')
        mA.plot(ax = ax31, label = interp)
        oA.plot(ax = ax31, label = 'obs.')
        ax31.legend(loc = 0)
        if var_exists:
            bA.plot(ax = ax32, color = 'white', alpha = 0.02)
            ax32.fill_between(buA.index, buA, blA)
        else:
            bA.plot(ax = ax32)
        ax33.plot(oA, bA, '.')
        
        for ax in [ax00, ax10, ax20      ]:
            ax.plot(m_limit, m_limit, 'k-')
        for ax in [ax03, ax13, ax23      ]:
            ax.plot(m_limit, [0, 0], 'k-')
        for ax in [ax00, ax03, ax10, ax13, ax20, ax23, ax30      ]:
            ax.set_xlim(m_limit)
            ax.set_xlabel('observation')
        for ax in [ax00, ax01, ax10, ax11, ax20, ax21, ax30      ]:
            ax.set_ylim(m_limit)
            ax.set_ylabel(interp)
        for ax in [ax02, ax03, ax12, ax13, ax22, ax23, ax32, ax33]:
            ax.set_ylim(b_limit)
            ax.set_ylabel('bias')
        for ax in [ax00, ax01, ax02, ax03, ax10, ax11, \
                   ax12, ax13, ax20, ax21, ax22, ax23]:
            ax.set_xlabel('')
        for ax in [ax01, ax02, ax03, ax11, ax12, ax13, \
                   ax21, ax22, ax23, ax31, ax32, ax33]:
            ax.set_ylabel('')
        m_limit_a = [min(mA.min(), oA.min()), max(mA.max(), oA.max())]
        ax33.set_xlim(m_limit_a)
        ax30.set_xlim(m_limit_a)
        ax30.set_ylim(m_limit_a)
        ax30.plot(m_limit_a, m_limit_a, 'k-')
        ax33.plot(m_limit_a, [0, 0], 'k-')
        ax00.set_ylabel(interp)
        ax10.set_ylabel('5-day running mean')
        ax20.set_ylabel('monthly mean')
        ax30.set_ylabel('annual mean')
        ax30.set_xlabel('observation')
        ax31.set_xlabel('value')
        if var_exists:
            ax32.set_xlabel('bias +/- 2*SE')
        else:
            ax32.set_xlabel('bias')
        ax33.set_xlabel('bias vs obs.')
        plt.suptitle('%s %s NORA10 at Blindern 1993-2012\nmean bias (%.1f) RMSE (%.1f) monthly mean RMSE (%.1f) outlier count (%i)' % (
            long_name,
            interp, 
            m.mean() - o.mean(), 
            (((m - o) ** 2).sum() / m.size) ** 0.5, 
            (((mM - oM) ** 2).sum() / mM.size) ** 0.5, 
            np.sum(modified[interp])
            ))
        fig.savefig('png/%s %s.png' % (long_name, interp), 
                    orientation = 'landscape', 
                    papertype = 'a4', dpi = 300)
        



