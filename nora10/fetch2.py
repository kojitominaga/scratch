import urllib

## testing with the ERA40 simulation
address1 = "ftp://ftp.met.no/projects/nora10/NORA10_1H_11km_pr_"
address2 = range(1958, 2013)
address3 = ".nc"

addresses = ['%s%s%s' % (address1, address2[i], address3) 
             for i in range(len(address2))]

f = open('fetch.sh', 'w')
out = '\n'.join(['wget %s' % a for a in addresses])
f.write(out)
f.close()


    

