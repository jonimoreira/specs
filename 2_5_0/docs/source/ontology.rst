=============================
Ontological Modeling of MLHIM
=============================

Mission
=======
The mission of MLHIM is to provide a basis for distributed definitions of interlinked knowledge with the ability to transfer and then test for data validity and without the loss of the original semantics.

Reasoning for the Need
----------------------

Current approaches to data exchange is in a flat format and without computable semantics. The semantics are typically locked up in the persistence structure (database, etc.) and the source code of the application capturing and processing the data. These semantics cannot be shared with other potential users of the data. 

Mapping and integration processes typically lose semantics or worse; confuse semantics of the data as it is shared and reused downstream. This makes decision support impossible or even creates disastrous situations in domains where lives are at risk. 


Background
==========
Initial approaches to building ontologies for MLHIM used the XML Schema to OWL approach that has been published several times in academic literature. However, it was learned over these attempts that this is a single level mindset and approach.  It simply does not express the richness of MLHIM. The reason is because that approach represents the reference implementation of MLHIM and not the overall concept. 

When we began MLHIM in 2009, we intended to use OWL as the basis on which to build the concepts. However, the Open World Assumption is in conflict with constraint based modeling at its core. Also, OWL does not have rigorous tools to perform data validation. The two concepts OWA and constraint based validation are both required to fulfill the MLHIM mission. But we had to start with the constraint based validation and used XML Schema 1.1 as the implementation for proof. Based on that proof of concept we now re-visit building the ontologies.

In this document, when we talk about MLHIM we will use the term *MLHIM*. When we talk about modeling concepts in an area of interest we use the term *domain*.  Though we are thinking primarily about the domain of healthcare and the information technology to support healthcare information exchange, MLHIM concepts may be applied to any domain of interest.


Concepts
========
MLHIM is by definition and name a multi-level modeling approach.  This means that there are multiple models with increasing specificity to get to the instance data point. MLHIM is constraint based which provides an complete path back to the reference model for the instance data. 

------------
Model Levels
------------

MLHIM
-----
Multi-Level Healthcare Information Modeling

The root concept. The abstract idea of MLHIM.

RM
--
Reference Model

A specific implementation of components to provide structural integrity for a domain concept. 
Some are mandatory in CCDs and some are optional.

CCM
---
Core Concept Model

A set of composable concept models contained in a reference model. 

CCD
---
Concept Constraint Definition

A set of selected components from the RM that represent constraints on the RM components in order to represent a domain concept.

Instance
--------
A set of data items that conforms to a CCD to represent an instance of that concept.


UI View
-------
There are multiple UI Views:

* Form
* View
* Query Response

There may be many versions of each of those view types. These are application specific models. 

There are several sub-categories of query responses. Those that immediately come to mind are from either a query language (SQL, SPARQL, XQuery, JSONiq, etc.) and results from other types of analysis such as CDSS engines and OWL reasoners. 

============
OWL Modeling
============
Each of these concepts must be converted to OWL using the `RL profile <http://www.w3.org/TR/owl2-profiles/#OWL_2_RL>`_ so that they can be used by query engines and reasoners to provide answers to questions and insights about connections not easily seen by people. 

The serialization format is RDF/XML due to the ubiquity of XML throughout computer science. 

The RL profile was chosen due to its aim at applications that require scalable reasoning without sacrificing too much expressive power. The subset defined in RL is designed to be used for rule based processing and therefore lends itself well to CDSS. 

An ontology can be broadly defined by two types of components: entities and descriptors. Entities are the main body of the ontology and include classes, properties, instances and rules. Entities are usually sub-grouped into boxes:

    * The TBox contains intensional knowledge, or the properties of an entity required to identify it.
    * The ABox contains extensional knowledge, and describes knowledge specific to the domain of interest.
    * The RBox contains the rule axioms defining the knowledge.


TBox
====
The TBox contains the classes defined by MLHIM.


MLHIM
-----
The root class of all MLHIM classes. This is the subclass of owl:Thing

RM(version)
-----------
A specific version of the MLHIM reference model.




ABox
====

The ABox contains the instances defined by MLHIM.


RBox
====
The RBox contains the rules defined by MLHIM.

