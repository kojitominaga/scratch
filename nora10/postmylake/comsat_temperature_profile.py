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

pdf =  PdfPages('temperature profile -- comsat field vs MyLake lots assumptions uncalibrated.pdf') 
for l in lake_ids:
    datestr = set(ctd[ctd['Lake'] == l, :]['Date'])
    assert len(datestr) == 1, 'there is something wrong here'
    year, month, day = list(datestr)[0].strip('"').split('/')
    thedate = datetime.date(int('20' + year), int(month), int(day))
    boolindex = np.array([mld == thedate for mld in mylakedates])
    mylakefname = \
      os.path.join('..', 'mylake', 'COMSAT' + str(l), 'i3co', 
                   'NORA10_11km_interpolated_2009-2012_COMSAT' + 
                   str(l) + '_i3co_1.5fielddepth_cone_18secchi_Minnesota',
                   'Tzt.txt')
    if not os.path.exists(mylakefname): 
        continue
    ml = np.genfromtxt(mylakefname, dtype = 'f4')[boolindex, :].flatten()
    mldepth = 0.5 + np.arange(len(ml))
    c = ctd[ctd['Lake'] == l, :][['Temp', 'Depth']] 
    c = np.sort(c, order = 'Depth')          
    fig, ax = plt.subplots(1, 1)
    plt.plot(ml, mldepth, color = 'blue', 
             label = 'MyLake lots assumptions, uncalibrated')
    plt.plot(c['Temp'], c['Depth'], color = 'darkgray',
             label = 'COMSAT field CTD measurements')
    plt.ylabel('COMSAT lake %s: %s' % (l, thedate.isoformat()))
    plt.xlabel('Temperature (deg C)')
    ax.axes.set_xlim(4, 25)
    ax.axes.set_ylim(20, 0)
    ax.xaxis.tick_top()
    plt.legend(loc = 'lower right')
    pdf.savefig()
    plt.close()
pdf.close()        
            
    
