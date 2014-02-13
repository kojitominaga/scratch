'''allow at least 4 sec for each interpolation (probably takes only 2 to 3 sec)'''
import os
import math

burden = 4.0 # estimated 
neach = 6
ntime = str(35) 
# ntime = 'all'
ntimeint = 365 if ntime == 'all' else int(ntime)

years = range(2011, 2013)
varH = {# 'ta_2m':  '1H', 
        'ts_0m':  '1H', 
        'pr':     '1H', 
# 'psl':    '1H', 
        'ps':     '3H', 
# 'rss':    '3H', 
# 'rls':    '3H', 
'wss_10m': '1H'} ######, 
# 'hur_2m': '1H', 
# 'albedo': '1H'}

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
 math.ceil(24.0 / float(H[0]) * ntimeint * nloc * burden / 60.0 / 60.0),
 varname, H, varname, year, locfn, neach, ntime) 
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

