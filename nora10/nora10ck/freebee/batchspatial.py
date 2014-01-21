years = [2007, 2008, 2009, 2010, 2011, 2012]
vars = ['ta_2m', 'pr', 'psl', 'rss', 'rls', 'wss_10m', 'hur_2m']
hourres = ['1H', '1H', '1H', '3H', '3H', '1H', '1H']
b11b = 'NORA10'
b11c = '11km'

paths = ['%s_%s_%s_%s_%s.nc' % (b11b, hourres[vi], b11c, vars[vi], y) 
         for vi in range(len(vars)) for y in years]
commands = ['Rscript spatial_interpolation.R --args %s' % p for p in paths]

f = open('batchspatial.sh', 'w')
f.write(' &\n'.join(commands))
f.write(' &\n')
f.close()




