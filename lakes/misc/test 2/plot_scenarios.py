import os
import datetime
import gzip
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

sns.set_style('whitegrid')

bins = np.arange(0, 24, 0.25)

dirs = [d for d in os.listdir('.') if 'EUR-11' in d]
dirs.sort()
pal = sns.color_palette("PuBuGn_d", n_colors=5)
paldict = {'1971': pal[0], 
           '2001': pal[1], 
           '2031': pal[2], 
           '2061': pal[3], 
           '2091': pal[4]} 



fig = plt.figure()
ax = fig.add_subplot(111)
fig2 = plt.figure()
ax_dummy = fig2.add_subplot(111)
for d in dirs:
    date0, date1 = d.split('_')[-1].split('-')
    modelname = d.split('_')[4]
    label = '%s %s-%s' % (modelname, date0[:4], date1[:4])
    y0 = int(date0[:4])
    with gzip.open(os.path.join(d, 'Tzt.csv.gz')) as f:
        df = pd.DataFrame.from_csv(f, index_col=None, header=None)
    ndays = (datetime.date(y0 + 9, 12, 31) - datetime.date(y0, 1, 1)).days + 1
    dates = [datetime.date(y0, 1, 1) + datetime.timedelta(i) 
             for i in range(ndays)]
    df.index = pd.DatetimeIndex(dates)
    august = df[df.index.month == 8]
    surf = august.ix[:, 0]
    freq, b, patches = ax_dummy.hist(surf, bins=bins, cumulative=True)
    ax.plot((bins[1:] + bins[:-1]) / 2, freq, label=label, 
            linestyle = '-' if 'DMI' in modelname else '--', 
            color = paldict[date0[:4]])
ax.legend(loc=0)
ax.set_xlabel('August temperature C')
ax.set_ylabel('Cumulative frequency (n = 31 * 10)')
ax.set_title('An arbitrarily chosen lake')
fig.savefig('test.pdf')
    
    


