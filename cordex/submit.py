import os

jsd = 'jobscripts'

js = os.listdir(jsd)
commands = ['submit %s' % os.path.join(jsd, f) for f in js]
for command in commands:
    os.system(command)


