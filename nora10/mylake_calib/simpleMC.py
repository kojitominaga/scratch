import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import os
import seaborn as sns
import fit

n = 3

def plotfitstats(p1a, p2a, p1d, p2d, rmsda, biasa, title, fname):
    '''image plot for rmsda with contour lines of bias'''
    sns.set_style('white', {'image.cmap': 'Greens'})
    sns.set_color_palette('pastel')
    sns.set_palette('pastel')
    x, y = np.meshgrid(p1a, p2a)
    fig, ax = plt.subplots()
    # im = ax.imshow(rmsda)
    # im.set_interpolation('bilinear')
    p = ax.pcolor(x, y
, rmsda.T)
    # p = ax.pcolor(rmsda, cmap = sns.color_palette('pastel', 100, as_cmap = True))
    cb = fig.colorbar(p, ax = ax)
    cnt = ax.contour(x, y, biasa.T, 
                     colors = 'black', 
                     # colors = sns.color_palette('bright', 100), 
                     # origin = 'upper', 
                     origin = 'lower', 
                     linewidth = 3)
    plt.clabel(cnt, inline = 1, fontsize = 10, fmt = '%.2f')
    ax.set_title('%s, p1_default = %.3g, p2_default = %.3g\nBias (line) and RMSE (image) -- min(RMSE) = %.1f' % (
        title, p1d, p2d, np.min(rmsda)))
    ax.set_xlabel('p1')
    ax.set_ylabel('p2')
    fig.savefig(fname)

def finddefaults(initfn):
    '''from the init file find the default values according to the MN study'''
    with open(initfn, 'rU') as f:
        f.readline()
        f.readline()
        m2 = float(f.readline().lstrip().split()[1])
    km2 = m2 * 1e-6
    p1 = 0.00706 * (km2 ** 0.56)
    p2 = 1 - np.exp(-0.3 * km2)
    return (p1, p2)

with open('cmdarguments.txt', 'rU') as f:
    cmddict = {l.strip().split()[0]: l.strip().split()[1:] 
               for l in f.readlines()}

rmsddict = dict()
biasdict = dict()
for id in cmddict.keys():
    margs_part = cmddict[id]
    lakename = 'COMSAT%s' % id
    print lakename
    if os.path.exists(os.path.join('png', '%s.png' % lakename)):
        continue
    if id in ['453', '326', '277']:
        continue
    fn = 'testing_2014-06-04/%s/COMSAT_field_%04d-%02d-%02d.txt' % (
        lakename, int(margs_part[6]), int(margs_part[7]), int(margs_part[8]))
    comsatprofile = np.genfromtxt(fn, usecols = 1)
    p1d, p2d = finddefaults(margs_part[0])
    p1a = np.linspace(start = p1d / 10.0, stop = p1d * 2.0, num = n)
    p2a = np.linspace(start = p2d / 4.0, stop = (p2d + 3.0) / 4.0, num = n) 
    rmsda = np.zeros((n, n)) * np.nan
    biasa = np.zeros((n, n)) * np.nan
    for i1, p1 in enumerate(p1a):
        for i2, p2 in enumerate(p2a):
            rmsd, bias, ml = fit.fit(margs_part + [p1, p2], comsatprofile)
            rmsda[i1, i2] = rmsd
            biasa[i1, i2] = bias
            print (' '.join(['%.2g' % v for v in [i1, i2, p1, p2, rmsd, bias]]))
    rmsddict[id] = rmsda
    biasdict[id] = biasa
    plt.cla()
    plotfitstats(p1a, p2a, p1d, p2d, rmsda, biasa, lakename, 
                 'png/%s.png' % lakename)

p_default = dict()
p_min_rmsd = dict()
p_min_abs_bias = dict()
min_rmsd = dict()
min_abs_bias = dict()
for id in cmddict.keys():
    lakename = 'COMSAT%s' % id
    margs_part = cmddict[id]
    p1d, p2d = finddefaults(margs_part[0])
    p1a = np.linspace(start = p1d / 10.0, stop = p1d * 2.0, num = n)
    p2a = np.linspace(start = p2d / 4.0, stop = (p2d + 3.0) / 4.0, num = n) 
    rmsda = rmsddict[id]
    biasa = biasdict[id]

    p_default[id] = (p1d, p2d)

    flati = np.argmin(rmsda)
    i1, i2 = np.unravel_index(flati, rmsda.shape)
    p_min_rmsd[id] = (p1a[i1], p2a[i2])
    min_rmsd[id] = rmsda.flatten()[flati]

    flatj = np.argmin(np.abs(biasa))
    j1, j2 = np.unravel_index(flatj, biasa.shape)
    p_min_abs_bias[id] = (p1a[j2], p2a[j2])
    min_abs_bias[id] = np.abs(biasa).flatten()[flatj]


dtype = np.dtype([('id', 'i4'),
                  ('lakename', '|S12'), 
                  ('p1_default', 'f4'), 
                  ('p2_default', 'f4'), 
                  ('p1_min_rmsd', 'f4'), 
                  ('p2_min_rmsd', 'f4'), 
                  ('p1_min_abs_bias', 'f4'), 
                  ('p2_min_abs_bias', 'f4'),
                  ('min_rmsd', 'f4'), 
                  ('min_abs_bias', 'f4')])
simulations = dict()

structured = np.zeros((len(cmddict), ), dtype = dtype)
structured['id'] = cmddict.keys()
df = pd.DataFrame.from_records(structured, index = 'id')

def decodelatin9(x):
    return x.decode('latin9')

for id in cmddict.keys():
    iid = int(id)
    _, name, date, start, end, st_d, zo_d, se_d, lat, lon = fielddata.ix[iid]
    df.ix[iid, 'lakename'] = name

