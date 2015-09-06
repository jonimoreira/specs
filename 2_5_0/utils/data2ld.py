# -*- coding: UTF-8 -*-
"""

This is a utility to generate JSON-LD from MLHIM XML instance data.
Usage:
$python data2ld.py

This will process the demonstration data in the default location.

This is a demonstration and educational tool.  It is written for clarity not production. It will probably work fine with smaller loads.
If your needs are for high throughput you should use this tool as a guide and build one to your specifications.

"""
import sys
import os
import json
import uuid
import configparser
from rdflib import Graph, plugin
from rdflib.serializer import Serializer
from lxml import etree
import csv
import xmltodict

import data_parser

config = configparser.ConfigParser()
config.read('utils.ini')


def ldmain():
    DATAPATH = config.get('Locations', 'DATAPATH')
    files = getfiles(DATAPATH)
    jsonld(files)
    return


def getfiles(path):
    for file in os.listdir(path):
        if os.path.isfile(os.path.join(path, file)):
            yield path + file

def jsonld(files=[]):
    # get the paths to process
    DATAPATH = config.get('Locations', 'DATAPATH')
    LDPATH = config.get('Locations', 'LDPATH')
    CCDPATH = config.get('Locations', 'CCDPATH')

    # setup namespaces
    nsDict = {'xs': 'http://www.w3.org/2001/XMLSchema',
              'rdf': 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
              'rdfs': 'http://www.w3.org/2000/01/rdf-schema#',
              'mlhim2': 'http://www.mlhim.org/ns/mlhim2/'}
    # create a parser instance
    parser = etree.XMLParser(ns_clean=True, recover=True, resolve_entities=False, remove_comments=True)

    #load the dictionary of UUIDs and RM types
    uuids = {}
    try:
        with open(CCDPATH+'uuid_types.csv') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                uuids[row['uuid']] = row['rmtype']
    except FileNotFoundError:
        print('\n\n** You must first create the uuid_types.csv file using the uuid_types.py script **\n')
        sys.exit(1)

    for file in files:
        if file[-4:] == '.xml':
            graph = ''
            ld_obj = ''
            #TODO: You should check the files for the validity status. We are assuming they are valid here and add this fact as an entry of the graph.
            hdr_obj = '{\n"@id": "'+file+'",\n'
            hdr_obj += '"@type":"http://www.mlhim.org/ns/mlhim2/DataInstanceValid"\n'
            hdr_obj += '},\n'
            graph += hdr_obj

            f1 = open(file,'r')
            tree = etree.parse(f1, parser)
            root = tree.getroot()

            ccd_element = root.tag.replace('{http://www.mlhim.org/ns/mlhim2/}','')
            context = '{\n"@context": [\n        "'+ccd_element+'.jsonld"\n],\n'

            # iterate through the data
            for element in root.getiterator():
                if 'pcs-' in element.tag:
                    # lookup the uuid
                    rmtype = uuids[element.tag.replace('{http://www.mlhim.org/ns/mlhim2/}','').replace('pcs-','')]
                    # if it isn't a DvAdapter or a Cluster then call the function to parse the information into a JSON object and add it to the graph
                    if rmtype not in ['DvAdapter', 'Cluster']:
                        try:
                            funcCall = getattr(data_parser, rmtype)
                            graph += funcCall(element)
                        except AttributeError:
                            print('AttributeError: ', rmtype)


            ldfile = file.replace('.xml', '.jsonld') # use the same filename with a new extension to name the new file
            ldfile = ldfile.replace(DATAPATH, LDPATH) # change the path portion of the filename
            f1.close()
            f2 = open(ldfile,'w')
            f2.write(context)
            f2.write('"@graph": [\n')
            last_comma = graph.rfind(',')
            graph = graph[:last_comma]
            f2.write(graph)

            f2.write('\n]\n}\n')
            f2.close()

if __name__ == '__main__':
    ldmain()
    print("\n\n ** Finished Processing! ** \n")
    sys.exit(0)

