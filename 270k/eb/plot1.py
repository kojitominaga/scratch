import matplotlib.pyplot as plt
import seaborn as sns

d = pd.DataFrame.from_csv('test20151117_ice_meadian_9_winters.csv')

# check which lakes are still freezing in 2091-2100 and have open water in 2001-2010 and throughout

# ebint group 
eg = d.groupby('ebint') # all four scenarios, i.e., 4 scenarios (based on 36 witers)
egs = eg.sum()
stillfreezing = egs.num_winter_without_ice == 0
everyyearopen = egs.num_whole_year_ice == 0

iceid = egs[stillfreezing & everyyearopen].index.values

dice = d[np.in1d(d.ebint, iceid)]

g = dice.groupby('y1')
m = g.mean().iloc[:, 3:-2]
m1 = g.std().iloc[:, 3:-2]


plt.clf()
plt.cla()
fig1 = plt.figure(0)
ax = fig1.add_subplot(111)
ax.barh(range(3, -1, -1), np.repeat([-100], 4), 
        color = sns.color_palette()[0], linewidth=0)
ax.barh(range(3, -1, -1), np.repeat([200], 4), 
        color = sns.color_palette()[0], linewidth=0)
ax.barh(range(3, -1, -1), m.med_ice_on, xerr=m1.med_ice_on, 
        color = 'lightgray', ecolor = 'lightgray', 
        linewidth=0, error_kw={'linewidth': 10}) 
ax.barh(range(3, -1, -1), m.med_ice_off, xerr=m1.med_ice_off,
        color = 'lightgray', ecolor = 'lightgray', 
        linewidth=0, error_kw={'linewidth': 10}) 

ax.text((m.med_ice_on.iloc[0] + m.med_ice_off.iloc[0]) / 2, 3.2, 
        'ice cover', horizontalalignment='center', verticalalignment='center')
for ii, i in enumerate(range(3, -1, -1)):
    ax.text(((m.med_ice_on + m.med_ice_off) / 2).values[i], ii,
            '%.1f d' % ((m.med_ice_off - m.med_ice_on).values[i] + 1), 
            horizontalalignment='center', 
            verticalalignment='center', size=10)


ax.set_ylim(0, 3.8)
ax.set_yticks(np.arange(4) + 0.4)
ax.set_yticklabels(['2091-2100', '2061-2070', '2031-2040', '2001-2010'])
ax.set_xlabel('day of year')
# ax.set_ylabel('scenario')

ax.set_title('''Only involving lakes that freeze once and open once every year (n = %s).
Regional variability denoted as error bars (standard deviation).''' % (dice.shape[0] / 4))

fig1.set_figheight(5)
fig1.set_figwidth(8)
fig1.savefig('ice for every-year dimictic lakes.pdf')

# plt.show()


