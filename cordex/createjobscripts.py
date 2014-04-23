import os
import sys
import cordexabel

lname, llon, llat, lalt = sys.argv[1:5]

if not os.path.exists('jobscripts'): os.makedirs('jobscripts')

experiments = ['historical', 'rcp26', 'rcp45', 'rcp85']
variables = ['tas', 'tasmin', 'tasmax', 'pr', 'ps', 'psl', 'huss', 'sfcWind', 
             'clt', 'rsds', 'rlds', 'rsus', 'rlus', 'ts']

n = 500

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
    print('[createjobscripts.py] creating geography files')
    ncpath = \
      os.path.join(ncdir, [f for f in ncfiles if e in f and not 'orog' in f][0])
    ## any one with the e will suffice
    ncdir, ncfn = os.path.split(ncpath)
    orogfn = cordexabel.getorogfn(ncfn)
    orogpath = os.path.join(ncdir, orogfn)
    if not os.path.exists(orogpath):
        print('[createjobscripts.py] orogpath does not exist')
        pref = '_'.join(orogfn.split('_')[:4])
        suff = '_'.join(orogfn.split('_')[-3:])
        filelist = os.listdir(ncdir)
        alternatives = [f for f in filelist if pref in f and suff in f]
        if len(alternatives) > 0:
            print('[createjobscripts.py] found %s instead' % alternatives[0])
            orogfn = alternatives[0]
            orogpath = os.path.join(ncdir, orogfn)
        else: 
            sys.exit('[createjobscripts.py] ERROR: could not find the orog file')    
    geogdir = cordexabel.parsefn(orogfn, cordexdir)[0]
    isnearby, latpath, lonpath, altpath = \
      cordexabel.writegeog(orogpath, geogdir, lname, llat, llon, n, 
                           dummy = False)
    for v in variables:
        jobname = '%s%s%s' % (e[:4], v, lname)
        filestoprocess = [f for f in ncfiles if e in f and '%s_' % v in f]
        pythoncommands = ['python cordexabel.py %s %s %s %s %s %s %s' % (
            os.path.join(ncdir, f), lname, llon, llat, lalt, cordexdir, n) 
            for f in filestoprocess]
        pathout = os.path.join('jobscripts', jobname) + '.sh'
        print('[createjobscripts.py] creating %s' % pathout)
        with open(pathout, 'w') as jf:
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
            
            
            
        
