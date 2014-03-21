import os

triples = os.walk('/work/users/kojito/nora10/interpolated/')
doubles = [(rootpath, files) for rootpath, dirs, files in triples 
           if len(dirs) == 0]

for r, files in doubles:
    redoflag = False
    if 'COMPLETED' not in files:
        print('%s is not completed' % r)
        redoflag = True
    else:
        for f in files:
            fullpath = os.path.join(r, f)
            size = os.stat(fullpath).st_size
            if size == 0:
                print('%s is empty' % fullpath)
                redoflag = True
    if redoflag:
        for f in files:
            fullpath = os.path.join(r, f)
            print('  deleting %s...' % fullpath)
            os.unlink(fullpath)
        ## intermediates
        rinterm = r.replace('interpolated', 'intermediate')
        filesinterm = os.listdir(rinterm)
        for finterm in filesinterm:
            fullpath = os.path.join(rinterm, finterm)
            print('  deleting %s...' % fullpath)
            os.unlink(fullpath)

triples = os.walk('/work/users/kojito/nora10/interpolated/')
emptyroots = [rootpath for rootpath, dirs, files in triples
              if len(dirs) == 0 and len(files) == 0]

redoinfo = [p.split('/')[-4:] for p in emptyroots]
outstring = '\n'.join([' '.join(e) for e in redoinfo])
with open('redo.txt', 'w') as f:
    f.write(outstring)

            
