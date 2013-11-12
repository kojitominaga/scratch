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

f2 = open('ranges.csv', 'a')
f2.write('file,variable,di,min,max\n')

for g in fnames:
    try: 
        r = netCDF4.Dataset(g)
    except RuntimeError:
        f.write('error in: ' + g + '\n')
        continue
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
                temp2 = 'NA'
                f2.write('%s,%s,%s,%f,%f\n' % (g, v, temp2, temp.min(), temp.max()))
            if nd == 2:
                temp = r.variables[v][:, :].reshape(np.product(r.variables[v].shape), )
                temp2 = 'NA'
                f2.write('%s,%s,%s,%f,%f\n' % (g, v, temp2, temp.min(), temp.max()))
            if nd == 3:
                print r.variables[v].shape
                nx = r.variables[v].shape[0]
                dayii = [int(n) for n in [0] + np.floor(np.random.random(3) * nx).tolist() + [nx - 1]]
                for dayi in dayii:
                    temp = r.variables[v][dayi, :, :].flatten()
                    f2.write('%s,%s,%s,%f,%f\n' % (g, v, dayi, temp.min(), temp.max()))
            if nd == 4:
                nx = r.variables[v].shape[0]
                dayii = [int(n) for n in [0] + np.floor(np.random.random(3) * nx).tolist() + [nx - 1]]
                for dayi in dayii:
                    temp = r.variables[v][dayi, :, :, :].flatten()
                    f2.write('%s,%s,%s,%f,%f\n' % (g, v, dayi, temp.min(), temp.max()))
        r.close()
