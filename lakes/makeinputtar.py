import numpy as np
import pandas as pd
import os

lakes = pd.read_table('Feb2015GoranList.csv', sep=',')
f = open('listGoraninput', 'w')

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
        p = os.path.join(d, subd, 'Feb2015GoranREDOCOMPLETE')
        f.write(p) ; f.write('\n')
        p = os.path.join(d, subd, 'vanillainputGoran.bz2')
        f.write(p) ; f.write('\n')
        p = os.path.join(d, subd, 'Feb2015parGoran.bz2')
        f.write(p) ; f.write('\n')
        p = os.path.join(d, subd, 'Feb2015initGoran.bz2')
        f.write(p) ; f.write('\n')
        p = os.path.join(d, subd, 'TztGoran.csv.gz')
        f.write(p) ; f.write('\n')
        p = os.path.join(d, subd, 'KztGoran.csv.gz')
        f.write(p) ; f.write('\n')
        p = os.path.join(d, subd, 'HisGoran.csv.gz')
        f.write(p) ; f.write('\n')
        p = os.path.join(d, subd, 'QstGoran.csv.gz')
        f.write(p) ; f.write('\n')
f.close()





