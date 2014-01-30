years = range(1988, 2013)
vars = ['ta_2m', 'pr', 'psl', 'rss', 'rls', 'wss_10m', 'hur_2m', 
        'albedo', 'ps', 'ts_0m']
hourres = ['1H', '1H', '1H', '3H', '3H', '1H', '1H', '1H', '3H', '1H']
b11b = 'NORA10'
b11c = '11km'

paths = ['%s_%s_%s_%s_%s.nc' % (b11b, hourres[vi], b11c, vars[vi], y) 
         for vi in range(9) for y in years]
commands = ['Rscript sample_variogram.R --args %s &' % p for p in paths]

f = open('sample_variogram_batch.sh', 'w')
f.write('\n'.join(commands))
f.close()


