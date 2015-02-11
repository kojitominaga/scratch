import os

# dest = '/work/users/kojito/cordex'
url1 = 'http://ecco.norstore.uio.no/Lakes_'
url2 = '_EUR-11_'

# 0 reserved for NORA10
scenarios = {1: (('historical', '19710101', '19751231'), 
                 ('historical', '19760101', '19801231')), 
             2: (('historical', '20000101', '20051231'),
                 ('rcp45', '20060101', '20101231')), 
             3: (('rcp45', '20310101', '20351231'),
                 ('rcp45', '20360101', '20401231')), 
             4: (('rcp45', '20610101', '20651231'),
                 ('rcp45', '20660101', '20701231')), 
             5: (('rcp45', '20910101', '20951231'),
                 ('rcp45', '20960101', '21001231')), 
             6: (('rcp85', '20310101', '20351231'),
                 ('rcp85', '20360101', '20401231')), 
             7: (('rcp85', '20610101', '20651231'),
                 ('rcp85', '20660101', '20701231')), 
             8: (('rcp85', '20910101', '20951231'),
                 ('rcp85', '20960101', '21001231'))}
             
models = {1: ('ICHEC-EC-EARTH', 'r1i1p1_KNMI-RACMO22E_v1'), 
          2: ('ICHEC-EC-EARTH', 'r3i1p1_DMI-HIRHAM5_v1'), 
          3: ('MPI-M-MPI-ESM-LR', 'r1i1p1_CLMcom-CCLM4-8-17_v1')}
## IPSL not complete?
## SMHI not on real calendar?

variables = ['clt', 'hurs', 'tas', 'rsds', 'ps', 'pr', 'sfcWind']

urlsA = ['%s%s%s%s_%s_%s_day_%s-%s.h5.gz' % 
         (url1, v, url2, m0, s0[0], m1, s0[1], s0[2])
         for m0, m1 in models.values() for s0, s1 in [scenarios[1]]
         for v in variables]
urlsB = ['%s%s%s%s_%s_%s_day_%s-%s.h5.gz' % 
         (url1, v, url2, m0, s0[0], m1, s1[1], s1[2])
         for m0, m1 in models.values() for s0, s1 in [scenarios[1]]
         for v in variables]
urls = urlsA + urlsB

commands = ['wget %s' % url for url in urls]
os.system(' & '.join(commands))

