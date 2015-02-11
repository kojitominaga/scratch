import sqlite3
import os
import numpy as np
import pandas as pd
from pandas.io.sql import read_sql 
import datetime
import matplotlib.pyplot as plt
import seaborn as sns

sns.set_style('whitegrid')

conn = sqlite3.connect(os.path.join('data', 'processed', 
                                    'laketemp_working.sqlite'))

lakes = read_sql('select * from lakes', conn)
eblist = read_sql('''SELECT eb_int, station_id 
from lakes 
where provider_id = 6 
and n_depths > 20 
and (select max(n_years_summer) from lakes) > 15 
group by eb_int 
''', conn)
providers = read_sql('select * from providers', conn)

if not os.path.exists('pdfNVE'): os.makedirs('pdfNVE')
if not os.path.exists('xlsxNVE'): os.makedirs('xlsxNVE')

for i, r in eblist.iterrows():
    eb, sid = r
    c = conn.execute('''select provider_id, station_id, date, depth, temperature 
    from temperature where eb_int = ? and station_id = ? and provider_id = 6''', (eb, sid))
    t0 = pd.DataFrame(c.fetchall(), 
                      columns=['provider_id', 'station_id', 'date', 
                               'depth', 'temperature'])
    t = t0.set_index('date')
    t.index = t.index.to_datetime()
    c = conn.execute('''select provider_id, station_id from temperature where 
eb_int = ? and provider_id = 6 group by provider_id, station_id ''', (eb, ))
    pslist = c.fetchall()
    for p, s in pslist:
      the_lake = lakes[(lakes['eb_int'] == eb) &
                         (lakes['provider_id'] == p) & 
                         (lakes['station_id'] == s)]
      c = conn.execute('''select n_depths, n_dates, n_years_summer from lakes where
eb_int = ? and provider_id = ? and station_id = ? and n_years_summer > 14''', (eb, p, s))
      cfetchall = c.fetchall()
      if len(cfetchall) == 0:
          continue
      else:
        n_depths, n_dates, n_years_summer = cfetchall[0]
        p_name = providers[providers['provider_id'] == p]['provider_name'].values[0]
        if n_depths < 15:
            pass
#           pal = 'Spectral' if n_depths > 3 else 'gist_stern_r'
#           with sns.color_palette(pal, n_depths):
#             c = conn.execute('''select depth from temperature where
# eb_int = ? and provider_id = ? and station_id = ? group by depth order by depth''', 
#                              (eb, p, s))
#             depths = [e[0] for e in c.fetchall()]
#             depths.sort()
#             sub = t[(t['provider_id'] == p) & (t['station_id'] == s)]
#             plt.cla()
#             fig = plt.figure()
#             ax = fig.add_subplot(1, 1, 1)
#             for depth in depths:
#                 subd = sub[(sub['depth'] == depth) & 
#                            np.logical_not(np.isnan(sub['temperature']))]
#                 print(subd)
#                 print('')
#                 ax.plot(subd.index, subd['temperature'], marker='.',
#                         label='%s m' % depth, 
#                         markeredgewidth=0, linewidth=0, 
#                         markersize=5) # alpha=0.8)
#             ax.set_title('%s (%s)' % (the_lake['name'].values[0], p_name))
#             ax.set_xlabel('date')
#             ax.set_ylabel('temperature')
#             ax.legend(loc=0, ncol=2, fontsize='x-small', frameon=True)
#             sns.despine()
#             fig.savefig(os.path.join('pdf', '%s-%s-%s.pdf' % (
#                 the_lake['name'].values[0], p, s)))
        else: # if n_depths > 15
          with sns.color_palette('husl', 8):
          # with sns.color_palette('husl', n_years_summer):
            c = conn.execute('''select date from temperature where
eb_int = ? and provider_id = ? and station_id = ? group by date order by date''', 
                             (eb, p, s))
            dates_str = [e[0] for e in c.fetchall()]
            dates_tup = [map(int, e.split('-')) for e in dates_str]
            dates_datetime = [datetime.date(year, month, day) 
                              for year, month, day in dates_tup]
            dates = [date for date in dates_datetime 
                     if date.month > 5 and date.month < 10]
            dates.sort()
            sub = t[(t['provider_id'] == p) & (t['station_id'] == s)]
            plt.cla()
            fig = plt.figure()
            ax = fig.add_subplot(1, 1, 1)
            ax.invert_yaxis()
            for i, the_date in enumerate(dates):
            # for the_date in dates:
                subd = sub[(sub.index == the_date.isoformat()) &
                           np.logical_not(np.isnan(sub['temperature']))]
                print(subd)
                print('')
                ax.plot(subd['temperature'], subd['depth'], marker='.',
                        label=the_date, 
                        linestyle=['-', '--', ':'][i // 8], 
                        markeredgewidth=0, linewidth=0.6, 
                        markersize=5) 
            ax.set_title('%s (%s%s years)' % (
                the_lake['name'].values[0], 
                # p_name, 
                ['', 'BATH '][the_lake['bath_NOSE'].values[0]], 
                the_lake['n_years_summer'].values[0]))
            ax.set_xlabel('temperature')
            ax.set_ylabel('depth')
            ax.set_xlim((0, 25))
            ax.legend(loc=4, ncol=3, fontsize='x-small', frameon=True)
            sns.despine()
            fig.savefig(os.path.join('pdfNVE', '%s %s years.pdf' % (
                the_lake['name'].values[0], 
                the_lake['n_years_summer'].values[0])))
            sub['date'] = sub.index.date
            sub.drop('station_id', 1, inplace=True)
            sub.drop('provider_id', 1, inplace=True)
            sub.reset_index(drop=True, inplace=True)
            sub.to_excel(os.path.join('xlsxNVE','%s %s years.xlsx' % (
                the_lake['name'].values[0], 
                the_lake['n_years_summer'].values[0])), 
                         'NVEdata', index=False)
                

