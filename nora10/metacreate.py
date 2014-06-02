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

def customsubmit(varname, timeres, name, lat, lon, alt, initial = False):
    cm = cmda if initial else cmd
    scriptfname = '%s_%s.sh' % ('C' + name[6:], varname)
    c = '%s %s %s %s %s %s/%s/NORA10_%s_11km_%s_ %s %s %s %s' % (
        cm, name, lon, lat, alt, ncdir, varname, timeres, varname, 
        start, end, orog, scriptfname)
    os.system(c)
    os.system('submit %s' % scriptfname)    

for name, lat, lon, alt in g:
    # customsubmit('ta_2m', '1H', name, lat, lon, alt, initial=True)
    # customsubmit('pr', '1H', name, lat, lon, alt)
    # customsubmit('wss_10m', '1H', name, lat, lon, alt)
    # customsubmit('hur_2m', '1H', name, lat, lon, alt)
    # customsubmit('ps', '3H', name, lat, lon, alt)
    # customsubmit('clt', '1H', name, lat, lon, alt)
    # customsubmit('albedo', '1H', name, lat, lon, alt)
    customsubmit('rls', '1H', name, lat, lon, alt)
    # customsubmit('rss', '1H', name, lat, lon, alt)


        
