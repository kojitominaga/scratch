import os
files = [f for f in os.listdir('jobscripts') if '.sh' in f]
for f in files:
    os.system('sbatch jobscripts/%s' % f)
    
