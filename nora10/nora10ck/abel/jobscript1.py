import os

years = range(1958, 2013)

if not os.path.exists('jobscripts'):
    os.makedirs('jobscripts')

fnames = ['jobscripts/ts_0m_%s.sh' % year for year in years]
contents = ['''#!/bin/bash

#SBATCH --job-name=firsttrial
#SBATCH --account=uio
#SBATCH --time=06:00:00

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=ALL

#SBATCH --mem-per-cpu=3G

source /cluster/bin/jobsetup
module load python2
module load R

cp /cluster/home/kojito/nora10/scripts/* $SCRATCH

export OMP_NUM_THREADS=1

cd $SCRATCH

python nora10interpmain.py /work/users/kojito/nora10/nc/ts_0m/NORA10_1H_11km_ts_0m_%s.nc locations.csv $SCRATCH
''' % year for year in years]

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

