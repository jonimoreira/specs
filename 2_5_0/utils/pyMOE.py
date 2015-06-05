#!/usr/bin/env python
# -*- coding: UTF-8 -*-
"""
 pyMOE.py - Python MLHIM Ontology Extractor

A utility to extract the ontology from the RM schema.
Looks for a single XML Schema doc ../schema/mlhim250.xsd.
Produces a file ../ontology/mlhim250.owl.
The output file is an RDF document with an ontology defined based on the extracted xs:appinfo information.
TODO: make the file names parameters for future versions.

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
from lxml import etree

def main():
    rootdir = '.'
    nsDict={'xs':'http://www.w3.org/2001/XMLSchema',
            'rdf':'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
            'rdfs':'http://www.w3.org/2000/01/rdf-schema#',
            'dc':'http://purl.org/dc/elements/1.1/',
            'owl':'http://www.w3.org/2002/07/owl#',
            'skos':'http://www.w3.org/2004/02/skos/core#',
            'mlhim2':'http://www.mlhim.org/xmlns/mlhim2'}

    parser = etree.XMLParser(ns_clean=True, recover=True)
    about = etree.XPath("//xs:complexType/xs:annotation/xs:appinfo/rdf:Description", namespaces=nsDict)
    md = etree.XPath("//rdf:RDF/rdf:Description", namespaces=nsDict)
    src = open('../schema/mlhim250.xsd', 'r')
    dest = open('../ontology/mlhim250.owl', 'w')

    dest.write("""<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE rdf:RDF [
    <!ENTITY owl "http://www.w3.org/2002/07/owl#" >
    <!ENTITY dc "http://purl.org/dc/elements/1.1/" >
    <!ENTITY xs "http://www.w3.org/2001/XMLSchema#" >
    <!ENTITY skos "http://www.w3.org/2004/02/skos/core#" >
    <!ENTITY rdfs "http://www.w3.org/2000/01/rdf-schema#" >
    <!ENTITY rdf "http://www.w3.org/1999/02/22-rdf-syntax-ns#" >
    <!ENTITY mlhim2 "http://www.mlhim.org/xmlns/mlhim2" >
]>


<rdf:RDF xmlns="http://www.mlhim.org/xmlns/mlhim2#"
     xml:base="http://www.mlhim.org/xmlns/mlhim2"
     xmlns:mlhim2='http://www.mlhim.org/xmlns/mlhim2'
     xmlns:dc="http://purl.org/dc/elements/1.1/"
     xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
     xmlns:owl="http://www.w3.org/2002/07/owl#"
     xmlns:xs="http://www.w3.org/2001/XMLSchema#"
     xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
     xmlns:skos="http://www.w3.org/2004/02/skos/core#">

""")

    print('Processing RM schema: mlhim250.xsd \n')
    tree = etree.parse(src, parser)
    root = tree.getroot()

    # Ontology
    print('Writing ontology header. \n')
    onto = etree.XPath("//xs:appinfo/owl:Ontology", namespaces=nsDict)
    owl = onto(root)
    for x in owl:
        dest.write('    '+etree.tostring(x).decode('utf-8')+'\n')

    # DatatypeProperty
    print('Writing DatatypeProperties. \n')
    onto = etree.XPath("//xs:appinfo/owl:DatatypeProperty", namespaces=nsDict)
    owl = onto(root)
    for x in owl:
        dest.write('    '+etree.tostring(x).decode('utf-8')+'\n')

    # ObjectProperty
    print('Writing ObjectProperties. \n')
    onto = etree.XPath("//xs:appinfo/owl:ObjectProperty", namespaces=nsDict)
    owl = onto(root)
    for x in owl:
        dest.write('    '+etree.tostring(x).decode('utf-8')+'\n')

    # Class
    print('Writing Classes. \n')
    onto = etree.XPath("//xs:appinfo/owl:Class", namespaces=nsDict)
    owl = onto(root)
    for x in owl:
        dest.write('    '+etree.tostring(x).decode('utf-8')+'\n')


    dest.write('</rdf:RDF>\n')
    src.close()
    dest.close()


if __name__ == '__main__':
    main()
    print("\n\nFinished!!!!! \nCreated: schema/mlhim250.owl \n\n")
    sys.exit(0)

