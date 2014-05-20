import os
import shutil

dirs = os.listdir('SwedishBathymetry')
dirs = [d for d in dirs if not d[0] == '.']

for d in dirs:
    dbf = os.path.join('SwedishBathymetry', d, d + '.dbf')
    dbfmod = os.path.join('SwedishBathymetry', d, d + 'mod.dbf')
    if not os.path.exists(dbf):
        shutil.rmtree(os.path.join('SwedishBathymetry', d))
        continue 
    if not os.path.exists(dbfmod):
        shutil.copyfile(os.path.join('SwedishBathymetry', d, d + '.dbf'), 
                        os.path.join('SwedishBathymetry', d, d + 'mod.dbf'))
    shutil.copyfile(os.path.join('SwedishBathymetry', d, d + '.sbn'), 
                    os.path.join('SwedishBathymetry', d, d + 'mod.sbn'))
    shutil.copyfile(os.path.join('SwedishBathymetry', d, d + '.sbx'), 
                    os.path.join('SwedishBathymetry', d, d + 'mod.sbx'))
    shutil.copyfile(os.path.join('SwedishBathymetry', d, d + '.shx'), 
                    os.path.join('SwedishBathymetry', d, d + 'mod.shx'))
    shutil.copyfile(os.path.join('SwedishBathymetry', d, d + '.shp'), 
                    os.path.join('SwedishBathymetry', d, d + 'mod.shp'))
    if not os.path.exists(os.path.join('SwedishBathymetry', d, d + '.prj')):
        shutil.copyfile(os.path.join('SwedishBathymetry', '0-0001', '0-0001.prj'), 
                        os.path.join('SwedishBathymetry', d, d + '.prj'))
        shutil.copyfile(os.path.join('SwedishBathymetry', '0-0001', '0-0001.prj'), 
                        os.path.join('SwedishBathymetry', d, d + 'mod.prj'))
    else:
        shutil.copyfile(os.path.join('SwedishBathymetry', d, d + '.prj'), 
                        os.path.join('SwedishBathymetry', d, d + 'mod.prj'))
    
