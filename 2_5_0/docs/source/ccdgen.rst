=================================================
Concept Constraint Definition Generator (CCD-Gen)
=================================================

Creating and Managing CCDs
==========================
The CCD-Gen is an online tool used to create CCDs via a web driven, declarative environment. The CCD-Gen allows the building of complete CCDs by selecting the desired Pluggable complexType (PcT) definitions from existing PcTs or ones that you design yourself.  You assemble the pieces into the concept definition you need.  By re-using PcTs you improve the data exchange and analysis capability.  Many of the PcTs have been designed based on existing data models.  Resources such as the Common Data Element definitions from the US National Cancer Institute, the United States Health Information Knowledgebase (USHIK) from the Agency for Healthcare Research and Quality (AHRQ) and HL7 FHIR® models have been translated to PcTs.  More are planned and you can contribute to the open content effort.
The CCD is an XML Schema that is compliant with the W3C XML Schema 1.1 standards. It is valid against one MLHIM Reference Model release. However, many of the PcTs maybe used in CCDs across various reference model releases. A CCD provides an approach to improve the process of allowing semantic interoperability between various applications. This process is enabled due the ability to exchange the syntax and semantics for data models designed by domain experts. 
The CCD-Gen has a library of some of the CCDs created using this tool. Because of the governance approach to CCDs there is no need for a centralized repository. Though, it is helpful to have some place for potential users to review published examples.  The CCD-Gen Library page displays the CCDs in a table and an included XSLT renders the details of the CCD (click on the Title link) in a familiar data dictionary format. This is similar to how applications can extract this information from the CCD for user help pages and tooltips. 

Data Instances
--------------
The CCD-Gen creates one sample instance along with every CCD.  These samples are valid instances of the CCD schema.  The one exception is when an xs:assert is used in a PcT definition.  The instance generator cannot (yet) create guaranteed valid data content for any arbitrary assert statement.  If your sample is not valid, this is likely the case.  For regular expressions (regexes) used to describe a string pattern in a DvString-dv element, the CCD-Gen can handle most patterns.  Strings like postal codes, phone numbers, etc. should be randomly created okay.  Other PcTs have no facility for xs:assert matching.  

HTML Forms
----------
There are hundreds of possibilities for uses of data when defining a model.  Any given application component may write to multiple CCD instances at any one time.  There is no apriori solution for this.

The CCD-Gen takes the most generic approach and creates a HTML form that depicts the nested nature of data defined by this CCD.  This automatically generated form is more appropriately useful as a communications tool between the knowledge modeler (domain expert) and the software developer. It allows the developer to visually see the structure of the data. 
This form also includes helpful information for the developer to relate the visual content to the CCD and data instance.  

There is a tooltip on every structure name (Cluster, DvString, etc.) that provides the UUID for that structure. A HTTP link is also provided here that connects the developer to the specific documentation on the MLHIM website concerning that portion of the Reference Model. 
The textual semantics for each component is also presented.  A tooltip on these names/titles provided by the modeler displays the documentation as well as all links/semantic references that the modeler included in the PcT. This provides the developer with the same context that the modeler used when defining the PcT.  

R Code
------
The CCD-Gen, in conjunction with each CCD, creates source code for use with the R statistical programming environment1.  Specifically the code is created in a project suitable for use in R Studio2, a package development and management tool for R. 
The code is package complete and compliant for distribution via the The Comprehensive R Archive Network3 (CRAN mirrors4). You can use R Studio or the R tools for package creation to generate the desired package format, either source or compiled binary for a specific platform (Linux, Mac, Windows, etc.). The code written by the CCD-Gen also contains package documentation (R help files) that can be created using the tools mentioned above.  
The R code is created on a PcT level and will return a dataframe from all matching instances of a PcT.  For example you may search across a complete repository of XML instances and receive a dataframe containing all occurrences of a specific PcT in a CCD.  Users should note however that the generated R code will only return the first instance in a given file. 
For more practical use, the code modules can be edited and combined into an application specific library and used to build any desired data structure based on the content of  your repository.  For example you may want to provide an additional loop or apply function to gather cases where multiple instances appear within a given DvAdapter node. 
Customizing these basic routines allows the analyst to apply any of the thousands of algorithms available as R packages to their MLHIM based data repository. 

Users and developers should note that the metadata.R file is not included in the NAMESPACES that are exported.  However, it is required for every other R file since there are functions for XML namespace resolution located there. This file must be specifically 'sourced'.  You may optionally include it in your NAMESPACE file.
