years = range(1988, 2000)
vars = ['ta_2m', 'pr', 'psl', 'rss', 'rls', 'wss_10m', 'hur_2m', 'albedo', 'ps', 'ts_0m']
hourres = ['1H', '1H', '1H', '3H', '3H', '1H', '1H', '1H', '3H', '1H']
b11b = 'NORA10'
b11c = '11km'

paths = ['%s_%s_%s_%s_%s.nc' % (b11b, hourres[vi], b11c, vars[vi], y) 
         for vi in range(len(vars)) for y in years]
commands1 = ['Rscript spatial_interpolation_part_1.R --args %s' % p for p in paths]
commands2 = ['Rscript spatial_interpolation_part_2.R --args %s' % p for p in paths]
# commands = ['%s ; %s' % (commands1[i], commands2[i]) for i in range(len(commands1))]
commands = commands2

ncpu = 33
neach = len(commands) / ncpu + 1
added = 0
finishflag = False
batchfiles = []
bi = 0
while True:
    bfn = 'batch%02i.sh' % bi
    batchfiles = batchfiles + [bfn]
    if (added + neach) < len(commands):
        out = ' ; '.join(commands[added:(added + neach)])
        added = added + neach
    else:
        out = ' ; '.join(commands[added:len(commands)])
        finishflag = True
    f = open(bfn, 'w')
    f.write(out)
    f.close()
    bi = bi + 1
    if finishflag:
        break

f = open('batchbatch.sh', 'w')
out = ' & '.join(['bash %s' % b for b in batchfiles]) + ' &\n'
f.write(out)
f.close()


