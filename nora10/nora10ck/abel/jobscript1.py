'''allow at least 4 sec for each interpolation (probably takes only 2 to 3 sec)'''
import os
import math
import sys

burden = 1.5 
# estimated time in min per interpolation 
# (i.e., per location, per time point)

neach = 1
tarsplitn = 10

years = range(2012, 2013)
varH = {# 'ta_2m':  '1H', 
        # 'ts_0m':  '1H', 
        # 'pr':     '1H', 
        # 'psl':    '1H', 
        'ps':     '3H', 
        # 'rss':    '3H', 
        # 'rls':    '3H', 
        'wss_10m': '1H', 
        'hur_2m': '1H'} ######,  
# 'albedo': '1H'}

# ntime = str(35) 
# ntime = 'all'
# ntime = 'mean24'
ntimedict = {'3H': 'mean8', 
             '1H': 'mean24'}
# ntime = 'mean8'
if ('ntime' in locals()) and ('ntimedict' in locals()):
    sys.exit('you cannot have both ntime and ntimedict') 
if 'ntime' in locals():
    if not type(ntime) == str:
        sys.exit('ntime needs to be a string, even if it is a numeral')
    if not ((ntime in ['all', 'mean24', 'mean8']) or ntime.isdigit()):
        sys.exit('ntime like that is not implemented yet')
elif 'ntimedict' not in locals():
    sys.exit('have you forgotten ntimedict or ntime')
            
if not os.path.exists('jobscripts'):
    os.makedirs('jobscripts')

locfns = [os.path.abspath(os.path.join('locations', f))
          for f in os.listdir('locations') if os.path.splitext(f)[1] == '.csv']
nlocs = [None] * len(locfns)
for i in range(len(locfns)):
    locfn = locfns[i]
    f = open(locfn, 'r')
    header = f.readline()
    lines = f.readlines()
    nlocs[i] = len([line for line in lines if len(line.strip()) > 0])
    # if something is written
    f.close()
locdict = {k: v for (k, v) in [(locfns[i], nlocs[i]) for i in range(len(locfns))]}

fnames = ['jobscripts/%s_%s_%s.sh' % 
          (os.path.splitext(os.path.basename(locfn))[0], varname, year) 
          for year in years 
          for (locfn, nloc) in locdict.items()
          for (varname, H) in varH.items()]
contents = ['''#!/bin/bash

#SBATCH --job-name=%s%02i%i%s
#SBATCH --account=uio
#SBATCH --time=%02i:00:00

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=ALL

#SBATCH --mem-per-cpu=3G
#SBATCH --qos=lowpri

source /cluster/bin/jobsetup
module load python2
module load R

cp /cluster/home/kojito/nora10/scripts/* $SCRATCH

export OMP_NUM_THREADS=1

cd $SCRATCH

python nora10interpmain.py /work/users/kojito/nora10/nc/%s/NORA10_%s_11km_%s_%s.nc %s $SCRATCH %s %s
''' % 
(os.path.splitext(os.path.basename(locfn))[0][0], 
 int(os.path.splitext(os.path.basename(locfn))[0][3:]),
 int(year) % 100, 
 varname,
 {'all': (365 * 24 / int(H[0])), 'mean24': 365, 'mean8': 365}.setdefault(ntimedict[H], int(ntimedict[H]) if ntimedict[H].isdigit() else None) *
# {'all': (365 * 24 / int(H[0])), 'mean24': 365, 'mean8': 365}.setdefault(ntime, int(ntime)) *
  nloc * burden / 60.0,
 varname, H, varname, year, locfn, tarsplitn, 
 ntimedict[H]) 
#  ntime) 
 for year in years 
 for (locfn, nloc) in locdict.items()
 for (varname, H) in varH.items()]

for i in range(len(fnames)):
    fname = fnames[i]
    content = contents[i]
    f = open(fname, 'w')
    f.write(content)
    f.close()

f = open('submit.sh', 'w')
out = ' & '.join(['sbatch %s' % fname for fname in fnames]) + '\n'
f.write(out)
f.close()

