import netCDF4
import os
import sys
import numpy as np

fnamesall = os.listdir('.')
fnames = [g for g in fnamesall if g.split('.')[-1] == 'nc']

f = open('checkresult', 'w')
f.write('checking the netCDF file consistency of the following files\n')
out = '\n'.join(fnames)
f.write(out)
f.write('\n')

f2 = open('ranges.csv', 'w')
f2.write('file,variable,min,max\n')

for g in fnames:
    try: 
        r = netCDF4.Dataset(g)
    except RuntimeError:
        f.write('error in: ' + g + '\n')
    else:
        sys.stdout = open(g + '.meta', 'w')
        print(r)
        for d in r.dimensions:
            print(r.dimensions[d])
        for v in r.variables:
            print(r.variables[v])
            nd = r.variables[v].ndim
            if nd == 0:
                continue 
            if nd == 1:
                temp = r.variables[v][:]
            if nd == 2:
                temp = r.variables[v][:, :].\
                  reshape(np.product(r.variables[v].shape), )
            if nd == 3:
                temp = r.variables[v][:, :, :].\
                  reshape(np.product(r.variables[v].shape), )
            if nd == 4:
                temp = r.variables[v][:, :, :, :].\
                  reshape(np.product(r.variables[v].shape), )
            f2.write('%s,%s,%f,%f\n' % (g, v, temp.min(), temp.max()))
