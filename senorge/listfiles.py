import os
d = '/Volumes/Seagate Expansion Drive/SeNorge'
vars = ['bn', 'eva', 'frd', 'gwt', 'is', 'os', 'q', 'rr',
        'sd', 'smd', 'swe', 'tm']
# Massebalanse isbre (mm/døgn) gwb_bn_2014_06_15.asc 
# Fordampning (mm/døgn) gwb_eva_2014_06_15.asc
# Frostdyp  (mm/døgn) gwb_frd_2014_06_15.asc
# Grunnvannsmagasin (mm) gwb_gwt_2014_06_15.asc
# Infiltrasjon i rotsonen (mm/døgn) gwb_is_2014_06_15.asc
# Perkolasjon fra rotsonen til grunnvansonen  (mm/døgn) gwb_os_2014_06_15.asc
# Avrenning  (mm/døgn) gwb_q_2014_06_15.asc
# Nedbør (mm/døgn) gwb_rr_2014_06_15.asc
# Snødyp (mm) gwb_sd_2014_06_15.asc
# Markvannsunderskudd (mm) gwb_smd_2014_06_15.asc
# Snøens vannekvivalent (mm) gwb_swe_2014_06_15.asc
# Temperatur (°C) gwb_tm_2014_06_15.asc

counts = {}
for year in range(1957, 2015):
    fns = os.listdir(os.path.join(d, 'gwb_ascii_%s' % year))
    counts[year] = [len([f for f in fns if v in f]) for v in vars]

out = ' '.join(['year'] + vars)
out += '\n'
out += '\n'.join([' '.join(map(str, [e] + counts[e])) for e in counts.keys()])
out += '\n'

    
