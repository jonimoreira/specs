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


Logical Model
=============
MLHIM is by name as well as by definition and design a multi-level modeling approach.  This means that there are multiple models with increasing specificity to get to the instance data point. MLHIM is constraint based which provides a complete syntactic validation path back to the reference model for the instance data. The semantic model is designed around the concepts of this multi-level model approach.

------
MLHIM2
------
Multi-Level Healthcare Information Modeling

The root concept. The abstract idea of MLHIM 2.x. All of the MLHIM2 classes are subclasses of this class.

--
RM
--
Reference Model

A set of components (CCMs) to provide structural integrity for a domain concept. Some CCMs are mandatory in CCDs and some are optional. Optionality is defined in each RM implementation.

---
CCM
---
Core Concept Model

A composable model contained in a reference model. A CCM represents a specific core type of component that further contains elements with base datatypes and/or other CCMs to define its structure. 

---
CCS
---
Core Concept Symbol

A CCS represents a CCM in instance data. In practice, it is usually substituted for by a PCS.
This substitution is due to the fact that constraints are expressed in a PCM which is then represented by a PCS. However the overall constraint model (CCD Instance) must match with components of the RM.

-----------
CCDInstance
-----------
Concept Constraint Definition Instance

A set of selected PCMs that are constraints on the RM components (CCMs) in order to represent a domain concept. 
In the implementation language there may be additional syntactic conventions required. 

---
PCM
---
Pluggable Concept Model

The name given to a CCM that has been constrained for use in a CCD Instance. Through the constraints, a PCM defines a single concept based on syntactic data constraints as well as specified semantics. It is *pluggable* because it can be reused in multiple CCD Instances. 

---
PCS
---
Pluggable Concept Symbol
Represents a PCM in instance data. Can be considered a data container for the components of a PCM.

------------
DataInstance
------------
A set of data items that reports via *isInstanceOf* property that it conforms to a CCD.
It has not been tested for validation. 

-----------------
DataInstanceValid
-----------------
Subclass of DataInstance.
A set of data items that conforms to a CCD Instance to represent an instance of that concept **AND** the data values are valid according to the CCD Instance constraints.

-------------------
DataInstanceInvalid
-------------------
Subclass of DataInstance.
A set of data items that conforms to a CCD Instance to represent an instance of that concept **AND** the data values are **NOT** valid according to the CCD Instance constraints. An Invalid Data Instance must contain one or more children of an Exception.

-----------------
DataInstanceError
-----------------
Subclass of DataInstance.
A set of data items that **DOES NOT** conform to the CCD Instance it represents **OR** it contains invalid data and does not contain one or more children of an Exception.

---------
Exception
---------
Indicates that some data is outside of the parameters defined by the CCD Instance. 

----------
isMLHIM2op
----------
is MLHIM2 Object Property

The root object property in MLHIM2.


-------
isCCMin
-------
Is CCM In

Used to relate a CCM to a RM.

-------
isPCMin
-------
Is PCM In

Used to relate a PCM to a CCD Instance.

--------------
isConstraintOn
--------------
Is Constraint On

Used to relate a CCD Instance to a RM.

----------------
isDataInstanceOf
----------------
Is Data Instance Of

Relates a Data Instance to a CCD Instance. 
In the reference implementation this property should be applied based on the xsi:schemaLocation attribute of the data instance. 

--------------
isCoreSymbolOf
--------------
Is Core Symbol Of

Relates a Core Concept Symbol to a Core Concept Model.

-------------------
isPluggableSymbolOf
-------------------
Is Pluggable Symbol Of

Relates a Pluggable Concept Symbol to a Pluggable Concept Model.

---------------------
isSymbolSubstituteFor
---------------------
Is Symbol Substitute For

Relates a Pluggable Concept Symbol to a Core Concept Symbol that it substitutes for.

-----------------
isMLHIM2Component
-----------------
Is MLHIM2 Component

Relates classes to the MLHIM2 top-level class.

----------
isMLHIM2dp
----------
is MLHIM2 Data Property

The root data property in MLHIM2.



OWL Modeling
============
Each of these concepts must be converted to `OWL DL <http://www.w3.org/TR/owl2-rdf-based-semantics/>`_ so that they can be used by query engines and reasoners to provide answers to questions and insights about connections not easily seen by people. 

The serialization format is RDF/XML due to the ubiquity of XML throughout computer science. It also allows the ontology to be contained in the same file as the XML Schema that defines the reference implementation syntactic structure. This conveniently encapsulates the concept models for easy sharability. 

An ontology can be broadly defined by two types of components: entities and descriptors. Entities are the main body of the ontology and include classes, properties, instances and rules. 

MLHIM2 Entities
===============

These are the entities defined in `mlhim2.owl <http://www.mlhim.org/ns/mlhim2/mlhim2.owl>`_

Classes
-------

    * MLHIM2
    * RM
    * ConceptModel
        * CCM
        * PCM
    * Symbol
        * CCS
        * PCS
    * CCDInstance
    * DataInstance
        * DataInstanceValid
        * DataInstanceInvalid
        * DataInstanceError
    * Exception


Object Properties
-----------------
    * isCCMin
    * isPCMin
    * isConstraintOn
    * isDataInstanceOf
    * isCoreSymbolOf
    * isPluggableSymbolOf
    * isSymbolSubstituteFor
    * isSubSymbolOf
    * isMLHIM2Component

Datatype Properties
-------------------
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
---------------------
The most widely used (at this writing) metadata definitions come from the Dublin Core Metadata Initiative (DCMI) terms. We found the file dcterms.rdf linked from `here <http://bloody-byte.net/rdf/dc_owl2dl/>`_. It meets all of our needs and has a number of other classes dealing with information resources. We may or may not include these as part of the MLHIM2 infrastructure in the future. 



