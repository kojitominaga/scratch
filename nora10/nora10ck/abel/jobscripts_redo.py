'''version that handle more than one task per node'''
import os
import math
import sys

jobscriptsdir = 'jobscripts'
submitshname = 'submit_redo.sh'

ntaskspernode = 1

burden = 1.5
# estimated time in min per interpolation 
# (i.e., per location, per time point)

neach = 1
if not neach == 1: sys.exit('neach > 1 not supported now')

tarsplitn = 100

varH = {'rss': '1H',
        'wfds_10m':    '1H', 
        'clt': '1H', 
        'albedo': '1H', 
        'ta_2m': '1H',
        'ts_0m':  '1H', 
        'pr':     '1H',
        'psl':    '1H', 
        'ps':     '3H', 
        'wss_10m': '1H', 
        'hur_2m': '1H', 
        'rls':    '1H'}
ntimedict = {'3H': 'mean8', '1H': 'mean24'}

with open('redo.txt') as f:
    info = [l.split() for l in f.readlines()]

info2 = [(loc, 
          os.path.join('locations', loc + '.csv'), 
          varname, 
          varH[varname], 
          ntime, 
          year) 
          for (loc, varname, ntime, year) in info]
          
jobnames = ['%s%s%s' % (loc, int(year) % 100, varname) 
            for (loc, locfn, varname, H, ntime, year) in info2]

commands = ['%s %s/%s/NORA10_%s_11km_%s_%s.nc %s $SCRATCH %s %s &' % 
            ('python nora10interpmain.py', 
             '/work/users/kojito/nora10/nc', 
             varname, H, varname, year, 
             os.path.basename(locfn),  ## local at $SCRATCH
             tarsplitn, ntime) 
            for (loc, locfn, varname, H, ntime, year) in info2]

COMPLETE1 = [os.path.join('/work/users/kojito/nora10/', 
                          'intermediate',
                          loc,
                          varname, 
                          ntime, 
                          year, 
                          'COMPLETED')
             for (loc, locfn, varname, H, ntime, year) in info2]

COMPLETE2 = [os.path.join('/work/users/kojito/nora10/', 
                          'interpolated',
                          loc,
                          varname, 
                          ntime, 
                          year, 
                          'COMPLETED')
             for (loc, locfn, varname, H, ntime, year) in info2]

requiredhours = \
  [{'all': (365 * 24 / int(H[0])),
    'mean24': 365, 
    'mean8': 365}.setdefault(
        ntime, ## key
        int(ntime) if str(ntime).isdigit() else None) * ## default value
    1 * burden / 60.0
    for (loc, locfn, varname, H, ntime, year) in info2]

iii = len(info2)
taskii1 = range(0, iii, ntaskspernode)
taskii2 = taskii1[1:] + [iii]
nnodes = len(taskii1)
taskii = [range(taskii1[j], taskii2[j]) for j in range(nnodes)]

requiredhourslist = [int(math.ceil(max(requiredhours[taskii1[ni]:taskii2[ni]])))
                     for ni in range(nnodes)]
longjobnames = [''.join(jobnames[taskii1[ni]:taskii2[ni]]) 
                for ni in range(nnodes)]
jobfnames = [jobscriptsdir + '/' + ljn + '.sh' for ljn in longjobnames]
commandslist = ['\n'.join(commands[taskii1[ni]:taskii2[ni]])
                for ni in range(nnodes)]
COMPLETElist = [' '.join(COMPLETE1[taskii1[ni]:taskii2[ni]] +
                         COMPLETE2[taskii1[ni]:taskii2[ni]])
                for ni in range(nnodes)]

contents = ['''#!/bin/bash

#SBATCH --job-name=%s
#SBATCH --account=uio
#SBATCH --time=%02i:00:00

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=%i
#SBATCH --mail-type=ALL

#SBATCH --mem-per-cpu=3G
#SBATCH --qos=lowpri

source /cluster/bin/jobsetup
module load python2
module load R

cd $SCRATCH
mkdir R

cp /cluster/home/kojito/nora10/scripts_redo/*.txt.bz2 .
cp /cluster/home/kojito/nora10/scripts_redo/*.R .
cp /cluster/home/kojito/nora10/scripts_redo/nora10interpmain.py .
cp /cluster/home/kojito/nora10/scripts_redo/checkfiles.py .
cp /cluster/home/kojito/nora10/scripts_redo/locations/*.csv . 
cp -R /cluster/home/kojito/R/x86_64-unknown-linux-gnu-library/3.0/intervals R/
cp -R /cluster/home/kojito/R/x86_64-unknown-linux-gnu-library/3.0/sp R/
cp -R /cluster/home/kojito/R/x86_64-unknown-linux-gnu-library/3.0/gstat R/
cp -R /cluster/software/VERSIONS/R-3.0.2/lib64/R/library/methods R/

# export OMP_NUM_THREADS=1

%s

python checkfiles.py %s

''' % 
(longjobnames[ni], 
 requiredhourslist[ni], 
 taskii2[ni] - taskii1[ni], 
 commandslist[ni], 
 COMPLETElist[ni]) 
for ni in range(nnodes)]

if not os.path.exists(jobscriptsdir): os.makedirs(jobscriptsdir)

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






