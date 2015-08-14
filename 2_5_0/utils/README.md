Utility scripts (Python, XSLT, etc.) for manipulating schemas, CCDs and other artifacts.

pyMOE.py
========

Python MLHIM Ontology Extractor.

This script extracts embedded OWL code from Reference model schemas and CCDs and writes that code to a an RDF file for processing with Semantic Web tools.  

Looks for files with the xsd extension in the directory passed from the commandline. Relative or absolute directories are okay.
Produces an ontology file for each schema using the same name as the input file but replaces the xsd extension with owl.

Usage:
------

$python pyMOE.py <ccd directory>
