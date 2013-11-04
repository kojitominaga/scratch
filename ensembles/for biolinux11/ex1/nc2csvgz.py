import netCDF4
import os.path
import os
import gzip

# limiting geography -- arbitrarily decided
x = range(35, 65) # direction east
y = range(58, 94) # direction north

y2 = y * len(x)
x2 = [elem for elem in x for _ in range(len(y))]

dnames = ['%03d-%03d' % (x2[i], y2[i]) for i in range(len(x2))]
fnames = os.listdir('.')
ncfnames = [fn for fn in fnames if fn[-3:] == '.nc']

for di in range(len(dnames)):
    dname = dnames[di]
    print(dname)
    thisx = x2[di]
    thisy = y2[di]
    if not os.path.exists(dname):
        os.makedirs(dname)
    for ncfname in ncfnames:
        vname = ncfname.split('.')[-2].split('_')[-1]
        print('... ' + vname)
        r = netCDF4.Dataset(ncfname)
        nd = r.variables[vname].ndim
        ## note that it is somehow y (EW) first and then x (NS)
        # float tas(time=3653, height=1, rlat=95, rlon=85); <-- NOTE THIS
        # # :standard_name = "air_temperature";
        # # :long_name = "2-meter temperature";
        # # :units = "K";
        # # :cell_methods = "time: mean";
        # # :coordinates = "lon lat";
        # # :grid_mapping = "rotated_pole";
        # # :_FillValue = 1.0E30f; // float        
        if nd == 3:
            numlist = r.variables[vname][:, thisy, thisx].tolist()
        elif nd == 4:
            numlist = r.variables[vname][:, 0, thisy, thisx].tolist()
        else:
            exit('error here')
        out = ['%.3e\n' % elem for elem in numlist]
        fnameout = ''.join([dname, '/', vname , '.csv.gz'])
        f = gzip.open(fnameout, 'wb')
        f.writelines(out)
        f.close()
        r.close()

