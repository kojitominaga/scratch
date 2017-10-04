import matplotlib.pyplot as plt
import seaborn as sns

d = pd.DataFrame.from_csv('test20151201_mixing_for_always_stratified_lakes.csv')
d.num_intermittent_mix_events[np.isnan(d.num_intermittent_mix_events)] = 0
d.num_intermittent_mix_days[np.isnan(d.num_intermittent_mix_days)] = 0
g = d.groupby('y1')
m = g.mean()
m2 = m.iloc[:, 3:-2]
m3 = g.std().iloc[:, 3:-2]
m4 = m2.aut_turn_start - m2.spr_turn_end
m5 = (m2.aut_turn_start + m2.spr_turn_end) / 2
m6 = m2.spr_turn_end - m2.spr_turn_start
m7 = (m2.spr_turn_end + m2.spr_turn_start) / 2
m8 = m2.aut_turn_end - m2.aut_turn_start
m9 = (m2.aut_turn_end + m2.aut_turn_start) / 2


plt.clf()
plt.cla()
fig1 = plt.figure(0)
ax = fig1.add_subplot(111)
ax.barh(range(3, -1, -1), np.repeat([365], 4), color = sns.color_palette()[0], linewidth=0)
ax.barh(range(3, -1, -1), m2.iloc[:, 3], xerr=m3.iloc[:, 3], color = sns.color_palette()[1], linewidth=0, ecolor = sns.color_palette()[1], error_kw={'linewidth': 10}) 
ax.barh(range(3, -1, -1), m2.iloc[:, 2], xerr=m3.iloc[:, 2], color = sns.color_palette()[4], linewidth=0, ecolor = sns.color_palette()[1], error_kw={'linewidth': 10})
ax.barh(range(3, -1, -1), m2.iloc[:, 1], xerr=m3.iloc[:, 1], color = sns.color_palette()[1], linewidth=0, ecolor = sns.color_palette()[1], error_kw={'linewidth': 10})
ax.barh(range(3, -1, -1), m2.iloc[:, 0], xerr=m3.iloc[:, 0], color = sns.color_palette()[0], linewidth=0, ecolor = sns.color_palette()[1], error_kw={'linewidth': 10})
ax.set_xlim(70, 365)
ax.set_ylim(0, 3.8)
ax.set_yticks(np.arange(4) + 0.4)
ax.set_yticklabels(['2091-2100', '2061-2070', '2031-2040', '2001-2010'])
ax.set_xlabel('day of year')
# ax.set_ylabel('scenario')
ax.text(200, 0.2, 'warm stratification', horizontalalignment='center', verticalalignment='center')
ax.text(110, 3.6, 'cold stratification', horizontalalignment='center', verticalalignment='center')
ax.text(330, 3.6, 'cold stratification', horizontalalignment='center', verticalalignment='center')
for ii, i in enumerate(range(3, -1, -1)):
    ax.text(m5.values[i], float(ii) + 0.6, 
            '%.1f d stratification with\n%.1f d of intermittent mixing' % (m4.values[i], m.num_intermittent_mix_days.values[i]), 
            horizontalalignment='center', 
            verticalalignment='center', size=10)
    ax.text(m7.values[i], float(ii) + 0.2, 
            '%.1f d' % m6.values[i], 
            horizontalalignment='center', 
            verticalalignment='center', size=10)
    ax.text(m9.values[i], float(ii) + 0.2, 
            '%.1f d' % m8.values[i], 
            horizontalalignment='center', 
            verticalalignment='center', size=10)

ax.set_title('''Only involving lakes that are stratified in 2001-2010 (n = %s).
Regional variability denoted as error bars (standard deviation).''' % (d.shape[0] / 4))

fig1.set_figheight(5)
fig1.set_figwidth(8)
fig1.savefig('mixing for stratified lakes.pdf')

# plt.show()


