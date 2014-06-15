import os
import sys
import math

years = range(1957, 2015)

modulecommands = '''
source /cluster/bin/jobsetup
module purge
module load gdal
module load R
'''

for year in years:
    project = 'nn9317k'  # 'uio'
    walltime = '24:00:00' 
    mem = '6G'
    jobname = 'sn%s' % year
    jobfn = '%s.sh' % jobname

    with open(jobfn, 'w') as jf:
        jf.write('#!/bin/sh\n')
        jf.write('#SBATCH --job-name=%s\n' % jobname)
        jf.write('#SBATCH --account=%s\n' % project)
        jf.write('#SBATCH --time=%s\n' % walltime)
        jf.write('#SBATCH --mem-per-cpu=%s\n' % mem)
        jf.write('#SBATCH --nodes=1\n')
        jf.write('#SBATCH --ntasks=1\n')
        jf.write('#SBATCH --nodes=1\n')
        jf.write('#SBATCH --cpus-per-task=1\n')
        jf.write('#SBATCH --mail-type=ALL\n')
        # jf.write('#SBATCH --qos=lowpri\n')
        jf.write(modulecommands)
        jf.write('Rscript extractSeNorge.R %s\n' % year)
    os.system('submit %s' % jobfn)


