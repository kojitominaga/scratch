## usage: python2 runlakes.py modeli scenarioi jobi nmaxjob
##   modeli model id
##   scearioi scenario id
##   job i of n max job 


import mylake
import sys 
import math

modeli = int(sys.argv[1])
scenarioi = int(sys.argv[2])
i = int(sys.argv[3])
nmaxjob = float(sys.argv[4])
csvf = sys.argv[5]

with open(csvf, 'rU') as f:
    throwaway = f.readline()
    lines = f.readlines()

nlines = len(lines)
nlinesperjob = int(math.ceil(nlines / nmaxjob))

ii = range(nlinesperjob * i, 
           nlines if nlinesperjob * (i + 1) > nlines else nlinesperjob * (i + 1))

for thisi in ii:
    ebi, ebh, depth, area, longitude, latitude = lines[thisi].strip().split(',')
    print('running lake %s' % ebh)
    mylake.runlake(modeli, scenarioi, ebh.strip('"'), max(float(depth), 4.0),
                   float(area), float(longitude), float(latitude))


    