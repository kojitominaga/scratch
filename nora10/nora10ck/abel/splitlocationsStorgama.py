import os.path

neach = 1

f = open('locationsStorgama.csv')
header = f.readline()
lines = f.readlines()
f.close()

nlines = len(lines)
nsplits = nlines / neach if nlines % neach == 0 else nlines // neach + 1

if not os.path.exists('locations'): os.makedirs('locations')

fnames = [os.path.join('locations', 'loc%03i.csv' % i) for i in range(nsplits)]
starts = range(0, nlines, neach)
ends = starts[1:] + [nlines]

outs = [''.join([header] + lines[starts[i]:ends[i]]) for i in range(nsplits)] 
## lines already include \n at the end

for i in range(nsplits):
    f = open(fnames[i], 'w')
    f.write(outs[i])
    f.close()


