import numpy as np
import os
import sys
import datetime


## prepare matching profile (to MyLake output depthresolution) 
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
ctd = ctd[['Lake', 'Depth', 'Temp', 'Date']]

ctd = ctd[ctd['Lake'] > 0, :]
lake_ids1 = set(ctd['Lake'])

spr_turnover = \
  np.genfromtxt('../postmylake/spring turnover dates 2011 COMSAT.txt', 
                delimiter = ' ',      
                dtype = 'i4,<M8[D]',
                converters = {0: lambda(x): int(x.strip('COMSAT'))}, 
                names = ['Lake', 'SprTurnDate'])
lake_ids2 = set(spr_turnover['Lake'])

lake_ids = lake_ids1.intersection(lake_ids2)

testingdirname = 'testing_2014-03-18'
if not os.path.exists(testingdirname): os.makedirs(testingdirname)

with open('cmdarguments.txt', 'w') as g:
    for l in lake_ids:
        datestr = set(ctd[ctd['Lake'] == l, :]['Date'])
        assert len(datestr) == 1, 'there is something wrong here'
        year, month, day = list(datestr)[0].strip('"').split('/')
        thedate = datetime.date(int('20' + year), int(month), int(day))
        
        lakename = 'COMSAT%s' % l
        lakedir = os.path.join(testingdirname, lakename)
        if not os.path.exists(lakedir): os.makedirs(lakedir)
        lakectd = ctd[ctd['Lake'] == l]
        layeraffil = np.floor(lakectd['Depth']).astype('i2')
        layerlist = list(set(layeraffil))
        layerlist.sort()
    
        ## 1) lake specific target temperature profile
        with open(os.path.join(lakedir, 
                               'COMSAT_field_%s.txt' % thedate.isoformat()), 
                               'w') as f:
            for layer in layerlist:
                meantemp = lakectd['Temp'][layeraffil == layer, :].mean()
                f.write('%i %.3f' % (layer, meantemp))
                f.write('\n')

        ## 2) mlinput for the necessary dates
        mldir = os.path.join('..', 'mylake', lakename)
        inputfileold = os.path.join(mldir, 'i3co', 
                                    '%s_%s_%s' % (
                                        'NORA10_11km_interpolated_2009-2012', 
                                        lakename, 'i3co.mlinput'))        
        inputfilenew = os.path.join(mldir, 'i3co', 
                                    '%s_%s_%s' % (
                                        'NORA10_11km_interpolated_2009-2012', 
                                        lakename, 'i3co.mlinput.short'))
        turnover64 = spr_turnover['SprTurnDate'][spr_turnover['Lake'] == l][0]
        turnoverstr = turnover64.astype('str')
        sy, sm, sd = [int(e) for e in turnoverstr.split('-')]
        ey, em, ed = [int(e) for e in thedate.isoformat().split('-')]
        day1 = datetime.date(2009, 1, 1)
        startdate = datetime.date(sy, sm, sd)
        skip = (startdate - day1).days 
        enddate = datetime.date(ey, em, ed)
        simulationlength = (enddate - startdate).days + 1
        with open(inputfileold) as f_old:
            with open(inputfilenew, 'w') as f_new:
                f_new.write(f_old.readline())
                f_new.write(f_old.readline())
                for _ in range(skip):
                    f_old.readline()
                for _ in range(simulationlength):
                    f_new.write(f_old.readline())
                        
        ## 3) command arguments (cmdarguments.txt) for engine.py
        initfile = os.path.join(mldir, 'init', '1.5fielddepth_cone.mlinit')
        parfile = os.path.join(mldir, 'par', '18secchi_Minnesota.mlpar')
        sy, sm, sd = turnoverstr.split('-') # strings
        ey, em, ed = thedate.isoformat().split('-')
        g.write(' '.join([str(l), initfile, parfile, inputfilenew, 
                          sy, sm, sd, ey, em, ed, lakedir]))
        g.write('\n')

        

