import os

comsatdirs = [d for d in os.listdir(os.path.join('..', 'mylake_inputs'))
              if 'COMSAT' in d]
inputfiles = \
  [os.path.join('..', 'mylake_inputs', d, 'i3co', 
                'NORA10_11km_interpolated_%s_%s_%s.mlinput' % (
                    '2007-2012', d, 'i3co')) 
   for d in comsatdirs]
initfiles = \
  [os.path.join('..', 'mylake_inputs', d, 'init', '1.5fielddepth_cone.mlinit')
   for d in comsatdirs]
parfiles = \
  [os.path.join('..', 'mylake_inputs', d, 'par', '18secchi_Minnesota.mlpar')
   for d in comsatdirs]
outdirs = \
  [os.path.join('..', 'mylake_outputs', d, 'i3co', 
                'NORA10_11km_interpolated_%s_%s_%s_%s_%s' % (
                '2007-2012', d, 'i3co', 
                '1.5fielddepth_cone', 
                '18secchi_Minnesota')) for d in comsatdirs]
for d in outdirs:
    if not os.path.exists(d): os.makedirs(d)

commands = \
  ['octave runmylake.m %s %s %s 2007 1 1 2012 12 31 %s' % (
      initf, parf, inputf, outd) 
   for initf, parf, inputf, outd in 
   zip(initfiles, parfiles, inputfiles, outdirs)]

with open('batch.sh', 'w') as f:
    f.write('\n'.join(commands))



