Utility scripts for manipulating RM schemas, CCDs and other artifacts.

The utils.ini file is a configuration file to set the locations for source and destination files.
The default configuration is setup for demonstration and the existing directories.

The example CCDs and their associated data files are not meaningful but do include all of the components of MLHIM2 and the MLHIM RM 2.5.0.

The Python scripts are meant as educational tools and not as production level products. They are designed for clarity not performance. They will probably work fine only in low throughput situations. The configuration file utils.ini will need to be adjusted for use outside of this demo.

Scripts
=======

mlhim2_jsonld.py
----------------
This script will use the RDF/mlhim2.rdf file to create a jsonld formatted file.

rm2ld.py
--------
This script will use the Reference Model schema to create both a RDF/XML and a JSON-LD file based on the RDF/XML from the RM schema.

ccd2ld.py
---------
This script will access the directory pointed to by CCDPATH in utils.ini and create both a RDF/XML file and a JSON-LD file for each CCD found.

data2ld.py
----------
This script will access the directory pointed to by DATAPATH and create a JSON-LD file for each XML data instance found.

mxic.py
-------
This script is a multi-function tool to demonstrate converting XML instances into JSON. It also demonstrates using shorter UUIDs as well as converting the JSON back to XML and the short UUIDs back to Type 4 UUIDs.
It reads the source files from DATAPATH and outputs its conversions (shorten & json) to the mxic_data directory. For the conversion back (json2xml and longid) it reads the converted files from mxic_data and writes the new ones back. 

Usage:

$python mxic.py [action]

actions:

*  shorten   - write and XML file with the UUIDs shortend. Output filename will  'suid-' prepended
*  json      - convert ALL the XML to JSON. Output filename will be the same as input with a .json extension replacing the .xml
*  shortjson - shorten the UUIDs and then convert to JSON.
*  json2xml  - convert JSON back to XML.
*  longid    - convert shortened UUID XML back to normal Type 4 UUID XML. Output filename will  'lid-' prepended
