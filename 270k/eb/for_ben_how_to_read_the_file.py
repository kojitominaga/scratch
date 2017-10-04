d = pd.read_csv('ten_lakes.csv')

for k, g in d.groupby(['y0', 'ebint']):
    print(k)
    # print(g.iloc[0, 4:].values.reshape((2, 10)))
    # chunk = g

