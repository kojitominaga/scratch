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

pdf = PdfPages('temperature profile -- comsat field vs MyLake lots assumptions uncalibrated_more.pdf')
for l in lake_ids:
    if l < 200:
        continue
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
    mylakefname018 = \
      os.path.join('..', 'mylake', 'COMSAT' + str(l), 'i3co', 
                   'NORA10_11km_interpolated_2009-2012_COMSAT' + 
                   str(l) + '_i3co_1.5fielddepth_cone_LA018_Minnesota',
                   'Tzt.txt')
    mylakefname090 = \
      os.path.join('..', 'mylake', 'COMSAT' + str(l), 'i3co', 
                   'NORA10_11km_interpolated_2009-2012_COMSAT' + 
                   str(l) + '_i3co_1.5fielddepth_cone_LA090_Minnesota',
                   'Tzt.txt')
    mylakefname450 = \
      os.path.join('..', 'mylake', 'COMSAT' + str(l), 'i3co', 
                   'NORA10_11km_interpolated_2009-2012_COMSAT' + 
                   str(l) + '_i3co_1.5fielddepth_cone_LA450_Minnesota',
                   'Tzt.txt')
    mylakefname1a = \
      os.path.join('..', 'mylake', 'COMSAT' + str(l), 'i1a', 
                   'NORA10_11km_interpolated_2009-2012_COMSAT' + 
                   str(l) + '_i1a_1.5fielddepth_cone_18secchi_Minnesota',
                   'Tzt.txt')
    if not os.path.exists(mylakefname): 
        continue
    ml = np.genfromtxt(mylakefname, dtype = 'f4')[boolindex, :].flatten()
    ml018 = np.genfromtxt(mylakefname018, dtype = 'f4')[boolindex, :].flatten()
    ml090 = np.genfromtxt(mylakefname090, dtype = 'f4')[boolindex, :].flatten()
    ml450 = np.genfromtxt(mylakefname450, dtype = 'f4')[boolindex, :].flatten()
    ml1a = np.genfromtxt(mylakefname1a, dtype = 'f4')[boolindex, :].flatten()
    mldepth = 0.5 + np.arange(len(ml))
    c = ctd[ctd['Lake'] == l, :][['Temp', 'Depth']] 
    c = np.sort(c, order = 'Depth')          
    fig, (ax1, ax2, ax3) = plt.subplots(1, 3)
    ax1.plot(c['Temp'], c['Depth'], color = 'darkgray', linewidth = 2,
             label = 'COMSAT field CTD')
    ax1.plot(ml, mldepth, color = 'blue', 
             label = 'ML lots assump uncalib')
    # plt.ylabel('COMSAT lake %s: %s' % (l, thedate.isoformat()))
    # plt.xlabel('Temperature (deg C)')
    ax1.axes.set_xlim(4, 25)
    ax1.axes.set_ylim(20, 0)
    ax1.xaxis.tick_top()
    ax1.legend(loc = 'lower right', fontsize = 'x-small')
    ax2.plot(c['Temp'], c['Depth'], color = 'darkgray', linewidth = 2,
             label = 'COMSAT field CTD')
    ax2.plot(ml450, mldepth, color = 'pink', 
             label = 'clear')
    ax2.plot(ml090, mldepth, color = 'red', 
             label = 'medium')
    ax2.plot(ml018, mldepth, color = 'darkred', 
             label = 'dark')
    ax2.axes.set_xlim(4, 25)
    ax2.axes.set_ylim(20, 0)
    ax2.xaxis.tick_top()
    ax2.legend(loc = 'lower right', fontsize = 'x-small')
    ax3.plot(c['Temp'], c['Depth'], color = 'darkgray', linewidth = 2,
             label = 'COMSAT field CTD')
    ax3.plot(ml, mldepth, color = 'blue', 
             label = 'i3co')
    ax3.plot(ml1a, mldepth, color = 'brown', 
             label = 'i1a')
    ax3.axes.set_xlim(4, 25)
    ax3.axes.set_ylim(20, 0)
    ax3.xaxis.tick_top()
    ax3.legend(loc = 'lower right', fontsize = 'x-small')

    pdf.savefig()
    plt.close()
pdf.close()        
            
    
