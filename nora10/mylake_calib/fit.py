import numpy as np
import os
def fit(margs, comsatprofile):
    '''run mylake using mylake.m and calculate the fit statistics, returns it
    margs:    list of runmylake.m arguments, see runmylake.m
    comsatprofile: np.ndarray, temperature profile of comsat, dd = 1.0 m 
    '''
    outdir = margs[9]
    command = './runmylake.m ' + ' '.join(map(str, margs))
    os.system(command)
    nd = len(comsatprofile)
    ml = np.genfromtxt(os.path.join(outdir, 'Tzt.txt'))[:nd]
    rmsd = np.sqrt(np.sum((ml - comsatprofile) ** 2) / nd)
    bias = np.mean(ml) - np.mean(comsatprofile)
    return (rmsd, bias, ml)

if __name__ == '__main__':
    fn = 'testing_2014-03-18/COMSAT180/COMSAT_field_2011-07-29.txt'
    margs = ['../mylake/COMSAT180/init/1.5fielddepth_cone.mlinit',  
             '../mylake/COMSAT180/par/18secchi_Minnesota.mlpar', 
             '../mylake/COMSAT180/i3co/NORA10_11km_interpolated_2009-2012_COMSAT180_i3co.mlinput.short',
             2011, 5, 2, 2011, 7, 29,
             '.', 0.3, 0.3]
    comsatprofile = np.genfromtxt(fn, usecols = 1)
    rmsd1, bias1, ml1 = fit(margs, comsatprofile)
