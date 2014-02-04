import os

outputfiles = [f for f in os.listdir('.') 
               if ('output_' in f) and (not ('UIO' in f))]
lakeid = [int(fn.split('.')[0].split('_')[1]) for fn in outputfiles]

summary = []

for fi in range(len(outputfiles)):
    fn = outputfiles[fi]
    id = lakeid[fi]
    f = open(fn, 'rU')
    output = f.read()
    f.close()
    species = output.split('----------------------------Distribution of species----------------------------')[1].split('------------------------------Saturation indices-------------------------------')[0]
    concentration = float(species.split('CH4')[1].split()[0])
    saturation = output.split('------------------------------Saturation indices-------------------------------')[1].split('------------------')[0]
    gasSI = float(saturation.split('CH4(g)')[1].split()[0])
    summary = summary + ['%d,%g,%g' % (id, concentration, gasSI)]

f = open('CH4 PHREEQC for 76 (not 77) COMSAT lakes UMB.csv', 'w')
f.write('ID,CH4_PHREEQC,logpCH4_PHREEQC\n')
f.write('\n'.join(summary))
f.close()


outputfiles = [f for f in os.listdir('.') 
               if ('output_' in f) and ('UIO' in f)]
lakeid = [int(fn.split('.')[0].split('_')[1]) for fn in outputfiles]

summary = []

for fi in range(len(outputfiles)):
    fn = outputfiles[fi]
    id = lakeid[fi]
    f = open(fn, 'rU')
    output = f.read()
    f.close()
    species = output.split('----------------------------Distribution of species----------------------------')[1].split('------------------------------Saturation indices-------------------------------')[0]
    concentration = float(species.split('CH4')[1].split()[0])
    saturation = output.split('------------------------------Saturation indices-------------------------------')[1].split('------------------')[0]
    gasSI = float(saturation.split('CH4(g)')[1].split()[0])
    summary = summary + ['%d,%g,%g' % (id, concentration, gasSI)]

f = open('CH4 PHREEQC for 76 (not 77) COMSAT lakes UIO.csv', 'w')
f.write('ID,CH4_PHREEQC,logpCH4_PHREEQC\n')
f.write('\n'.join(summary))
f.close()
