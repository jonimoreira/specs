"""
Used to generate the JSON-LD for mlihim2 based on the canonical mlhim2.rdf
"""
from rdflib import Graph, plugin
from rdflib.serializer import Serializer

g = Graph().parse('../schema/mlhim2.rdf', format='xml')
context = {"@mlhim2": "http://www.mlhim.org/ns/mlhim2/mlhim2.jsonld", "@language": "en"}
g.serialize('../schema/mlhim2.jsonld', format='json-ld', context=context, indent=4)

