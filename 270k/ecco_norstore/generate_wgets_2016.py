from HTMLParser import HTMLParser

with open('ecco_norstore_2016.html') as f:
    s = f.read()

class myparser(HTMLParser):
    def __init__(self):
        HTMLParser.__init__(self)
        self.urls = []
    def handle_starttag(self, tag, attributes):
        if tag == 'a':
            for name, value in attributes:
                if name == 'href':
                    self.urls.append(value)

p = myparser()
p.feed(s)

lakes = [url for url in p.urls if 'Lakes' in url]
models = set([u.split('_')[6] for u in lakes])
models = [m for m in models if 'SMHI' not in m]

vars = ['clt', 'pr', 'ps', 'rsds', 'sfcWind', 'tas_', 'hurs', 'huss']


print('ALL FILES')
for m in models:
    print(m) 
    for v in vars:
        sublakes = [u for u in lakes if v in u and m in u]
        yrex = [u.split('_')[9].split('-')[1][:4] + u.split('_')[4][:5] for u in sublakes]
        print('% 8s: ' % v.strip('_') + ' '.join(yrex))

print('\n')
print('RELEVANT FILES ONLY')
for m in models:
    print(m) 
    for v in vars:
        sublakes = [u for u in lakes if 
                    v in u and m in u
                    and not 'CNRM' in u]
        yrex = [u.split('_')[9].split('-')[1][:4] + u.split('_')[4][:5] for u in sublakes]
        yrexrelevant = [u for u in yrex if
                        u in ['2005histo', '2010rcp45', '2035rcp85',
                              '2040rcp85', '2065rcp85', '2070rcp85',
                              '2095rcp85', '2100rcp85']]
        print('% 8s: ' % v.strip('_') + ' '.join(yrexrelevant))


# modelcounts = {m: len([u for u in lakes if m in u]) for m in models}
# for m in models:
#     print(m)
#     vars = set([u.split('_')[1] for u in lakes if m in u])
#     varcounts = {v: len([u for u in lakes if v in u and m in u]) 
#                  for v in vars}
#     print(varcounts)

# catchments = [url for url in p.urls if 'Catchment' in url]
# models = set([u.split('_')[6] for u in catchments])
# modelcounts = {m: len([u for u in catchments if m in u]) for m in models}
# for m in models:
#     print(m)
#     vars = set([u.split('_')[1] for u in catchments if m in u])
#     varcounts = {v: len([u for u in catchments if v in u and m in u]) 
#                  for v in vars}
#     print(varcounts)

# # IPSL
# with open('IPSL-lakes.sh', 'w') as f:
#     f.write('wget ')
#     f.write('\nwget '.join([u for u in lakes if 'IPSL' in u]))

# # DMI
# with open('DMI-lakes.sh', 'w') as f:
#     f.write('wget ')
#     f.write('\nwget '.join([u for u in lakes if 'DMI' in u]))






