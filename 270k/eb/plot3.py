import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

d = pd.DataFrame.from_csv('test20151110a.csv.gz')

# import os
# import numpy as np
# import pandas as pd
# import pg8000
# from sqlalchemy import create_engine
# import datetime
# import scipy.optimize
# import scipy.interpolate

# engine = create_engine('postgresql+pg8000://koji:koji@vm-srv-finstad.vm.ntnu.no/ecco_biwa_db')
# s = '''select 
#        min(mm.ya0) as y0, 
#        min(mm.yb1) as y1, 
#        min(mm.rcma) as rcm, 
#        min(categories.cat_longname) as category,
#        min(categories.cat_id) as cat_id, 
#        count(t1.cat_id) as frequency
# from 
#      (select floor(sim_id / 2e7) as mm, 
#      	     -- sim_id %% 2e7 as ebint, 
# 	     category as cat_id 
#      from mylake.sim3) t1, 
#      mylake.mm, 
#      mylake.categories
# where 
# mm.mm = t1.mm and t1.cat_id = categories.cat_id
# group by mm.mm, t1.cat_id
# order by mm.mm, t1.cat_id'''

# d = pd.read_sql(s, engine)
# d.to_csv('categories_frequencies.csv')

d = pd.read_csv('categories_frequencies.csv', index_col=0)

# catids = list(set(d.cat_id))

d2 = d.iloc[:7, 2:5]

for y in [2010, 2040, 2070, 2100]:
    d2['freq%s' % y] = d[d.y1 == y].frequency.values


