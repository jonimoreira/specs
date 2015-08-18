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

import xmltodict
import shortuuid

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
    DATAPATH = config.get('Locations', 'DATAPATH')
    LDPATH = config.get('Locations', 'LDPATH')
    for file in files:
        if file[-4:] == '.xml':
            #TODO: You should check the files for the validity status. We are assuming they are valid here.
            ld_obj = '{\n"@id": "'+file+'",\n'
            ld_obj += '"@type":"http://www.mlhim.org/ns/mlhim2/DataInstanceValid"\n'
            ld_obj += '},\n'
            output = ''
            output += ld_obj
            ld_obj = None
            f1 = open(file,'r')
            xfile = file.replace('.xml', '.jsonld') # use the same filename with a new extension
            xfile = xfile.replace(DATAPATH, LDPATH) # change the path portion of the filename

            print('Creating: ', xfile)
            for line in f1.readlines():
                # get the context from the name of the ccd schema being refered to here.
                if 'xsi:schemaLocation=' in line:
                    n2 = line.index('.xsd')
                    n1 = line.rfind('/')
                    cxt = line[n1+1:n2] + '.jsonld'

                # we find a global element name.
                if '<mlhim2:pcs-' in line:
                    ld_obj = ''
                    n1 = line.index('-')
                    n2 = line.index('>')
                    s = line[n1+1:n2]
                    ld_obj += '{\n"@id": "mlhim2:pcs-'+s+'",\n'
                    ld_obj += '"@type":"http://www.mlhim.org/ns/mlhim2/PluggableCS",\n'
                    ld_obj += '"http://www.mlhim.org/ns/mlhim2/isSymbolIn":"'+cxt+'"\n'
                    ld_obj += '},\n'
                elif '</mlhim2:pcs-' in line: # we are closing a global element
                    pass
                else: # process the internal elements
                    ld_obj += 'internal\n'




                if ld_obj:
                    output += ld_obj
                    ld_obj = None

            f1.close()
            context = '{\n"@context": [\n        "'+cxt+'"\n],\n'
            f2 = open(xfile,'w')
            f2.write(context)
            f2.write('"@graph": [\n')
            lc = output.rindex(',')
            output = output[:lc] # strip off last comma
            f2.write(output)
            f2.write('\n]\n}\n')
            f2.close()

if __name__ == '__main__':
    ldmain()
    print("\n\n ** Finished Processing! ** \n")
    sys.exit(0)

