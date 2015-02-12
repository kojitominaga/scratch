import os

if not os.path.exists('jobscripts'):
    os.makedirs('jobscripts')

njobs = 300
for i in range(njobs):
    jsfname = '%03d.sh' % i
    jspath = os.path.join('jobscripts', jsfname)
    out = '''#!/bin/bash

#SBATCH --job-name=%03d
#SBATCH --account=uio
#SBATCH --time=1:20:00

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=ALL

#SBATCH --mem-per-cpu=1G
#SBATCH --qos=lowpri

source /cluster/bin/jobsetup
module load python2/2.7.9
module load octave

cd /work/users/kojito/lakes
python runlakes.py %d
''' % (i, i)
    with open(jspath, 'w') as f:
        f.write(out)
    os.system('submit %s' % jspath)





