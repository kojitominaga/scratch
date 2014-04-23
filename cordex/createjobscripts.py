import os

if not os.path.exists('jobscripts'): os.makedirs('jobscripts')

experiments = ['historical', 'rcp26', 'rcp45', 'rcp85']
variables = ['tas', 'tasmin', 'tasmax', 'pr', 'ps', 'psl', 'huss', 'sfcWind', 
             'clt', 'rsds', 'rlds', 'rsus', 'rlus', 'ts']

ncdir = '/work/users/kojito/cordex/nc/'
cordexdir = '/work/users/kojito/cordex/'

modulecommands = '''
source /cluster/bin/jobsetup
module purge
module load R
module load python2
module unload openmpi.intel/1.6.1
module load openmpi.intel/1.8
module load netcdf.intel
module unload intel/2011.10
'''

project = 'uio'
walltime = '06:00:00'
mem = '4G'

ncfiles = [f for f in os.listdir(ncdir) if os.path.splitext(f)[1] == '.nc']

for e in experiments:
    for v in variables:
        jobname = '%s_%s' % (e[:4], v)
        filestoprocess = [f for f in ncfiles if e in f and v in f]
        pythoncommands = ['python cordexabel.py %s %s %s %s %s %s %s' % (
            os.path.join(ncdir, f), 'OsloBlindern', 
            10.72, 59.9423, 94.0, cordexdir, 500)
            for f in filestoprocess]
        with open(os.path.join('jobscripts', jobname) + '.sh', 'w') as jf:
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
            jf.write('#SBATCH --qos=lowpri\n')
            jf.write(modulecommands)
            jf.write('cd %s\n' % cordexdir)
            jf.write('\n'.join(pythoncommands))
            jf.write('\n')
            
            
            
        
