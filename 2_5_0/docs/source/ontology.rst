=============================
Ontological Modeling of MLHIM
=============================

Background
==========
Initial approaches to building ontologies for MLHIM used the XML Schema to OWL approach that has been published several times in academic literature. However, it was learned over these attempts that this is a single level mindset and approach.  It simply does not express the richness of MLHIM. The reason is because that approach represents the reference implementation of MLHIM and not the overall concept. 

When we began MLHIM in 2009, we intended to use OWL as the basis on which to build the concepts. However, the Open World Assumption is in conflict with constraint based modeling at its core. Also, OWL does not have rigorous tools to perform data validation. The two concepts OWA and constraint based validation are both required to fulfill the MLHIM mission of providing a basis for federated, interlinked knowledge transfer. But we had to start with the constraint based validation and used XML Schema 1.1 as the implementation for proof. Based on that proof of concept we now re-visit building the ontologies.

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

CCD
---
Concept Constraint Definition

A set of selected components from the RM that represent constraints on the RM components in order to represent a domain concept.

Instance
--------
A set of data items that conforms to a CCD to represent and instance of that concept.


UI View
-------
There are multiple UI Views:

* Form
* View
* Query Response

There may be many versions of each of those view types. These are application specific models. 


OWL Modeling
============
Each of these concepts must be converted to OWL DL syntax using the RL profile so that they can be used by query engines and reasoners to provide answers to questions and insights about connections not easily seen by people.



