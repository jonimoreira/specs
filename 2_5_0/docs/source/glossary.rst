========
Glossary
========

MLHIM:
Multi-Level Healthcare Information modeling.  An open source/open content project with the goal of solving the healthcare information, semantic interoperability problem. 

It uses a multiple level information modeling approach in combination with widely available tools and language infrastructure to allow the exchange of the syntactic and semantic information along with data. 

Reference Model (RM):
The RM is a small set of structural concept definitions that allow for building arbitrarily complex models without introducing domain semantics into the structure. Domain concepts are modeled as *restrictions* on these RM concepts. Then RM therefore defines a common set of concepts that allow for query and knowledge discovery across data without prior knowledge of the actual content. See CCD below.   

PcT:
An acronym for Pluggable complexType. The name comes from the fact that it is a complete XML Schema complexType and that it can be reused or 'plugged in' to any CCD. This is due to the use of UUIDs for the complexType name attribute. Since complexType names must begin with an alphabetic character all MLHIM PcT names begin with the prefix 'ct-' followed by the UUID. This also facilitates the association with public element names in instances since they reuse the UUID but are prefixed with 'el-' in place of the 'ct-'. The use of a UUID allows the constraint on a reference model type to be reused many times in a CCD with different parameters such as enumeration constraints. The semantics for a concept modeled as a PcT is represented using Semantic Web technologies. The PcT name is the subject in each of the *Subject, Predicate, Object* RDF statements.

CCD: 
A MLHIM CCD is a Concept Constraint Definition. This is a domain concept data model that is created by expressing constraints on a generic reference model. In the MLHIM reference implementation eco-system these constraints are created through the use of the XML Schema complexTypes using the *restriction element* with its *base attribute* set to the appropriate RM complexType. CCDs are immutable, once published. They are uniquely identified by the prefix 'ccd-' followed by a Type 4 UUID. They are valid against one version of the MLHIM Reference Model. This design gives them temporal durability and prevents the requirement to ever migrate instance data. The results of this approach is that all data, for all time in all contexts can be maintained with complete syntactic integrity and complete semantics. The semantics for a concept modeled as a CCD is represented using Semantic Web technologies. The CCD identifier is the subject in each of the *Subject, Predicate, Object* RDF statements.