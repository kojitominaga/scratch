'''gets spring turnover date for COMSAT lakes'''
import os
import numpy as np
import datetime

comsatdirs = [d for d in os.listdir('../mylake_inputs/') if 'COMSAT' in d]
outputfns = \
  [os.path.join('..', 'mylake_inputs', d, 'i3co', 
                '%s_%s_%s' % ('NORA10_11km_interpolated_2007-2012', 
                              d, 'i3co_1.5fielddepth_cone_18secchi_Minnesota'),
                'Tzt.txt')
   for d in comsatdirs]
ndays = (datetime.date(2012, 12, 31) - datetime.date(2007, 1, 1)).days + 1
dates = [datetime.date(2007, 1, 1) + datetime.timedelta(i) 
         for i in range(ndays)]
with open('spring turnover dates 2011 COMSAT.txt', 'w') as f:
    for lake_name, filename in zip(comsatdirs, outputfns):
        if not os.path.exists(filename):
            continue
        Tzt = np.genfromtxt(filename)
        is_warm = (Tzt > 3.98).all(axis = 1)
        is_2011 = (365 * 4 < np.arange(ndays)) & (np.arange(ndays) < 365 * 5)
        spr_turnover = dates[min(np.arange(ndays)[is_warm & is_2011])]
        f.write(' '.join([lake_name, spr_turnover.isoformat()]))
        f.write('\n')

        