for id in cmddict.keys():
    iid = int(id)
    margs_part = cmddict[id]
    lakename = 'COMSAT%s' % id
    print lakename
    fn = 'testing_2014-06-04/%s/COMSAT_field_%04d-%02d-%02d.txt' % (
        lakename, int(margs_part[6]), int(margs_part[7]), int(margs_part[8]))
    comsatprofile = np.genfromtxt(fn, usecols = 1)

    p1d, p2d = finddefaults(margs_part[0])
    df.ix[iid, 'p1_default'] = p1d
    df.ix[iid, 'p2_default'] = p2d
    p1_min_rmsd, p2_min_rmsd = p_min_rmsd[id]
    df.ix[iid, 'p1_min_rmsd'] = p1_min_rmsd
    df.ix[iid, 'p2_min_rmsd'] = p2_min_rmsd 
    p1_min_abs_bias, p2_min_abs_bias = p_min_abs_bias[id]
    df.ix[iid, 'p1_min_abs_bias'] = p1_min_abs_bias
    df.ix[iid, 'p2_min_abs_bias'] = p2_min_abs_bias

    df.ix[iid, 'min_rmsd'] = min_rmsd[id]
    df.ix[iid, 'min_abs_bias'] = min_abs_bias[id]

    rmsd, bias, ml_default = \
        fit(margs_part + [p1, p2], comsatprofile)
    rmsd, bias, ml_min_rmsd = \
        fit(margs_part + [p1_min_rmsd, p2_min_rmsd], comsatprofile)
    rmsd, bias, ml_min_abs_bias = \
        fit(margs_part + [p1_min_abs_bias, p2_min_abs_bias], comsatprofile)

    mldf = pd.DataFrame.from_dict({'observation': comsatprofile, 
                                   'default': ml_default, 
                                   'min_rmsd': ml_min_rmsd, 
                                   'min_abs_bias': ml_min_abs_bias})
    mldf.index = np.arange(comsatprofile.size) + 0.5
    simulations[iid] = mldf

df.to_csv('csv/parameters_latin9.csv', encoding = 'latin9')
df.to_csv('csv/parameters_utf8.csv', encoding = 'utf8')

for i, id in enumerate(cmddict.keys()):
    iid = int(id)
    lakename = 'COMSAT%s' % id
    fname = 'csv/%s.csv' % lakename
    simulations[iid].to_csv(fname)

fielddata = pd.DataFrame.from_csv('../comsat/NSD/COMSAT 2011 field.data.txt', 
                                  sep = ' ', encoding = 'latin9', 
                                  parse_dates = False, index_col = 1)
# plt.cla()
# fig1 = plt.figure(figsize = (11, 7))
# gs1 = gridspec.GridSpec(3, 7)
# fig2 = plt.figure(figsize = (11, 7))
# gs2 = gridspec.GridSpec(3, 7)
# fig3 = plt.figure(figsize = (11, 7))
# gs3 = gridspec.GridSpec(3, 7)
# fig4 = plt.figure(figsize = (11, 7))
# gs4 = gridspec.GridSpec(3, 7)
# axes = [plt.subplot(g) for g in list(gs1)] + \
#        [plt.subplot(g) for g in list(gs2)] + \
#        [plt.subplot(g) for g in list(gs3)] + \
#        [plt.subplot(g) for g in list(gs4)]

sns.set_style('whitegrid')
fig = plt.figure(figsize = (11, 7))
gs = gridspec.GridSpec(3, 7)
for i, id in enumerate(cmddict.keys()):
    iid = int(id)
    ax = plt.subplot(gs[i % 21])
    _, name, date, start, end, st_d, zo_d, se_d, lat, lon = fielddata.ix[iid]
    this_df = simulations[iid]
    d = this_df.index
    ax.plot(this_df['observation'], d, '-k', label = 'obs. (instantaneous)')
    ax.plot(this_df['default'], d, '-', label = 'ML default (daily mean)')
    ax.plot(this_df['min_rmsd'], d, '-', label = 'ML min RMSE (daily mean)')
    ax.plot(this_df['min_abs_bias'], d, '-', 
            label = 'ML min abs bias (daily mean)')
    label1 = '%s (%s)' % (name, id)
    label2 = '%s (%s-%s)' % (date, start, end)
    # ax.legend(loc = 0)
    ax.set_label('\n'.join([label1, label2]))
    ax.set_xlim(4.0, 24.0)
    ax.set_ylim(0.0, 15.0)
    ax.invert_yaxis()
    if not (i % 7 == 0):
        nyticks = len(ax.yaxis.get_ticklabels())
        ax.yaxis.set_ticklabels([''] * nyticks)
    if  (i % 21 < 14):
        nyticks = len(ax.xaxis.get_ticklabels())
        ax.xaxis.set_ticklabels([''] * nyticks)
    if i == 20:
        fig.savefig('png/MyLake vs. Observation 1.png')
        fig = plt.figure(figsize = (11, 7))
        gs = gridspec.GridSpec(3, 7)
    if i == 41:
        fig.savefig('png/MyLake vs. Observation 2.png')
        fig = plt.figure(figsize = (11, 7))
        gs = gridspec.GridSpec(3, 7)
    if i == 62:
        fig.savefig('png/MyLake vs. Observation 3.png')
        fig = plt.figure(figsize = (11, 7))
        gs = gridspec.GridSpec(3, 7)
fig.savefig('png/MyLake vs. Observation 4.png')

# for figi, fig in enumerate([fig1, fig2, fig3, fig4]):
#     fig.savefig('png/MyLake vs. Observation %d.png' % figi)
