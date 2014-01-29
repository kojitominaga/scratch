import os
outputfiles = [f for f in os.listdir('.') if 'output_' in f]
lakeid = [int(fn.split('.')[0].split('_')[1]) for fn in outputfiles]

summary = []

for fi in range(len(outputfiles)):
    fn = outputfiles[fi]
    id = lakeid[fi]
    f = open(fn, 'rU')
    output = f.read()
    f.close()
    species = output.split('----------------------------Distribution of species----------------------------')[1].split('------------------------------Saturation indices-------------------------------')[0]
    co2 = float(species.split('CO2')[1].split()[0])
    saturation = output.split('------------------------------Saturation indices-------------------------------')[1].split('------------------')[0]
    co2g = float(saturation.split('CO2(g)')[1].split()[0])
    summary = summary + ['%d,%g,%g' % (id, co2, co2g)]

f = open('CO2 PHREEQC for 76 (not 77) COMSAT lakes.csv', 'w')
f.write('ID,CO2_PHREEQC,logpCO2_PHREEQC\n')
f.write('\n'.join(summary))
f.close()
