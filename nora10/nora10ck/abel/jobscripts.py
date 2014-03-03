'''version that handle more than one task per node'''
import os
import math
import sys

jobscriptsdir = 'jobscripts'
submitshname = 'submit.sh'

ntaskspernode = 15

burden = 1.5
# estimated time in min per interpolation 
# (i.e., per location, per time point)

neach = 1
if not neach == 1: sys.exit('neach > 1 not supported now')

tarsplitn = 100

years = range(1999, 2005)
varH = {'clt': '1H', 
        'albedo': '1H', 
        'ta_2m': '1H',
        'ts_0m':  '1H', 
        'pr':     '1H',
        'psl':    '1H', 
        'ps':     '3H', 
        'wss_10m': '1H', 
        'hur_2m': '1H'}
# 'clt': '1H'
# # 'albedo': '1H'}


# varH = {'ps': '3H'}
# varH = {'ta_2m':  '1H'} # , 
#         # 'rss':    '3H', 
#         # 'rls':    '3H', 


# ntimedict = {'3H': 5, '1H': 5}
ntimedict = {'3H': 'mean8', '1H': 'mean24'}
# ntimedict = {'3H': 'all', '1H': 'all'}

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
namelocs = [None] * len(locfns)
for i in range(len(locfns)):
    locfn = locfns[i]
    f = open(locfn, 'r')
    header = f.readline()
    lines = f.readlines()
    nlocs[i] = len([line for line in lines if len(line.strip()) > 0])
    namelocslist = [line.strip().split(',')[0] 
                    for line in lines if len(line.strip()) > 0]
    if len(namelocslist) > 1:
        sys.exit('more than one locations not supported at the moment')
    namelocs[i] = namelocslist[0]
    # if something is written
    f.close()

locdict = dict(zip(locfns, nlocs))
locnamedict = dict(zip(locfns, namelocs))
# locdict = dict([(locfns[i], nlocs[i]) for i in range(len(locfns))])
# locnamedict = dict([(locfns[i], namelocs[i]) for i in range(len(locfns))])
# use zip()?

iii = len(years) * len(locdict) * len(varH)
taskii1 = range(0, iii, ntaskspernode)
taskii2 = taskii1[1:] + [iii]
nnodes = len(taskii1)
taskii = [range(taskii1[j], taskii2[j]) for j in range(nnodes)]

jobnames = ['%s%03i%02i%s' % 
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
             varname, H, varname, year, 
             os.path.basename(locfn),  ## local at $SCRATCH
             tarsplitn, ntimedict[H]) 
            for year in years 
            for (locfn, nloc) in locdict.items()
            for (varname, H) in varH.items()]
COMPLETE1 = [os.path.join('/work/users/kojito/nora10/', 
                          'intermediate',
                          locnamedict[locfn],
                          varname, 
                          str(ntimedict[H]), 
                          str(year), 
                          'COMPLETED')
             for year in years 
             for (locfn, nloc) in locdict.items()
             for (varname, H) in varH.items()]
COMPLETE2 = [os.path.join('/work/users/kojito/nora10/', 
                          'interpolated', 
                          locnamedict[locfn],
                          varname, 
                          str(ntimedict[H]), 
                          str(year),
                          'COMPLETED')
             for year in years 
             for (locfn, nloc) in locdict.items()
             for (varname, H) in varH.items()]

requiredhours = \
  [{'all': (365 * 24 / int(H[0])),
    'mean24': 365, 
    'mean8': 365}.setdefault(
        ntimedict[H], ## key
        int(ntimedict[H]) if str(ntimedict[H]).isdigit() else None) * ## default value
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

cp /cluster/home/kojito/nora10/scripts/*.txt.bz2 .
cp /cluster/home/kojito/nora10/scripts/*.R .
cp /cluster/home/kojito/nora10/scripts/nora10interpmain.py .
cp /cluster/home/kojito/nora10/scripts/checkfiles.py .
cp /cluster/home/kojito/nora10/scripts/locations/*.csv . 
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

