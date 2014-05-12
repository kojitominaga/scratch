import numpy as np
import os
import sys
import datetime
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages

ctd = \
  np.genfromtxt('../comsat/CTD/COMSAT 2011 CTD.txt', 
                skip_header = 1, 
                dtype = 'i4,i4,i4,i4,S12,S14,'+','.join(['f8'] * 15), 
                converters = {3: lambda(x): 
                              x.strip('"') if x.strip('"').isdigit() else '0'}, 
                names = ['rownumber', 'I', "year", "Lake", "Date", "Time", 
                         "Cond", "Temp", "Pres", "R.Temp", "PAR", 
                         "R.D.O2", "TFlC.a", "TFlE.a", "TFlP.a", "Depth", 
                         "Salin", "SpecCond", "DensAnom", "SoS", "rdO2C"])
# ctd['Lake'] == 0 where lake is Bogstad and year 2010, see converters

ctd = ctd[ctd['Lake'] > 0, :]
lake_ids = set(ctd['Lake'])

startdate = datetime.date(2009, 1, 1)
enddate = datetime.date(2012, 12, 31)
ndays = (enddate - startdate).days + 1
mylakedates = [startdate + datetime.timedelta(td) for td in range(ndays)]

with open('mean surface temperature by MyLake at COMSAT lakes summer 2011.csv', 'w') as f:
    f.write('fielddate, lakeid, ctd_surface, mylake_surface_field_day, \
mylake_surface_mean_Jun_2011, \
mylake_surface_mean_July_2011, \
mylake_surface_mean_August_2011, \
mylake_surface_mean_June-August_2011\n')

    for l in lake_ids:
        datestr = set(ctd[ctd['Lake'] == l, :]['Date'])
        assert len(datestr) == 1, 'there is something wrong here'
        year, month, day = list(datestr)[0].strip('"').split('/')
        thedate = datetime.date(int('20' + year), int(month), int(day))
        boolindex = np.array([mld == thedate for mld in mylakedates])
        isJun2011 = np.array([mld.year == 2011 and mld.month == 6 
                              for mld in mylakedates])
        isJul2011 = np.array([mld.year == 2011 and mld.month == 7 
                              for mld in mylakedates])
        isAug2011 = np.array([mld.year == 2011 and mld.month == 8 
                              for mld in mylakedates])
        isSummer2011 = (isJun2011 + isJul2011 + isAug2011).astype(bool)
                           
        mylakefname = \
          os.path.join('..', 'mylake', 'COMSAT' + str(l), 'i3co', 
                       'NORA10_11km_interpolated_2009-2012_COMSAT' + 
                       str(l) + '_i3co_1.5fielddepth_cone_18secchi_Minnesota',
                       'Tzt.txt')
        if not os.path.exists(mylakefname): 
            continue
        ml = np.genfromtxt(mylakefname, dtype = 'f4')
        mlfieldday = ml[boolindex, :].flatten()
        c = ctd[ctd['Lake'] == l, :][['Temp', 'Depth']] 
        c = np.sort(c, order = 'Depth')          
        ctdsurface = c[0][0]
        mlfielddaysurface = mlfieldday[0]
        mlsurface = ml[:, 0]
        mlJun2011 = mlsurface[isJun2011].mean()
        mlJul2011 = mlsurface[isJul2011].mean()
        mlAug2011 = mlsurface[isAug2011].mean()
        mlSummer2011 = mlsurface[isSummer2011].mean()
        out = '%s, %s, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f\n' % (
            thedate.isoformat(), l, ctdsurface, mlfielddaysurface, 
            mlJun2011, mlJul2011, mlAug2011, mlSummer2011)
        f.write(out)
