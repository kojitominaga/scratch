import pandas as pd
import pg8000
from sqlalchemy import create_engine
import matplotlib.pyplot as plt
import seaborn as sns

engine = create_engine('postgresql+pg8000://user:password@vm-srv-finstad.vm.ntnu.no/ecco_biwa_db')

c30sql = '''
select        
       mm.ya0 as y0, 
       mm.yb1 as y1, 
       mm.rcma as rcm, 
       t1.ebint, 
       lakes.clust30a as c30,
       t1.julytemp
from 
     (select floor(sim_id / 2e7) as mm, 
     sim_id %% 2e7 as ebint, 
     avg(tws07) as JulyTemp 
     from sim 
     group by sim_id) t1, 
     mm, 
     ecco_biwa_lakes_v_0_1 lakes
where mm.mm = t1.mm and lakes.ebint = t1.ebint
order by ebint, mm.mm
'''

c30 = pd.read_sql(c30sql, engine)
c30 = c30[c30 > 0]
c30['c30'] = c30['c30'].astype(int).astype(str)

plt.clf()
sns.set_style('ticks')
ax = sns.boxplot(y='julytemp', x='c30', data=c30[c30.c30 < 16], hue='y1', order=range(1, 16), fliersize=2)
sns.despine(offset=10, trim=True)
plt.savefig('cluster01-15.pdf')

plt.clf()
sns.set_style('ticks')
ax = sns.boxplot(y='julytemp', x='c30', data=c30[c30.c30 > 15], hue='y1', order=range(16, 31), fliersize=2)
sns.despine(offset=10, trim=True)
plt.savefig('cluster16-30.pdf')





