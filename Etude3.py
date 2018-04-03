#!/usr/bin/python
# vim: set fileencoding=utf-8 :
 
#
# Fichier: col-1-and-3.py
#
 
import csv
 
fname = "table.csv"
file = open(fname, "rb")
 
try:
    reader = csv.reader(file)
    for row in reader:
        #
        # N'affiche que certaines colonnes
        #
        print row[0],row[2]
finally:
    file.close()
