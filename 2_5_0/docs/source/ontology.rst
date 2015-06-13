=============================
Ontological Modeling of MLHIM
=============================

Mission
=======
The mission of MLHIM is to provide a basis for distributed definitions of interlinked knowledge with the ability to transfer and then test for data validity and without the loss of the original semantics.

---------
Why MLHIM
---------

Current approaches to data exchange is in a flat format and without computable semantics. The semantics are typically locked up in the persistence structure (database, etc.) and the source code of the application capturing and processing the data. These semantics cannot be shared with other potential users of the data. 

Mapping and integration processes typically lose semantics or worse; confuse semantics of the data as it is shared and reused downstream. This makes decision support impossible or even creates disastrous situations in domains where lives are at risk. 


Background
==========
Initial approaches to building ontologies for MLHIM used the XML Schema to OWL approach that has been published several times in academic literature. However, it was learned over these attempts that this is a single level mindset and approach.  It simply does not express the richness of MLHIM. The reason is because that approach represents the reference implementation of MLHIM and not the overall concept. 

When we began MLHIM in 2009, we intended to use OWL as the basis on which to build the concepts. However, the Open World Assumption is in conflict with constraint based modeling at its core. Also, OWL does not have rigorous tools to perform data validation. The two concepts OWA and constraint based validation are both required to fulfill the MLHIM mission. But we had to start with the constraint based validation and used XML Schema 1.1 as the implementation for proof. Based on that proof of concept we now re-visit building the ontologies.

In this document, when we talk about MLHIM we will use the term *MLHIM*. When we talk about modeling concepts in an area of interest we use the term *domain*.  Though we are thinking primarily about the domain of healthcare and the information technology to support healthcare information exchange, MLHIM concepts may be applied to any domain of interest.



============
OWL Modeling
============
Each of these concepts must be converted to `OWL DL <http://www.w3.org/TR/owl2-rdf-based-semantics/>`_ so that they can be used by query engines and reasoners to provide answers to questions and insights about connections not easily seen by people. 

The serialization format is RDF/XML due to the ubiquity of XML throughout computer science. It also allows the ontology to be contained in the same file as the XML Schema that defines the reference implementation syntactic structure. This conveniently encapsulates the concept models for easy sharability. 

An ontology can be broadly defined by two types of components: entities and descriptors. Entities are the main body of the ontology and include classes, properties, instances and rules. 

MLHIM2 Entities
===============

These are the entities defined in `mlhim2.owl <http://www.mlhim.org/ns/mlhim2/mlhim2.owl>`_

Classes
=======

    * MLHIM2
    * RM
    * ConceptModel

        * CoreCM
        * PluggableCM

    * Symbol

        * CoreCS
        * PluggableCS

    * CCDInstance
    * DataInstance

        * DataInstanceValid
        * DataInstanceInvalid
        * DataInstanceError

    * Exception


Object Properties
=================

  * isMLHIM2objprop

    * isCoreModelIn
    * isPluggableModelIn
    * isCoreSymbolOf
    * isPluggableSymbolOf
    * isSubSymbolIn
    * refersToSymbol

Datatype Properties
===================
Some tools (e.g. Protégé) do not support the full range of XML Schema datatypes. We defined these in mlhim2.owl as well.

  * date
  * duration
  * yearMonthDuration
  * dayTimeDuration
  * gDay
  * gMonth
  * gYear
  * gYearMonth
  * gMonthDay
  * time

Annotation Properties
=====================
The most widely used (at this writing) metadata definitions come from the Dublin Core Metadata Initiative (DCMI) terms. However, the definitions for these do not meet the requirements for OWL DL syntax. We will define our own metadata properties and relate them to other standards. 
