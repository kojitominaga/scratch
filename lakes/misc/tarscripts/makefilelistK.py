import os
count = 0
with open('listKzt', 'w') as f:
    for root, dirs, files in os.walk('.'):
        tzt = [file for file in files if 'Kzt.csv.gz' in file]
        for tztfile in tzt:
            p = os.path.join(root, tztfile)
            f.write(p) ; f.write('\n')
            count += 1
            if count % 1000 == 0:
                print(p)


                

