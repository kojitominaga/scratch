from HTMLParser import HTMLParser

with open('ecco_norstore.html') as f:
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
modelcounts = {m: len([u for u in lakes if m in u]) for m in models}
for m in models:
    print(m)
    vars = set([u.split('_')[1] for u in lakes if m in u])
    varcounts = {v: len([u for u in lakes if v in u and m in u]) 
                 for v in vars}
    print(varcounts)

catchments = [url for url in p.urls if 'Catchment' in url]
models = set([u.split('_')[6] for u in catchments])
modelcounts = {m: len([u for u in catchments if m in u]) for m in models}
for m in models:
    print(m)
    vars = set([u.split('_')[1] for u in catchments if m in u])
    varcounts = {v: len([u for u in catchments if v in u and m in u]) 
                 for v in vars}
    print(varcounts)

# IPSL
with open('IPSL-lakes.sh', 'w') as f:
    f.write('wget ')
    f.write('\nwget '.join([u for u in lakes if 'IPSL' in u]))

# DMI
with open('DMI-lakes.sh', 'w') as f:
    f.write('wget ')
    f.write('\nwget '.join([u for u in lakes if 'DMI' in u]))






