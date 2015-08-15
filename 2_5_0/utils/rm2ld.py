#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
 rm2ld.py - Reference Model to Linked Data

A utility to extract the RDF/XML from a MLHIM RM and generate a RDF/XML file and a JSON-LD file.
Looks for the file with the '.xsd' extension in the '../schema/' directory.

Produces a RDF/XML file for the RM schema using the same name as the input file but replaces the '.xsd' extension with '.rdf'.
Produces a JSON-LD file for each RDF file using the same name as the input file but replaces the '.rdf' extension with '.jsonld'.
All MLHIM Reference Models have a context of; 'mlhim2':'http://www.mlhim.org/ns/mlhim2/mlhim2.jsonld'

    Copyright (C) 2015 Timothy W. Cook tim@mlhim.org

      Licensed under the Apache License, Version 2.0 (the "License");
      you may not use this file except in compliance with the License.
      You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

      Unless required by applicable law or agreed to in writing, software
      distributed under the License is distributed on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
      See the License for the specific language governing permissions and
      limitations under the License.

"""

import os
import sys
import re
from datetime import datetime
from lxml import etree
from rdflib import Graph, plugin
from rdflib.serializer import Serializer

def getfiles(path):
    # returns a list of all files in a directory
    for file in os.listdir(path):
        if os.path.isfile(os.path.join(path, file)):
            yield file


def main(path):
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
    files = getfiles(path)

    for f in files:
        if f[-3:] != 'xsd':
            continue

        rdffile = path + "/" + f[:-3] + "rdf"
        jsonfile = path + "/" + f[:-3] + "jsonld"
        print("\n\nCreating: ", rdffile + " from: ", path + "/" + f)

        src = open(path + "/" + f, 'r')

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
        print("\n\nCreating: ", jsonfile + " from: ", path + "/" + rdffile)
        src = open(rdffile, 'r')
        dest = open(jsonfile, 'w')
        g = Graph().parse(src, format='xml')
        context = {"@mlhim2": "http://www.mlhim.org/ns/mlhim2/mlhim2.jsonld", "@language": "en"}
        g.serialize(jsonfile, format='json-ld', context=context, indent=4)
        src.close()
        dest.close()

    return

if __name__ == '__main__':

    path = '../schema'

    main(path)
    print(
        "\n\nFinished  " + datetime.now().strftime("%Y-%m-%d %H:%M") + " \n\n")
    sys.exit(0)
