MLHIM as a Component of an Enterprise Architecture
==================================================
MLHIM is a core foundational part of any enterprise architecture that strives to attain computable semantic interoperability. In this chapter we will describe how the MLHIM eco-system fits into a typical healthcare IT architecture.  Keeping in mind that MLHIM is also applicable to any size application that needs to be semantically interoperable, from wearable devices to enterprise EHRs. 
The Open Group Architecture Framework (TOGAF®) is a framework for enterprise architecture which provides an approach for designing, planning, implementing, and governing an enterprise information technology architecture. In this document it provides us with a formal method to communicate with implementers and decision makers on integrating MLHIM into the enterprise. 
We will focus on Part V (chapter 39) and Part VI (chapter 44) of the TOGAF specification; Enterprise Continuum and Integrated Information Infrastructure Reference Model. These chapters explore the view of the enterprise repository as part of the enterprise and the information technology industry at large as well as developing a sound foundation for boundary-less information flow. 
Referring to Figure 39-1 and its description, the MLHIM reference model and its implementation fits into the category Architecture Continuum. In the details description and depicted graphically in Figure 39-2 are four conceptual architectures. Their relationship to MLHIM is shown in Table1. Keeping in mind that the granularity of MLHIM is much finer than these abstract architectures.  However, this does serve as a good starting point.

+-----------------+---------------------------------------------------------------+
|      TOGAF®     |              MLHIM                                            |
+=================+===============================================================+
|Foundation       | The MLHIM specifications and reference implementation         |
|Architectures    |represent a foundation model on which to build more specific   |
|                 |models. From a broader perspective, the XML family of          |
|                 |technologies provides the foundation for ubiquity.             |
+-----------------+---------------------------------------------------------------+
|Common System    | The MLHIM CCDs are composed of multiple,reusable              |
|Architectures    |(pluggable) complexType restrictions of the reference model.   |  
|                 |These PcTs can be reused in many CCDs and can represent a      | 
|                 |common group of components. Again from the broader             | 
|                 |perspective the use of XML Schema 1.1 as an easily             |  
|                 |transported model is of primary importance as a common         | 
|                 |architecture.                                                  |
+-----------------+---------------------------------------------------------------+
|Industry         |CCDs that have broad applicability in healthcare across many   |
|Architectures    |types of applications fit into the architecture. These CCDs may|
|                 |be openly licensed and shared globally. One might consider the |
|                 |availability of tools for XML in this category as well as tools|
|                 |that might be used specifically for creating MLHIM knowledge   |
|                 |artifacts (PcTs and CCDs).                                     |
+-------------------------+-------------------------------------------------------+
|Organization     |CCDs that are used in applications within one organization     |
|Specific         |are in this category.                                          |
|Architectures    |                                                               |
+-------------------------+-------------------------------------------------------+

Table 1: MLHIM in the Architecture Continuum

The reader should consult the details of the TOGAF® documentation as well as the remainder of this document, in order to understand the full implications of implementing MLHIM into large organizations.  
In chapter 44 of the TOGAF® specifications we focus more towards information interoperability of applications, regardless of their platform and location. Here we can discover the importance of ubiquitous technology in providing interoperability.   
This chapter focuses on a specific enterprise whereas with MLHIM we work with a global healthcare information scenario.  There are multiple terminologies and ontologies to use, multiple languages, cultures and geographies to consider and the data essentially has no expiration date.  Therefore, The Boundaryless Information Flow problem space for us is significantly larger than the TOGAF® specifications cover.   
However, the above table should add some context to the MLHIM concepts for those developers that are familiar with existing enterprise architectures. Always keep in mind that implementations are local, CCDs and data instances are global.   

Data Description Levels
-----------------------
With the growing interest in Big Data analytics, various efforts are ongoing to improve the description of data and datasets.  The various domains are attempting to use commonly developed vocabularies, such as the Dublin Core Metadata Initiative (DCMI1) terms, the Data Catalog Vocabulary (DCAT2), Schema.org3 and others. 
The popular approach is to use the vocabularies to directly annotate the data. We call this the direct markup approach. While this approach will work, to some limited extent.  There are several problems with this method.  The glaringly obvious one is that, more often than not, high quality, precise metadata is often much larger than the actual data being represented.  Every instance of data and every copy of the dataset, must carry all of its own metadata.  While storage size, memory size, processing speed and network bandwidth have improved immensely over the past decade. They are not infinite and every byte still counts; affecting overall performance in an inverse relationship.  
In conservative testing with MLHIM, we can see that the syntactic and semantic metadata for a data instance is typically about three times the size of the data instance itself.  So including metadata with the data means a small 16kb data file is now 64kb.  Not too bad when you look at it on that scale.  However, the growth is linear with this direct data markup approach.  
Let us say you record a time-series from some device and your data is 10MB. Now, for that one instance if it is marked up individually,  the size blooms to 40MB. Even with today's technology, this is a significant payload to transfer. 
Estimates are4 that every day we create 2.5 quintillion (1018) bytes of data. That linear expansion that resulted in a growth of 48kb is now a growth of 7.5 quintillion (1018) bytes; every day.
Regardless of any sustainability estimates.  Is it even a smart thing to do?  
When the data instances are marked up with semantics and they are being exchanged between systems (as medical information should be), there is no single point of reference to insure that the syntax or semantics of the information wasn't modified along the way. 
The MLHIM approach to the computable semantic interoperability problem does not have these issues.  The metadata is developed by the modeler and it is immutable. In other words, this is what the modeller intended for the data to mean at this time and in this context. The model can then be referred to by any required number of data instances.  The multi-level modeling approach to development is what enables this level of efficiency in data management.  MLHIM uses the ubiquitous XML technology stack to accomplish this.  
Other multi-level modeling approaches may use a domain specific language that is not in common use and does not have tools widely available for management and analysis of the models and data.  
As stated earlier, the growth in size of the data is only one issue with the direct markup approach.  An additional concern is the specific file format used for distribution.  In the direct markup approach there may be differences in semantics5 or in the ability to even markup the data at all, using various syntaxes.  In MLHIM this is solved, as a result of the well known and proven approaches for transforming XML to and from other syntaxes.  Because we are only transforming the data and not the metadata, it cannot be corrupted, misrepresented or misinterpreted.  
We have provided open source examples of this transformation process, specifically to and from JSON without any loss of semantics or the ability to validate the data against the schema (CCD).  See the MLHIM GitHub site at https://github.com/mlhim/mxic for further details. 
One last comment on the issues with the direct markup approach is that is not robust enough for mission-critical data management; certainly not for your clinical healthcare data.  This issue is widely recognized and is being addressed by W3C6. However, we know from previous experience that the W3C process is a slow one.  
In a few years, there may be widespread adoption and tools for validation of RDF syntaxes and/or the various levels of OWL.  At that time it will be easy enough to migrate to MLHIM 3.x using that approach.  But we need solutions today and MLHIM offers that solution now; with XML technologies.