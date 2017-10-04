import pandas as pd
import pg8000
from sqlalchemy import create_engine
import matplotlib.pyplot as plt
import seaborn as sns

engine = create_engine('postgresql+pg8000://user:password@vm-srv-finstad.vm.ntnu.no/ecco_biwa_db')

julytempsql = '''
select        
       mm.ya0 as y0, 
       mm.yb1 as y1, 
       mm.rcma as rcm, 
       t1.ebint, 
       t1.JulyTemp
from 
     (select floor(sim_id / 2e7) as mm, 
     sim_id %% 2e7 as ebint, 
     avg(tws07) as JulyTemp 
     from sim 
     group by sim_id) t1, 
     mm   
where mm.mm = t1.mm 
order by ebint, mm.mm
'''

julytemp = pd.read_sql(julytempsql, engine)

plt.clf()
julytemp.boxplot(by='y1', column='julytemp')
plt.savefig('test.pdf')

sns.set_style('whitegrid')
plt.clf()
ax = sns.boxplot(x='y1', y='julytemp', data=julytemp, fliersize=1)
ax = sns.stripplot(x="y1", y="julytemp", data=julytemp,
                   size=0.2, jitter=True, edgecolor="gray")
ax.set_ylim([-0.1, 22])
ax.set_xlabel('year')
ax.set_ylabel('July Surface Water Temperature (C)')
sns.despine(offset=10, trim=True)
plt.savefig('test2.pdf')

plt.clf()
ax = sns.violinplot(x='y1', y='julytemp', data=julytemp, fliersize=1)
ax.set_xlabel('year')
ax.set_ylabel('July Surface Water Temperature (C)')
ax.plot(range(4), julytemp[['julytemp', 'y1']].groupby('y1').mean(), 'k-')
ax.plot(range(4), julytemp[['julytemp', 'y1']].groupby('y1').median(), 'k-')
plt.savefig('test3.pdf')
