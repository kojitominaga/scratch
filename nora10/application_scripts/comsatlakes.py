import sys
sys.path.insert(0, '..')
import os
import nora10util
import mylakeinput

names = [d for d in os.listdir(os.path.join('..', 'interpolated'))
         if d[:6] == 'COMSAT']

for location in names:
    outdir = os.path.join('..', 'collated', location)
    if not os.path.exists(outdir): os.makedirs(outdir)
    nora10util.byinterpmethodVariables(
        location, 'mean24', 'DM', range(2007, 2013),
        interpmethod='last', varnames='all', outdir=outdir, prefix='..')
    
for location in names:
    origindir = os.path.join('..', 'collated', location)
    outdir = os.path.join('..', 'mylake_inputs')
    print(origindir)
    mylakeinput.mylakeinput(origindir, outdir)
