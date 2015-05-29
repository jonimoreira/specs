==================================================
MLHIM as a Component of an Enterprise Architecture
==================================================

MLHIM is a core foundational part of any enterprise architecture that strives to attain *computable semantic interoperability*. In this chapter we will describe how the MLHIM eco-system fits into a typical healthcare IT architecture. Keeping in mind that MLHIM is also applicable to any size application that needs to be semantically Interoperable, from wearable devices to enterprise EHRs. 

`The Open Group Architecture Framework <http://pubs.opengroup.org/architecture/togaf9-doc/arch/index.html>`_ (TOGAF®) is a framework for enterprise architecture which provides an approach for designing, planning, implementing, and governing an enterprise information technology architecture. In this document it provides us with a formal method to communicate with implementers and decision makers on integrating MLHIM into the enterprise. 

We will focus on Part V (chapter 39) and Part VI (chapter 44) of the TOGAF specification; *Enterprise Continuum* and *Integrated Information Infrastructure Reference Model*. These chapters explore the view of the enterprise repository as part of the enterprise and the information technology industry at large as well as developing a sound foundation for boundary-less information flow. 

Referring to
`Figure 39-1 <http://pubs.opengroup.org/architecture/togaf9-doc/arch/chap39.html#tagfcjh_91>`_ and its description, the MLHIM reference model and its implementation fits into the category Architecture Continuum. In the details description and depicted graphically in `Figure 39-2 <http://pubs.opengroup.org/architecture/togaf9-doc/arch/chap39.html#tag_39_04_01>`_ are four conceptual architectures. Their relationship to MLHIM is described below. Keeping in mind that the granularity of MLHIM is much finer than these abstract architectures. However, this does serve as a good starting point.


TOGAF® Foundation Architectures
-------------------------------
The MLHIM specifications and reference implementation represent a foundation model on which to build more specific models. From a broader perspective, the XML family of technologies provides the foundation for ubiquity.

TOGAF® Common System Architectures
----------------------------------
The MLHIM CCDs are composed of multiple, reusable (pluggable) complexType restrictions of the reference model. These PcTs can be reused in many CCDs and can represent a common group of components. Again from the broader perspective the use of XML Schema 1.1 as an easily transported model is of primary importance as a common architecture.

TOGAF® Industry Architectures
----------------------------------
CCDs that have broad applicability in healthcare across many types of applications fit into the architecture.These CCDs may be openly licensed and shared globally. One might consider the availability of tools for XML in this category as well as tools that might be used specifically for creating MLHIM knowledge artifacts (PcTs and CCDs).

TOGAF® Organization Specific Architectures
------------------------------------------
CCDs that are used in applications within one organization are in this category. 

The reader should consult the details of the TOGAF® documentation as well as the remainder of this document, in order to understand the full implications of implementing MLHIM into large organizations. 

In `chapter 44 <http://pubs.opengroup.org/architecture/togaf9-doc/arch/chap44.html#tag_44>`_ of the TOGAF® specifications we focus more towards information interoperability of applications, regardless of their platform and location. Here we can discover the importance of ubiquitous technology in providing interoperability. This chapter focuses on a specific enterprise whereas with MLHIM we work with a global healthcare information scenario. There are multiple terminologies and ontologies to use, multiple languages, cultures and geographies to consider and the data essentially has no expiration date. Therefore, *The Boundaryless Information Flow problem space* for us is significantly larger than the TOGAF® specifications cover. However, the above descriptions should add some context to the MLHIM concepts for those developers that are familiar with existing enterprise architectures. Always keep in mind that implementations are local, CCDs and data instances are global.  


