import os
import sys
import time

files = sys.argv[1:]

finished = [False for f in files]
checklist = dict(zip(files, finished))

time.sleep(180)
wait = 120

while not all(checklist.values()):
    wait = min(wait * 1.05, 30 * 60)
    time.sleep(wait)
    print('[checkfiles.py] %i out of %i finished' % (sum(checklist.values()), 
                                                     len(checklist)))
    for f in checklist.keys():
        if not checklist[f]:
            checklist[f] = os.path.exists(f)
            if checklist[f]:
                print('[checkfiles.py] ' + f + ' is now finished')
print('[checkfiles.py] all files finished')

