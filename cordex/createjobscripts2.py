import os

if not os.path.exists('jobscripts'): os.makedirs('jobscripts')

experiments = ['historical', 'rcp45', 'rcp85']
variables = ['mrros', 'pr', 'tas', 'tasmin', 'tasmax']


modulecommands = '''
source /cluster/bin/jobsetup
module purge
module load R
module load geos
module load gdal
module load netcdf
module unload R
module load R
'''

project = 'nn9317k'
walltime = '40:00:00'
mem = '8G'

if not os.path.exists('csv'):
    os.makedirs('csv')

ncdir = 'ncAugustSoren'

allncfiles = [f for f in os.listdir(ncdir) if os.path.splitext(f)[1] == '.nc']

for e in experiments:
    orogfn = [f for f in allncfiles if 'orog' in f and e in f][0]
    orogpath = os.path.join(ncdir, orogfn)
    ncfiles = [f for f in allncfiles if not ('orog' in f) and e in f]
    ncpaths = [os.path.join(ncdir, f) for f in ncfiles]
    vs = [f.split('_')[0] for f in ncfiles]
    tranges = [f.split('_')[-1].split('.nc')[0] for f in ncfiles]
    fnp1s = ['csv/%s_%s_%s_pred_n1k.csv' % (v, e, trange) 
             for v, trange in zip(vs, tranges)]
    fnp2s = ['csv/%s_%s_%s_pred_regin.csv' % (v, e, trange) 
             for v, trange in zip(vs, tranges)]
    fnv1s = ['csv/%s_%s_%s_var_n1k.csv' % (v, e, trange) 
             for v, trange in zip(vs, tranges)]
    fnv2s = ['csv/%s_%s_%s_var_regin.csv' % (v, e, trange) 
             for v, trange in zip(vs, tranges)]
    commands = ['Rscript spinterp_cordex_custom_abel.R --args %s %s %s %s %s %s %s' % 
                (s1, orogpath, s3, s4, s5, s6, s7) for s1, s3, s4, s5, s6, s7 in 
                zip(ncpaths, fnp1s, fnp2s, fnv1s, fnv2s, vs)]
    jobnames = ['%s_%s_%s' % (s1, e, s3) for s1, s3 in zip(vs, tranges)]
    jobscriptfns = ['jobscripts/%s.sh' % jn for jn in jobnames]
    for command, jobscriptfn, jobname in zip(commands, jobscriptfns, jobnames):
        with open(jobscriptfn, 'w') as jf:
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
            ## jf.write('#SBATCH --qos=lowpri\n')
            jf.write(modulecommands)
            jf.write('\n')
            jf.write(command)
            jf.write('\n')
            

        
