import urllib

address1 = "NORA10_1H_11km_pr_"
address2 = range(1958, 2013)
address3 = ".nc"

addresses = ['%s%s%s' % (address1, address2[i], address3) 
             for i in range(len(address2))]

f = open('checkmd5.sh', 'w')
out = '\n'.join(['md5sum %s > %s.md5' % (a, a) for a in addresses])
f.write(out)
f.close()


    

