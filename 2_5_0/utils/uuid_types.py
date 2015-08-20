#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
 uuid_types.py  Pluggable Concept Model Types

A utility to extract the PCM id (complexType name attribute) from all CCDs is a directory and create a CSV file,
listing each UUID and the RM  type it is associated with.  This is useful in many other tools where parsing data in XML or JSON.

"""
import os
import sys
import re
from datetime import datetime
import configparser
from lxml import etree

config = configparser.ConfigParser()
config.read('utils.ini')

def getfiles(path):
    # returns a list of all files in a directory
    for file in os.listdir(path):
        if os.path.isfile(os.path.join(path, file)):
            yield file


def pcmmain():
    rootdir = '.'
    nsDict = {'xs': 'http://www.w3.org/2001/XMLSchema',
              'rdf': 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
              'rdfs': 'http://www.w3.org/2000/01/rdf-schema#',
              'mlhim2': 'http://www.mlhim.org/ns/mlhim2/'}

    parser = etree.XMLParser(ns_clean=True, recover=True, resolve_entities=False, remove_comments=True)
    CCDPATH = config.get('Locations', 'CCDPATH')

    # if a pcm_types.csv exists the overwrite it with a new header string
    f = open(CCDPATH+'uuid_types.csv', 'w')
    f.write('uuid,rmtype\n')
    f.close()

    files = getfiles(CCDPATH)
    uuids = {}

    for f in files:
        if f[-3:] != 'xsd':
            continue

        rm = etree.XPath("//xs:include/@schemaLocation", namespaces=nsDict)
        uuidfile = CCDPATH + "uuid_types.csv"
        print("\n\nCreating: ", uuidfile + " from: ", CCDPATH + f)

        src = open(CCDPATH + f, 'r')

        dest = open(uuidfile, 'a')

        tree = etree.parse(src, parser)
        root = tree.getroot()

        for x in root.xpath("//xs:complexType", namespaces=nsDict):
            ctid = x.xpath('@name')[0].replace('pcm-','')
            tname = x.xpath('./xs:complexContent/xs:restriction/@base', namespaces=nsDict)[0].replace('mlhim2:','').replace('Type','')
            uuids.setdefault(ctid,[]).append(tname)


        for u in sorted(uuids.keys()):
            dest.write( u+','+ uuids[u][0]+ '\n')

        src.close()
        dest.close()

    return

if __name__ == '__main__':

    pcmmain()
    print("\n\nFinished  " + datetime.now().strftime("%Y-%m-%d %H:%M") + " \n\n")
    sys.exit(0)
