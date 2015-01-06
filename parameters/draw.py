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
eblist = read_sql('select eb_int from lakes group by eb_int', conn)
providers = read_sql('select * from providers', conn)

if not os.path.exists('pdf'): os.makedirs('pdf')

for i, r in eblist.iterrows():
    eb = r[0]
    c = conn.execute('''select provider_id, station_id, date, depth, temperature 
from temperature where eb_int = ?''', (eb, ))
    t0 = pd.DataFrame(c.fetchall(), 
                      columns=['provider_id', 'station_id', 'date', 
                               'depth', 'temperature'])
    t = t0.set_index('date')
    t.index = t.index.to_datetime()
    c = conn.execute('''select provider_id, station_id from temperature where 
eb_int = ? group by provider_id, station_id ''', (eb, ))
    pslist = c.fetchall()
    for p, s in pslist:
        the_lake = lakes[(lakes['eb_int'] == eb) &
                         (lakes['provider_id'] == p) & 
                         (lakes['station_id'] == s)]
        c = conn.execute('''select n_depths, n_dates from lakes where
eb_int = ? and provider_id = ? and station_id = ?''', (eb, p, s))
        n_depths, n_dates = c.fetchall()[0]
        p_name = providers[providers['provider_id'] == p]['provider_name'].values[0]
        if n_depths < 15:
          pal = 'Spectral' if n_depths > 3 else 'gist_stern_r'
          with sns.color_palette(pal, n_depths):
            c = conn.execute('''select depth from temperature where
eb_int = ? and provider_id = ? and station_id = ? group by depth order by depth''', 
                             (eb, p, s))
            depths = [e[0] for e in c.fetchall()]
            depths.sort()
            sub = t[(t['provider_id'] == p) & (t['station_id'] == s)]
            plt.cla()
            fig = plt.figure()
            ax = fig.add_subplot(1, 1, 1)
            for depth in depths:
                subd = sub[(sub['depth'] == depth) & 
                           np.logical_not(np.isnan(sub['temperature']))]
                print(subd)
                print('')
                ax.plot(subd.index, subd['temperature'], marker='.',
                        label='%s m' % depth, 
                        markeredgewidth=0, linewidth=0, 
                        markersize=5) # alpha=0.8)
            ax.set_title('%s (%s)' % (the_lake['name'].values[0], p_name))
            ax.set_xlabel('date')
            ax.set_ylabel('temperature')
            ax.legend(loc=0, ncol=2, fontsize='x-small', frameon=True)
            sns.despine()
            fig.savefig(os.path.join('pdf', '%s-%s-%s.pdf' % (
                the_lake['name'].values[0], p, s)))
        else: # if n_depths > 15
          with sns.color_palette('husl', n_dates):
            c = conn.execute('''select date from temperature where
eb_int = ? and provider_id = ? and station_id = ? group by date order by date''', 
                             (eb, p, s))
            dates = [e[0] for e in c.fetchall()]
            dates.sort()
            sub = t[(t['provider_id'] == p) & (t['station_id'] == s)]
            plt.cla()
            fig = plt.figure()
            ax = fig.add_subplot(1, 1, 1)
            ax.invert_yaxis()
            for the_date in dates:
                subd = sub[(sub.index == the_date) &
                           np.logical_not(np.isnan(sub['temperature']))]
                print(subd)
                print('')
                ax.plot(subd['temperature'], subd['depth'], marker='.',
                        label=the_date, 
                        markeredgewidth=0, linewidth=0, 
                        markersize=5) 
            ax.set_title('%s (%s)' % (the_lake['name'].values[0], p_name))
            ax.set_xlabel('temperature')
            ax.set_ylabel('depth')
            ax.legend(loc=0, ncol=2, fontsize='x-small', frameon=True)
            sns.despine()
            fig.savefig(os.path.join('pdf', '%s-%s-%s.pdf' % (
                the_lake['name'].values[0], p, s)))
                

