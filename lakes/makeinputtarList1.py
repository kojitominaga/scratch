import numpy as np
import pandas as pd
import os

lakes = pd.read_table('Feb2015GranadaList.csv', sep=',')
f = open('listtodownloadCOMPLETE', 'w')

for i, v in lakes['ebhex'].iteritems():
    hex = v.lstrip('0x')
    while len(hex) < 6:
        hex = '0' + hex
    print(hex)
    d0 = hex[:2]
    d1 = hex[:4]
    d = os.path.join(d0, d1, hex)
    subds = os.listdir(d)
    for subd in subds:
        p = os.path.join(d, subd, 'Feb2015COMPLETE')
        f.write(p) ; f.write('\n')
        # p = os.path.join(d, subd, 'vanillainput.bz2')
        # f.write(p) ; f.write('\n')
        # p = os.path.join(d, subd, 'Feb2015par.bz2')
        # f.write(p) ; f.write('\n')
        # p = os.path.join(d, subd, 'Feb2015init.bz2')
        # f.write(p) ; f.write('\n')
        # p = os.path.join(d, subd, 'Tzt.csv.gz')
        # f.write(p) ; f.write('\n')
        # p = os.path.join(d, subd, 'Kzt.csv.gz')
        # f.write(p) ; f.write('\n')
        # p = os.path.join(d, subd, 'His.csv.gz')
        # f.write(p) ; f.write('\n')
        # p = os.path.join(d, subd, 'Qst.csv.gz')
        # f.write(p) ; f.write('\n')
f.close()





