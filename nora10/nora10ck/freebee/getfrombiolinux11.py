years = [2011]
vars = ['ta_2m', 'pr', 'psl', 'rss', 'rls', 'wss_10m', 'hur_2m', 'albedo']
b11a = 'biolinux11.uio.no:/data2/nora10'
b11b = 'NORA10'
b11c = '11km'
hourres = ['1H', '1H', '1H', '3H', '3H', '1H', '1H', '1H']

paths = ['%s/%s/%s_%s_%s_%s_%s.nc' % 
         (b11a, vars[vi], b11b, hourres[vi], b11c, vars[vi], y) 
         for vi in range(len(vars)) for y in years]

out = '\n'.join(['scp -C %s ./' % p for p in paths])
f = open('getfrombiolinux11.sh', 'w')
f.write(out)
f.close()


