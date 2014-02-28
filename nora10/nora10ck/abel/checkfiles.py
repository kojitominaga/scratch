import os
import sys
import time

files = sys.argv[1:]

finished = [False for f in files]
checklist = dict(zip(files, finished))

time.sleep(180)
wait = 120
count = 0
while not all(checklist.values()):
    count += 1
    wait = min(wait * 1.05, 30 * 60)
    time.sleep(wait)
    print('[checkfiles.py:%i] %i out of %i finished' % (
        count, sum(checklist.values()), len(checklist)))
    for f in checklist.keys():
        if not checklist[f]:
            checklist[f] = os.path.exists(f)
            if checklist[f]:
                print('[checkfiles.py] ' + f + ' is now finished')
print('[checkfiles.py] all files finished')

