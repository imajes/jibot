#!/usr/bin/python

import csv

def out(n,d):
    print "insert into defs (nick, def) values ('%s', '%s');" % (n.lower().replace("'","''"),d.replace("'", "''"))

print "drop TABLE defs;"
print "drop TABLE def;"
print """CREATE TABLE defs (pkey INTEGER PRIMARY KEY AUTOINCREMENT,  nick VARCHAR,  def VARCHAR);"""

f = open('def2.csv', 'r')
dialect = csv.Sniffer().sniff(f.read())
f.seek(0)
reader = csv.reader(f, dialect=dialect) 


for line in reader:
    nick, str_defs = line[0], line[1]
    if ' ' in nick: continue
    if not ' & ' in str_defs:
        out(nick, str_defs)
        continue
    defs = str_defs.split(" & ")
    for d in defs:
        out(nick, d)

f.close()

print "CREATE INDEX defs_idx on defs(nick);"