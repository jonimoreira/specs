=================
Modeling Concepts
=================

Approach
========
The MLHIM Reference Model reference implementation is implemented in a single XML Schema. The fundamental concepts, expressed in the reference model classes, are based on basic philosophical concepts of real world entities. These broad concepts can then be constrained to more specific concepts using models created by domain experts, in this case healthcare experts.

In MLHIM 1.x these constraints were known as archetypes, expressed in a domain specific language (DSL) called the archetype definition language (ADL). This language is based on a specific model called the archetype object model (AOM). MLHIM 1.x is a fork of the open source openEHR specifications.

In MLHIM 2.x and later, a given domain knowledge model is implemented in an XML Schema (XSD), called a Concept Constraint Definition (CCD). This allows MLHIM to use the XML Schema language as well as other XML technologies, as the constraint, validation and processing language. This provides the MLHIM development community with an approach to using multi-level modeling in healthcare using standardized, widely available tools and technologies.

The attempt to design a data model for a concept is still restricted to the knowledge and context of a particular domain expert.

In effect, there can never be a maximal data model for a healthcare concept. This means that from a global perspective there may be several CCDs that purport to fill the same need.

There is no conflict in the MLHIM world in this case as CCDs are identified using the UUID and there are no semantics in the processing and validation model.

The CCD may be further constrained at the implementation level through the use of implementation templates in the selected framework. Examples are additional XML Schemas that provide further restrictions or HTML pages used for display and data form entry. These templates are constructed in the implementation and may or may not be sharable across applications dependning upon the needs of the implementation.

The MLHIM specifications do not play any role in defining what these templates look like or perform like. They are only mentioned here as a way of making note that applications will require a user interface template layer to be functional. Th applicatiuon UI as well as any transport layers between applications is outside the scope of the MLHIM eco-system. 

**The interoperability layer remains at the CCD instance level.**

The real advantage to using the MLHIM approach to healthcare information modeling is that it provides for a wide variety of healthcare applications to be developed based on the broad concepts defined in the reference model. By having domain experts within the healthcare field to define and create the CCDs, they can then be shared across multiple applications so that the structure and semantics of the data is not locked into one specific application, but can be exchanged among many different applications. This properly implements the separation of roles between IT and domain experts.

To demonstrate the differences between the MLHIM approach and the typical data model design approach we will use two common metaphors.

1. The first is for the data model approach to developing software. This is where a set of database definitions are created based on a requirements statement representing an information model. An application is then developed to support all of the functionality required to input, manipulate and output this data as information, all built around the data model. This approach is akin to a jigsaw puzzle (the software application) where the shape of the pieces are the syntax and the design and colors are the semantics, of the information represented in an aggregation of data components described by the model. This produces an application that, like the jigsaw puzzle, can provide for pieces (information) to be exchanged only between exact copies of the same puzzle. If you were to try to put pieces from one puzzle into a different puzzle, you might find that a piece has the same shape (syntax) but the picture on the piece (semantics) will not be the same. Even though they both belong to the same domain of jigsaw puzzles. You can see that getting a piece from one puzzle to correctly fit into another is going to require manipulation of the basic syntax (shape) and /or semantics (picture) of the piece. This can also be extended to the relationship that the puzzle has a defined limit of its four sides. It cannot, reasonably, be extended to incorporate new pieces (concepts) discovered after the initial design.

2. The multi-level approach used in MLHIM is akin to creating models (applications) using the popular toy blocks made by Lego® and other companies. If you compare a box of these interlocking blocks to the reference model and the instructions to creating a specific toy model (software application), where these instructions present a concept constraint (implemented as a CCD in MLHIM). You can see that the same blocks can be used to represent multiple toy models without any change to the physical shape, size or color of each block. Now we can see that when new concepts are created within healthcare, they can be represented as instructions for building a new toy model using the same fundamental building blocks that the original software applications were created upon.

Constraint Definitions
----------------------
Concept Constraint Definitions (CCDs) can be created using any XML Schema or even a plain text editor. However, this is not a recommended approach. Realistic CCDs can be several hundred lines long. They also require Type4 UUIDs to be created as complexType and element names.
An open source Constraint Definition Designer (CDD) has been started but is in need of a leader and developer community. MLHIM founders are eager to support the development of this tool. It will (eventually) be used to create constraint definitions. It is open source and we hope to build a community around its development. The CDD can be used now to create a shell XSD with the correct metadata entries. Each release is available on the MLHIM GitHub site.
There is also a conceptual model of the information using the mind mapping software, Freemind. It provides domain experts a method of building up the structures to define a certain healthcare concept. There is a tool being developed to convert these Freemind definitions into a standardized format for import and processing by the CCD-Gen. It can also be found on the GitHub Site as xml2ccd

