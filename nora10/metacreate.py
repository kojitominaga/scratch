import os

with open('locationsCOMSAT.csv') as f:
    header = f.readline()
    g = [l.rstrip().split(',') for l in f.readlines()]
    ## all information in string, not numerics

cmda = 'python createjobscriptsnora10a.py'
cmd = 'python createjobscriptsnora10.py'
ncdir = '/work/users/kojito/nora10/nc'
start = '2007'
end = '2012' ## including the end
orog = '/work/users/kojito/nora10/nc/orog/NORA10_11km_orog_new3.nc'

for name, lat, lon, alt in g:
    scriptfname = '%s_ta.sh' % name
    c = '%s %s %s %s %s %s/ta_2m/NORA10_1H_11km_ta_2m_ %s %s %s %s' % (
        cmda, name, lon, lat, alt, ncdir, start, end, orog, scriptfname)
    os.system(c)
    os.system('submit %s' % scriptfname)
    print(c)

        
