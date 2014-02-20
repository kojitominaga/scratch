'''version that handle more than one task per node'''
import os
import math
import sys

jobscriptsdir = 'jobscripts3'
submitshname = 'submit3.sh'

ntaskspernode = 3

burden = 20 
# estimated time in min per interpolation 
# (i.e., per location, per time point)

neach = 1
tarsplitn = 10

years = range(2010, 2012)
varH = {# 'ta_2m':  '1H', 
        'ts_0m':  '1H', 
        'pr':     '1H'}
#         # 'psl':    '1H', 
#         'ps':     '3H', 
#         # 'rss':    '3H', 
#         # 'rls':    '3H', 
#         'wss_10m': '1H', 
#         'hur_2m': '1H'} ######,  
# # 'albedo': '1H'}

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
            
if not os.path.exists(jobscriptsdir): os.makedirs(jobscriptsdir)

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
locdict = dict([(locfns[i], nlocs[i]) for i in range(len(locfns))])

iii = len(years) * len(locdict) * len(varH)
taskii1 = range(0, iii, ntaskspernode)
taskii2 = taskii1[1:] + [iii]
nnodes = len(taskii1)
taskii = [range(taskii1[j], taskii2[j]) for j in range(nnodes)]

jobnames = ['%s%03i%i%s' % 
            (os.path.splitext(os.path.basename(locfn))[0][0], 
             int(os.path.splitext(os.path.basename(locfn))[0][3:]),
             int(year) % 100, 
             varname) 
            for year in years 
            for (locfn, nloc) in locdict.items()
            for (varname, H) in varH.items()]
commands = ['%s %s/%s/NORA10_%s_11km_%s_%s.nc %s $SCRATCH %s %s &' % 
            ('python nora10interpmain.py', 
             '/work/users/kojito/nora10/nc', 
             varname, H, varname, year, locfn, tarsplitn, ntimedict[H]) 
            for year in years 
            for (locfn, nloc) in locdict.items()
            for (varname, H) in varH.items()]
requiredhours = \
  [{'all': (365 * 24 / int(H[0])), 
    'mean24': 365, 
    'mean8': 365}.setdefault(
        ntimedict[H], 
        int(ntimedict[H]) if ntimedict[H].isdigit() else None) *
    nloc * burden / 60.0
    for year in years 
    for (locfn, nloc) in locdict.items()
    for (varname, H) in varH.items()]

requiredhourslist = [int(math.ceil(max(requiredhours[taskii1[ni]:taskii2[ni]])))
                     for ni in range(nnodes)]
longjobnames = [''.join(jobnames[taskii1[ni]:taskii2[ni]]) 
                for ni in range(nnodes)]
jobfnames = [jobscriptsdir + '/' + ljn + '.sh' for ljn in longjobnames]
commandslist = ['\n'.join(commands[taskii1[ni]:taskii2[ni]])
                for ni in range(nnodes)]


contents = ['''#!/bin/bash

#SBATCH --job-name=%s
#SBATCH --account=uio
#SBATCH --time=%02i:00:00

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=%i
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=ALL

#SBATCH --mem-per-cpu=3G
#SBATCH --qos=lowpri

source /cluster/bin/jobsetup
module load python2
module load R

cp /cluster/home/kojito/nora10/scripts/* $SCRATCH

# export OMP_NUM_THREADS=1

cd $SCRATCH

%s
''' % 
(longjobnames[ni], 
 requiredhourslist[ni], 
 taskii2[ni] - taskii1[ni], 
 commandslist[ni]) 
for ni in range(nnodes)]

for ni in range(nnodes):
    jobfname = jobfnames[ni]
    content = contents[ni]
    f = open(jobfname, 'w')
    f.write(content)
    f.close()

f = open(submitshname, 'w')
out = ' & '.join(['sbatch %s' % jobfname for jobfname in jobfnames]) + '\n'
f.write(out)
f.close()
