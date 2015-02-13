## usage: python2 submit.py modeli scenarioi nmaxjob hours

import os
import sys

modeli = int(sys.argv[1])
scenarioi = int(sys.argv[2])
njobs = int(sys.argv[3])
hours = int(sys.argv[4])
csvf = sys.argv[5]

if not os.path.exists('jobscripts'):
    os.makedirs('jobscripts')

for i in range(njobs):
    jname = '%d_%d_%03d' % (modeli, scenarioi, i)
    jsfname = '%s.sh' % jname
    jspath = os.path.join('jobscripts', jsfname)
    out = '''#!/bin/bash

#SBATCH --job-name=%s
#SBATCH --account=uio
#SBATCH --time=%d:00:00

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
python runlakes.py %d %d %d %d %s
''' % (jname, hours, modeli, scenarioi, i, njobs, csvf)
    with open(jspath, 'w') as f:
        f.write(out)
    os.system('submit %s' % jspath)





