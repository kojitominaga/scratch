import os
import tarfile

triples = [(r, d, f) for r, d, f 
           in os.walk('/work/users/kojito/nora10/interpolated')]
ntriples = len(triples)

i = 0
with tarfile.open('interpolated.tar', 'w:') as t:
    for r, d, files in triples:
        i += 1
        print('-- %s of %s' % (i, ntriples))
        if not len(d) == 0:
            continue 
        if len(f) == 0:
            continue
        for f in files:
            p = os.path.join(r, f)
            print('  ' + p)
            t.add(p, arcname = p)


