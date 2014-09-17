Example CCDs for MLHIM Reference Implementation 2.4.5
=====================================================

This directory contains three example CCDs and supporting files created by a 2.4.5 development version of the CCD-Gen. 
These CCDs are examples only. They demonstrate all of the complexTypes and not necessarily good modelling practice.
The CCDs nor the PcTs are available for reuse. The production version of the CCD-Gen has more than 2000 reusable PcTs.
 
Each of the example CCDs are one of the three Entry types; Admin, Care and Demographic.
These CCDs are purposefully small in nature to help with understanding and readbility. 

The datatypes were created from entries in the Common Data Element Browser https://cdebrowser.nci.nih.gov/CDEBrowser/ 
See our peer-reviewed and other publications on reusing existing data types and legacy information systems. 

<i>The files in this directory are copies of the original CCDs and instances in the subfolders</i>. They are renamed here for ease of identification and to show that the filename is irrelevant in the XML context; except when you have them located in a DB and need to find them in your specific implemntation. 

Each of the subfolders include the (original) CCD XML Schema, an XML instance, a HTML form, a SHA1 hash file and a R Studio project folder as created by the CCD-Gen.

The R Sudio project contains a complete set of R files for creating dataframes for each Dv* datatype in this CCD. There are two 
example XML instances in the project as well as the required files for creating a complete R library.

Additional information can be found in the MLHIM 2.4.5 User Manual. 


Admin
-----
CCD ID: 
This CCD has an entry-data Cluster with current photo, insurance ID for accepted carriers and an active patient flag.
This one demonstrates an AdminEntry type with one small Cluster with PcTs for; DvMedia, DvIdentifier and DvBoolean.
This is one of the simplest type of CCD and does not have any audit tracking, workflow, etc.


Care
----
CCD ID: 
This CCD has information about a person's height, weight, Medication Administration dosage rate, blood pressure, pulse rate, body temperature and TB diagnosis. 
This one demonstrates an CareEntry type with three Clusters in the entry-data Cluster. This CCD has full audit trail, workflow, etc.
capbilities.

The PcTs used are; DvQuantity, DvCount, DvRatio, DvParsable, ReferenceRange, DvInterval, DvCodedString, DvURI, Party. 
Participation, Attestation and DvMedia.


Demographic
-----------
CCD ID: 
This CCD has an entry-data Cluster that contains two Clusters (Name Cluster and Address with telephone number Cluster) with three additional datatypes for date of birth, ethnicity and education, at the same hierarchical level as the Clusters.

The PcTs used here are DvString, DvOrdinal, DvTemporal
The telephone number PcT demonstrates the use of an xs:assert to validate the format of the DvString-dv. 

There are some duplications of PcT use to demonstrate how the use of UUIDs allow for using the same complexType from the RM with differnt syntax and semantics in the constraints.

Very complex asserts can be constructued, especially at the Cluster level. This allows virtually unlimited constraint capability.
For example any PcT element for any Dv in a Cluster can be accessed for evaluation in comparison to other Dv elements; including in other sub-Clusters.
 


