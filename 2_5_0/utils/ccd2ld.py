#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
 ccd2ld.py - CCD to Linked Data

A utility to extract the RDF/XML from a MLHIM CCD and generate a RDF/XML file and a JSON-LD file.
Looks for the file with the '.xsd' extension in the directory passed on the commandline.

Produces a RDF/XML file for the CCD schema using the same name as the input file but replaces the '.xsd' extension with '.rdf'.
Produces a JSON-LD file for each RDF file using the same name as the input file but replaces the '.rdf' extension with '.jsonld'.
The JSON-LD context is set to a context  based on the include element for the RM.
Example: "@mlhim250": "http://www.mlhim.org/ns/mlhim2/mlhim250.jsonld" The mlhim250.jsonld file is included with the specs but can also be generated using rm2ld.py
All MLHIM Reference Models have a context of; 'mlhim2':'http://www.mlhim.org/ns/mlhim2/mlhim2.jsonld'

"""
import os
import sys
import re
import configparser
from datetime import datetime
from lxml import etree
from rdflib import Graph, plugin
from rdflib.serializer import Serializer

config = configparser.ConfigParser()
config.read('utils.ini')

def getfiles(path):
    # returns a list of all files in a directory
    for file in os.listdir(path):
        if os.path.isfile(os.path.join(path, file)):
            yield file


def ccdmain():
    rootdir = '.'
    nsDict = {'xs': 'http://www.w3.org/2001/XMLSchema',
              'rdf': 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
              'rdfs': 'http://www.w3.org/2000/01/rdf-schema#',
              'mlhim2': 'http://www.mlhim.org/ns/mlhim2/'}

    header = """<?xml version="1.0" encoding="UTF-8"?>
<rdf:RDF xmlns="http://www.mlhim.org/ns/mlhim2/"
     xml:base="http://www.mlhim.org/ns/mlhim2/"
     xmlns:mlhim2="http://www.mlhim.org/ns/mlhim2/"
     xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
     xmlns:xs="http://www.w3.org/2001/XMLSchema"
     xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
     xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">

"""

    parser = etree.XMLParser(ns_clean=True, recover=True, resolve_entities=False, remove_comments=True)
    CCDPATH = config.get('Locations', 'CCDPATH')
    LDPATH = config.get('Locations', 'LDPATH')
    RDFPATH = config.get('Locations', 'RDFPATH')

    files = getfiles(CCDPATH)

    for f in files:
        if f[-3:] != 'xsd':
            continue

        rm = etree.XPath("//xs:include/@schemaLocation", namespaces=nsDict)
        rdffile = RDFPATH + f[:-3] + "rdf"
        jsonfile = LDPATH + f[:-3] + "jsonld"
        print("\n\nCreating: ", rdffile + " from: ", CCDPATH + f)

        src = open(CCDPATH + f, 'r')

        dest = open(rdffile, 'w')

        gentext = "\n<!-- Generated by ccd2ld.py " + datetime.now().strftime("%Y-%m-%d %H:%M") + " from " + f + " -->\n\n"

        dest.write(header)
        dest.write(gentext)

        tree = etree.parse(src, parser)
        root = tree.getroot()

        # RDF/XML
        print('Writing RDF/XML header. \n')
        descr = etree.XPath("//xs:appinfo/rdf:Description", namespaces=nsDict)
        rdf = descr(root)
        for x in rdf:
            #print(x.xpath('local-name()'))
            dest.write('    ' + etree.tostring(x).decode('utf-8') + '\n')

        dest.write('</rdf:RDF>\n')
        src.close()
        dest.close()

        # Create JSON-LD
        print("\n\nCreating: ", jsonfile + " from: ", RDFPATH + rdffile)
        src = open(rdffile, 'r')
        dest = open(jsonfile, 'w')
        g = Graph().parse(src, format='xml')

        cxt = rm(root)[0] # the JSON-LD context document is the same as the RM with a .jsonld instead of .xsd extension
#        context = ['http://www.mlhim.org/ns/mlhim2/mlhim2.jsonld',cxt[:-3] + "jsonld"]
        context = [cxt[:-3] + "jsonld"]
        print("\n\n Creating JSON-LD with context: ", context)
        g.serialize(jsonfile, format='json-ld', context=context, indent=4)
        src.close()
        dest.close()

    return

if __name__ == '__main__':

    ccdmain()
    print("\n\nFinished  " + datetime.now().strftime("%Y-%m-%d %H:%M") + " \n\n")
    sys.exit(0)
