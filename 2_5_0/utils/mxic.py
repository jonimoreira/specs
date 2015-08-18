# -*- coding: UTF-8 -*-
"""
$python mxic.py [action]

actions:
  shorten   - write and XML file with the UUIDs shortend. Output filename will  'suid-' prepended
  json      - convert ALL the XML to JSON. Output filename will be the same as input with a .json extension replacing the .xml
  shortjson - shorten the UUIDs and then convert to JSON.
  json2xml  - convert JSON back to XML.
  longid    - convert shortened UUID XML back to normal Type 4 UUID XML. Output filename will  'lid-' prepended

"""
import sys
import os
import json
import uuid
import configparser
import xmltodict
import shortuuid

config = configparser.ConfigParser()
config.read('utils.ini')

def mxicmain(argv):

    if len(argv) == 0 or (argv[0] not in ['shorten','json','json2xml','longid']):
        print("\n ** Usage requires one of these actions: 'shorten','json','json2xml' or 'longid'. See the README\n")
        sys.exit(2)
    else:
        action = argv[0]
        print("\nRunning the ",action," process.\n")

    if action == 'shorten':
        shorten()
    elif action == 'json':
        xml2json()
    elif action == 'json2xml':
        json2xml()
    elif action == 'longid':
        longid()
    else:
        print("\nUnknown 'action' Error: ", action) # this really can't ever happen.
        sys.exit(1)

    return

def getfiles(path):
    for file in os.listdir(path):
        if os.path.isfile(os.path.join(path, file)):
            yield file

def shorten():
    DATAPATH = config.get('Locations', 'DATAPATH')
    MXICPATH= config.get('Locations', 'MXICPATH')
    files = getfiles(DATAPATH)

    for file in files:
        if file[-4:] == '.xml':  # only the XML files
            outfile = MXICPATH+'suid-' +file
            print("\nShortening: ",file)
            #convert to short UUIDs
            f1 = open(DATAPATH + file,'r')
            f2 = open(outfile,'w')
            for line in f1.readlines():
                if 'mlhim2:pcs-' in line:
                    n1 = line.index('-')
                    n2 = line.index('>')
                    s = line[n1+1:n2]
                    if '-' not in s: # this element doesn't have the standard Type 4 UUID.
                        print(file," has non-standard element names.")
                        f2.close()
                        os.remove(outfile) # delete the incomplete output file
                        break

                    uid = uuid.UUID(s)
                    sid = shortuuid.encode(uid)
                    newline = line.replace(s,sid)
                    f2.write(newline)
                else:
                    f2.write(line)

            f1.close()
            f2.close()

def xml2json():
    DATAPATH = config.get('Locations', 'DATAPATH')
    MXICPATH= config.get('Locations', 'MXICPATH')
    files = getfiles(DATAPATH)

    for file in files:
        if file[-4:] == '.xml' and 'lid-' not in file:  # only the original and shortened XML files
            jfile = MXICPATH+file.replace('.xml','.json')
            print("Creating JSON file: ",jfile,' from ',file)
            #convert XML to JSON
            f = open(DATAPATH + file,'r')
            xml = f.read()
            f.close()
            xmldict = xmltodict.parse(xml)
            j = json.dumps(xmldict, indent=2)
            f = open(jfile,'w')
            f.write(j)
            f.close()

def json2xml():
    MXICPATH= config.get('Locations', 'MXICPATH')
    files = getfiles(MXICPATH)

    for file in files:
        if file[-5:] == '.json':  # only the JSON files
            xfile = MXICPATH+file.replace('.json','.xml')
            f1 = open(MXICPATH + file,'r')
            jf = f1.read()
            f1.close()
            jdict = json.loads(jf)
            xmldict = xmltodict.unparse(jdict)
            f2 = open(xfile,'w')
            f2.write(xmldict)
            f2.close()

def longid():
    MXICPATH= config.get('Locations', 'MXICPATH')
    files = getfiles(MXICPATH)

    for file in files:
        if file[-4:] == '.xml' and file[:5] == 'suid-':  # only the XML files
            f1 = open(MXICPATH + file,'r')
            lfile = MXICPATH+'lid-'+file
            f2 = open(lfile,'w')
            for line in f1.readlines():
                if '<mlhim2:pcs-' in line:
                    n1 = line.index('-')
                    n2 = line.index('>')
                    s = line[n1+1:n2]
                    if '-' in s and not 'xmlns:' in s: # this element wasn't a shortuuid
                        print(file," has non-standard characters in element names.")
                        f2.close()
                        os.remove(lfile) # delete the incomplete output file
                        break

                    uid = shortuuid.decode(s)
                    lid = str(uid)
                    newline = line.replace(s,lid)
                    f2.write(newline)
                else:
                    f2.write(line)

            f1.close()
            f2.close()

if __name__ == '__main__':
    mxicmain(sys.argv[1:])
    print("\n\n ** Finished Processing! ** \n")
    sys.exit(0)

