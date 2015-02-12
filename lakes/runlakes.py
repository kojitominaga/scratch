import mylake
import sys 
import math

i = int(sys.argv[1])
with open('Feb2015GranadaList.csv', 'rU') as f:
    throwaway = f.readline()
    lines = f.readlines()

nlines = len(lines)
nlinesperjob = int(math.ceil(nlines / 300.0))

ii = range(nlinesperjob * i, 
           nlines if nlinesperjob * (i + 1) > nlines else nlinesperjob * (i + 1))

for thisi in ii:
    ebint, ebhex, depth, area, longitude, latitude = lines[thisi].strip().split(',')
    print('running lake %s' % ebhex)
    mylake.runlake(1, 1, ebhex.strip('"'), max(float(depth), 4.0),
                   float(area), float(longitude), float(latitude))


    