CCD Identification
------------------
The root element of a CCD and all complexType and global elements will use Type UUIDs as defined by the IETF RFC 4122 See: http://www.ietf.org/rfc/rfc4122.txt
The filename of a CCD may use any format defined by the CCD author. The CCD author must recognize that the metadata section of the CCD must contain the correct RDF:about URI with this filename.

As a matter of consistency and to avoid any possible name clashes, the CCDs created by the CCD-Gen also use the CCD ID (ccd-<uuid>.xsd). To be a viable CCD for validation purposes the CCD should use the W3C assigned extension of '.xsd'. Though many tools may still process the artifact as an XML Schema without it.
The MLHIM community considers it a matter of good artifact management practice to use the CCD ID with the .xsd extension, as the filename.

CCD Versioning
--------------
Versioning of CCDs is not supported by these specifications. Though XML Schema 1.1 does have supporting concepts for versioning of schemas, this is not desirable in CCDs. The reasons for this decision focuses primarily around the ability to capture temporal and ontological semantics for data instances and maintain them for all time (future proof data).
A key feature of MLHIM is the ability to guarantee the semantics for all future time, as intended by the original modeler. We determined that any change in the structure or semantics of a CCD, constitutes a new CCD. Since the complexTypes are re-usable (See the PcT description below), an approach that tools should use is to allow for copying a CCD and assigning a new CCD ID.

When a complexType is changed within this new CCD, all ancestors (enclosing complexTypes) also must be assigned a new name along with its global element name. For example if the enumerations on a DvStringType restriction are changed, the DvStringType, the DvAdapterType, the parent ClusterType and any enclosing ClusterTypes, the EntryType and the CCDType must all get new UUIDs.

Pluggable complexTypes (PcTs)
-----------------------------
MLHIM CCDs are made up of XML schema complexTypes composed by restriction of the Reference Model complexTypes. This is the foundation of interoperability.
What is in the Reference Model is the superset of all CCDs. Pluggable complexTypes (PcTs) are a name we have given to the fact that due to their unique identification the complexTypes can be seen as re-usable components. For example, a domain expert might model a complexType that is a restriction of DvStringType with the enumerations for selecting one of the three measurement systems for temperature; Fahrenheit, Kelvin and Celsius. This PcT as well as many others can be reused in many CCDs without modification.
For this reason, the semantic links for PcTs are directly expressed in an xs:appinfo section in each PcT. This approach lends itself very well to the creation of RDF triples from this information. For example::

  <xs:appinfo>
   <rdf:Description rdf:about='&mlhim2;ct-3a54417d-d1d6-4294-b868-e7a9ab28f8c4'>
    <rdfs:isDefinedBy rdf:resource='http%3A//purl.obolibrary.org/obo/RO_0002371'/>
   </rdf:Description>
  </xs:appinfo>

In this example the subject is &mlhim2;ct-3a54417d-d1d6-4294-b868-e7a9ab28f8c4 the predicate is rdfs:isDefinedBy and the object is http%3A//purl.obolibrary.org/obo/RO_0002371

Every xs:appinfo section must begin with the rdf:Description element and have the rdf:about attribute to define the subject, as the containing complexType. This is then followed by one or more predicate/object components. The predicates can be from any vocabulary/terminology. Just be certain that the namespace prefix is correctly defined in the CCD header. The CCD-Gen defines common namespaces by default but others may be added as needed. Also be certain that any URLs are properly encoded so that they will be valid inside the CCD.
RDF triples are a cornerstone of the semantic web. For more information see this tutorial. Of particular interest here is the section titled; Introducing RDF/XML. RDF/XML is one of the syntaxes used to describe semantic links and it is what we use in MLHIM. Another popular syntax you may see is called Turtle.

Implementations
----------------
It is the intent of the MLHIM community to maintain implementations and documentation in all major programming languages. Volunteers to manage these are welcome.
**XML Schema**
The reference implementation is expressed in XML Schema 1.1. Each release package contains the reference model schema as well as this and other documentation. The release and current development schemas live at the versioned link on MLHIM.org. For example 2.5.0 is at: http://www.mlhim.org/ns/mlhim2/mlhim250.xsd  A full release is available from GitHub. The previous release is `2.4.7 <https://github.com/mlhim/specs/releases/tag/2.4.7-Release>`_

**Best Practices**
The concept of best practices for modeling and for implementation is an evolving set of results. To accommodate new items of interest under this heading we are using the MLHIM specs Wiki. See the table of contents here: https://github.com/mlhim/specs/wiki/1.-Best-Practices
