import pandas as pd

d0 = pd.read_table('test20151110a.csv.gz', sep=',')

d = d0[['sim_id', 'y', 'category']]

g = d.groupby('sim_id')

# for each sim_id find the most frequent category
freq = g['category'].agg(lambda x: x.value_counts().idxmax())

mm = (freq.index.values.astype(int) // 2e7).astype(int)
ebint = (freq.index.values.astype(int) - mm * 2e7).astype(int)
d1 = pd.DataFrame({'mm': mm, 'ebint': ebint, 'category': freq.values})
d2 = d1.pivot(index='ebint', columns='mm', values='category')
d2['sequence'] = pd.Series(d2[22] * 1e3 + d2[26] * 1e2 + d2[27] * 10 + d2[28], 
                           index=d2.index)
d2 = d2.astype(int)
d2.index = pd.Int64Index(d2.index)
d2.to_csv('category_sequence.csv')
d3 = d2['sequence'].value_counts().sort_index()
d3.to_csv('category_sequence_frequency.csv')
d2['sequence2'] = pd.Series(d2[22] * 10 + d2[28], index=d2.index)
d4 = d2['sequence2'].value_counts().sort_index()
d4.to_csv('category_sequence_frequency2.csv')
