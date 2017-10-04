import matplotlib.pyplot as plt
import seaborn as sns

d = pd.DataFrame.from_csv('test20151117_ice_meadian_9_winters.csv')

# check if any lake gets no-ice cover in one winter during 2091-2100

# ebint group 
eg = d.groupby('ebint') # all four scenarios, i.e., 4 scenarios (based on 36 witers)
egmax = eg.num_winter_without_ice.max()
onceopened = egmax[egmax > 0].index.values

# check which lakes are still freezing in 2091-2100 and have open water in 2001-2010 and throughout
d1 = d[np.in1d(d.ebint, onceopened)]
g1 = d1.groupby('y1')

# count of lakes that are at least open once in the 9-winter period
m2 = (d1[d1.num_winter_without_ice > 0]).groupby('y1').count().iloc[:, 0]


sns.set_style('white')

plt.cla()
plt.clf()
fig2 = plt.figure(2)
ax2a = fig2.add_subplot(111)

ax2a.plot(np.array([2010, 2040, 2070, 2100]) - 5, 
          (9 - g1.mean().num_winter_without_ice) / 9.0 * 100, 
          color='blue', marker='.', markersize=18)
for i in range(4):
    ax2a.text((np.array([2010, 2040, 2070, 2100]) - 5)[i], 
              ((9 - g1.mean().num_winter_without_ice).values / 9.0 * 100)[i] - 4, 
              '%.1f %%' % ((9 - g1.mean().num_winter_without_ice).values / 9.0 * 100)[i], 
              color='blue', size=10, 
              verticalalignment='top', 
              horizontalalignment='center')

ax2a.set_ylabel('proportion of winters with ice-cover', color='blue', size=12)
ax2a.set_xlabel('year', size=12)
ax2a.set_ylim(0, 100)
ax2a.set_xlim(2000, 2100)
for tl in ax2a.get_yticklabels():
    tl.set_color('blue')

ax2a.set_title('Only concerning lakes that opens at least once (n = %s)' % m2.max())

ax2 = ax2a.twinx()

m2.index = m2.index - 5
m2.plot(ax=ax2, color='red', marker='.', markersize=18)

ax2.set_ylabel('number of lakes that are open winter\nat least once in 9 winters', color='red', size=12)
ax2.set_xlabel('year', size=12)
ax2.set_xlim(2000, 2100)
for tl in ax2.get_yticklabels():
    tl.set_color('red')



fig2.set_figheight(5)
fig2.set_figwidth(7)
fig2.savefig('melting lakes.pdf', bbox_inches='tight', pad_inches=0.3)

# plt.show()


