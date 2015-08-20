Introduction
============

Utility scripts for manipulating RM schemas, CCDs and other artifacts.

These utilities expect that you  have Python 3.4.0 or later as well as the requirements listed in the requirements.txt file.

The utils.ini file is a configuration file to set the locations for source and destination files.
The default configuration is setup for demonstration and the existing directories.

The example CCDs and their associated data files are not meaningful but do include all of the components of MLHIM2 and the MLHIM RM 2.5.0.

The Python scripts are meant as educational tools and not as production level products. They are designed for clarity not performance. They will probably work fine only in low throughput situations. The configuration file utils.ini will need to be adjusted for use outside of this demo.

Quick Start
===========
If you just want to create all of the sample JSON-LD without getting into each script, follow this approach.
Be sure you have Python 3.4.0 or later installed. Not *required* but suggested is to use a [virtual environment](https://docs.python.org/3/library/venv.html).

from the utils directory execute:

<code>
$pip install -r requirements.txt
</code>

If you are not using a virtual environment you may have to execute this as root/admin.

Once the requirements are met, execute each of these scripts in this sequence:

<code>
$python uuid_types.py
$python mlhim2_json.py
$python rm2ld.py
$python ccd2ld.py
$python data2ld.py
$python mxic.py json
$python mxic.py shorten
</code>

You will now have additional data and model examples to explore. They are all derived from the Reference Model and CCDs. 

Scripts
=======

mlhim2_jsonld.py
----------------
This script will use the specs/RDF/mlhim2.rdf file to create a jsonld formatted file.

rm2ld.py
--------
This script will use the Reference Model schema to create both a RDF/XML and a JSON-LD file based on the RDF/XML from the RM schema.

ccd2ld.py
---------
This script will access the directory pointed to by CCDPATH in utils.ini and create both a RDF/XML file and a JSON-LD file for each CCD found.

uuid_types.py
-------------
Creates a file in the ccds directory that maps all of the complexType name UUIDs to the Reference Model base type.
The file uuid_types.csv is used by other scripts.

data2ld.py
----------
This script will access the directory pointed to by DATAPATH and create a JSON-LD file for each XML data instance found. You must create the uuid_types.csv file prior to running this script. The uuid_types.py script will create that file.  


Usage:
------
The above scripts are executed from the commandline as:

$python [scriptname]

Their settings are all in the utils.ini file.


mxic.py
-------
This script is a multi-function tool to demonstrate converting XML instances into JSON. It also demonstrates using shorter UUIDs as well as converting the JSON back to XML and the short UUIDs back to Type 4 UUIDs.
It reads the source files from DATAPATH and outputs its conversions (shorten & json) to the MXICPATH directory. For the conversion back (json2xml and longid) it reads the converted files from MXICPATH and writes the new ones back to the same MXICPATH.

Usage:

$python mxic.py [action]

actions:

*  shorten   - write and XML file with the UUIDs shortend. Output filename will  'suid-' prepended
*  json      - convert ALL the XML to JSON. Output filename will be the same as input with a .json extension replacing the .xml
*  shortjson - shorten the UUIDs and then convert to JSON.
*  json2xml  - convert JSON back to XML.
*  longid    - convert shortened UUID XML back to normal Type 4 UUID XML. Output filename will  'lid-' prepended

data_parser.py
--------------
This is a library module used by data2ld.py
