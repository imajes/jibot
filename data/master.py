#!/usr/bin/python

def out(m,a):
    print "insert into masternick values ('%s', '%s');" % (m,a.lower())

print "drop TABLE masternick;"
print "CREATE TABLE masternick (master VARCHAR, alias VARCHAR);"

f = open('master.csv', 'r')

for line in f.read().split():
    try:
        (master, str_aliases) = line.split(',')
    except:
        continue
    if not '+&+' in str_aliases:
        out(master, str_aliases)
        continue
    aliases = str_aliases.split("+&+")
    for a in aliases:
        out(master,a)

f.close()

print "CREATE INDEX masternick_idx on masternick(alias);"