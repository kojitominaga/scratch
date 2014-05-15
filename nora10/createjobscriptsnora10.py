'''example:
python createjobscriptsnora10.py test6 10.72 59.9423 94 /work/users/kojito/nora10/nc/pr/NORA10_1H_11km_pr_ 2010 2012 /work/users/kojito/nora10/nc/orog/NORA10_11km_orog.nc testjobscript.sh 
'''

import os
import sys
import math

lname, llon, llat, lalt = sys.argv[1:5]
ncpathprefix = sys.argv[5]  # /path/to/nc/file_**.nc
start, end = map(int, sys.argv[6:8])  # 1985, 2012
orogfn = sys.argv[8]
jbfpath = sys.argv[9]  # testjobscript.sh
jobname = os.path.splitext(os.path.basename(jbfpath))[0]

years = range(start, end + 1)

modulecommands = '''
source /cluster/bin/jobsetup
module purge
module load R
module load python2/2.7.6
'''

project = 'nn9317k'  # 'uio'
walltime = '%02d:00:00' % int(1 + math.ceil(len(years) * 4.0 / 60.0))
mem = '6G'

ncfiles = ['%s%s.nc' % (ncpathprefix, y) for y in years]

pythoncommandinitial = 'python nora10abel.py %s %s %s %s %s %s . 500 True' % (
    ncfiles[0], orogfn, lname, llon, llat, lalt)
pythoncommands = ['python nora10abel.py %s %s %s %s %s %s' % (
    f, orogfn, lname, llon, llat, lalt) for f in ncfiles]

with open(jbfpath, 'w') as jf:
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
    jf.write(pythoncommandinitial)
    jf.write('\n')
    jf.write('\n'.join(pythoncommands))
    jf.write('\n')    

