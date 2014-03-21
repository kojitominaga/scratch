import os.path

neach = 1
assert neach == 1, 'only supporting neach == 1'

f = open('locations.csv')
header = f.readline()
lines = f.readlines()
f.close()

pairs = [(l.split(',')[0], l) for l in lines]

# nlines = len(lines)
# nsplits = nlines / neach if nlines % neach == 0 else nlines // neach + 1

# fnames = [os.path.join('locations', 'loc%03i.csv' % i) for i in range(nsplits)]
# starts = range(0, nlines, neach)
# ends = starts[1:] + [nlines]

# outs = [''.join([header] + lines[starts[i]:ends[i]]) for i in range(nsplits)] 
# ## lines already include \n at the end

if not os.path.exists('locations'): os.makedirs('locations')

for name, line in pairs:
    with open(os.path.join('locations', name + '.csv'), 'w') as f:
        f.write(header)
        f.write(line)
        


