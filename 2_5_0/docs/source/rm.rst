===================
The Reference Model
===================

**Note:**  Any discrepancies between this document and the XML Schema implementation is to be resolved by the XML Schema RM. The automatically generated XML Schema documentation is available in PDF and downloadable HTML forms: http://mlhim.org/documents.html The sources are maintained on GitHub at https://github.com/mlhim/specs To get the most recent development version using git create a clone of https://github.com/mlhim/specs.git Then checkout the most recent branch.

Assumed Types
=============

There are several types that are assumed to be supported by the underlying implementation technology. These assumed types are based on XML Schema 1.1 Part 2 Datatypes. They should be available in your implementation language or add-on libraries. The names may or may not be exactly the same.

-----------------
Non-Ordered Types
-----------------

boolean 
-------
Two state only.  Either true or false.


string
-------
The string data type can contain characters, line feeds, carriage returns, and tab characters.

anyURI
------
Specifies a Unique Resource Identifier (URI).

-----------------
Ordered types
-----------------

dateTime
--------
The dateTime data type is used to specify a date and a time.
The dateTime is specified in the following form "YYYY-MM-DDThh:mm:ss" where:
    YYYY indicates the year
    MM indicates the month
    DD indicates the day
    T indicates the start of the required time section
    hh indicates the hour
    mm indicates the minute
    ss indicates the second
The following is an example of a dateTime declaration in a schema:
<xs:element name="startdate" type="xs:dateTime"/>

An element in your document might look like this:
<startdate>2002-05-30T09:00:00</startdate>
Or it might look like this:
<startdate>2002-05-30T09:30:10:05</startdate>

*Time Zones*

To specify a time zone, you can either enter a dateTime in UTC time by adding a "Z" behind the time - like this:
<startdate>2002-05-30T09:30:10Z</startdate> 
or you can specify an offset from the UTC time by adding a positive or negative time behind the time - like this:
<startdate>2002-05-30T09:30:10-06:00</startdate>
or
<startdate>2002-05-30T09:30:10+06:00</startdate> 

date
----
The date data type is used to specify a date.

The date is specified in the following form "YYYY-MM-DD" where:

    YYYY indicates the year
    MM indicates the month
    DD indicates the day

An element in an XML Document  might look like this:
<start>2002-09-24</start> 

time
----
The time data type is used to specify a time.
The time is specified in the following form "hh:mm:ss" where:
    hh indicates the hour
    mm indicates the minute
    ss indicates the second

The following is an example of a time declaration in a schema:
<xs:element name="start" type="xs:time"/>
An element in your document might look like this:
<start>09:00:00</start>
Or it might look like this:
<start>09:30:10:05</start>

*Time Zones* 

To specify a time zone, you can either enter a time in UTC time by adding a "Z" behind the time - like this:
<start>09:30:10Z</start>
or you can specify an offset from the UTC time by adding a positive or negative time behind the time - like this:
<start>09:30:10-06:00</start>  or  <start>09:30:10+06:00</start>
duration
The duration data type is used to specify a time interval.
The time interval is specified in the following form "PnYnMnDTnHnMnS" where:
    P indicates the period (required)
    nY indicates the number of years
    nM indicates the number of months
    nD indicates the number of days
    T indicates the start of a time section (required if you are going to specify hours, minutes, or seconds)
    nH indicates the number of hours
    nM indicates the number of minutes
    nS indicates the number of seconds
The following is an example of a duration declaration in a schema:
<xs:element name="period" type="xs:duration"/>

An element in your document might look like this:
<period>P5Y</period>
The example above indicates a period of five years.
Or it might look like this:
<period>P5Y2M10D</period>
The example above indicates a period of five years, two months, and 10 days.
Or it might look like this:
<period>P5Y2M10DT15H</period>
The example above indicates a period of five years, two months, 10 days, and 15 hours.
Or it might look like this:
<period>PT15H</period>
The example above indicates a period of 15 hours.
Negative Duration
To specify a negative duration, enter a minus sign before the P:
<period>-P10D</period>
The example above indicates a period of minus 10 days.

Partial Date Types
------------------
Support for partial dates is essential to avoid poor data quality. In order to provide for partial dates and times the following types are assumed to be available in the language or in a library.

*Day* – provide on the day of the month, 1 – 31
*Month* – provide only the month of the year, 1 – 12
*Year* – provide on the year,  CCYY
*MonthDay* – provide only the Month and the Day (no year)
*YearMonth* – provide only the Year and the Month (no day)

real
----
The decimal data type is used to specify a numeric value.
Note: The maximum number of decimal digits you can specify is 18.

integer
-------
The integer data type is used to specify a numeric value without a fractional component.


2.5.0 Reference Model Documentation
===================================

The complete documentation in a graphical, clickable format is available on the MLHIM website [Documents page](http://mlhim.org/documents.html).  

An EMF Ecore project is available in the docs folder of the distribution. It can be imported into Eclipse and used as a base for modelling CCDs. However, developers need to be aware that there are slight differences due to the fact taht Eclipse XML tools do not support XML Schema 1.1 

Further research is needed to determine if valid CCDs can be produced from Eclipse. 

---------------
RM complexTypes
---------------

The reference implementation complexType descriptions. 

Each complexType definition below has a `Schema Docs <http://mlhim.org/rm250_html/>`_. This link goes to a page with detailed documentation on that complexType. 


DvAnyType
-----------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DvAnyType.html#DvAnyType>`_

Derived from:  n/a

Abstract: True

Description:  Serves as a common ancestor of all data-types in MLHIM models.

DvBooleanType
--------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DvBooleanType.html#DvBooleanType>`_

Derived from: DvAnyType by extension

Abstract: False

Description:  Items which represent boolean decisions, such as true/false or yes/no answers. Use for such data, it is important to devise the meanings (usually questions in subjective data) carefully, so that the only allowed results are in fact true or false.  The possible choices for True or False are enumerations in the CCD. The reference model defines valid-true and valid-false in a choice so only one or the other may be present in the instance data.
Potential Misuse: The DvBooleanType should not be used as a replacement for naively       modeled enumerated types such as male/female etc. Such values should be coded, and in any case the enumeration often has more than two values. The elements, valid-true and valid-false are contained in an xs:choice and only one or the other is instantiated in the instance data with its value coming from the enumerations defined in a CCD. 

DvLinkType
----------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DvLinkType.html#DvLinkType>`_

Derived from: DvAnyType by extension

Abstract: False

Description:  Used to specify a Universal Resource Identifier. Set the pattern to accommodate your needs in a CCD.

DvStringType
------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DvStringType.html#DvStringType>`_

Derived from: DvAnyType by extension

Abstract: False

Description:  The string data type can contain characters, line feeds, carriage returns, and tab characters.

DvFileType
----------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DvFileType.html#DvFileType>`_

Derived from: DvAnyType by extension

Abstract: False

Description:  A specialization of DvEncapsulatedType for audiovisual and bio-signal types. Includes further metadata relating to media types which are not applicable to other subtypes of DvEncapsulatedType.

DvOrderedType
-------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DvOrderedType.html#DvOrderedType>`_

Derived from: DvAnyType by extension

Abstract: True

Description:  Abstract class defining the concept of ordered values, which includes ordinals as well as true quantities. The implementations require the functions ‘<’, '>' and is_strictly_comparable_to ('==').

DvOrdinalType
-------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DvOrdinalType.html#DvOrdinalType>`_

Derived from: DvOrderedType by extension

Abstract: False

Description:  Models rankings and scores, e.g. pain, Apgar values, etc, where there is 
a) implied ordering, 
b) no implication that the distance between each value is constant, and 
c) the total number of values is finite.
Note that although the term ‘ordinal’ in mathematics means natural numbers only, here any decimal is allowed, since negative and zero values are often used by medical professionals for values around a neutral point. Also, decimal values are sometimes used such as 0.5 or .25 
Examples of sets of ordinal values: 
-3, -2, -1, 0, 1, 2, 3 -- reflex response values
0, 1, 2 -- Apgar values 

Used for recording any clinical datum which is customarily recorded using symbolic values.
    
    Example: the results on a urinalysis strip, e.g. {neg, trace, +, ++, +++} are used for leukocytes, protein, nitrites etc; for non-haemolysed blood {neg, trace, moderate}; for haemolysed blood {neg, trace, small, moderate, large}

DvQuantifiedType
----------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DvQuantifiedType.html#DvQuantifiedType>`_

Derived from: DvOrderedType by extension

Abstract: True

Description:  Abstract type defining the concept of true quantified values, i.e. values which are not only ordered, but which have a precise magnitude.

DvCountType
-----------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DvCountType.html#DvCountType>`_

Derived from: DvQuantifiedType by extension

Abstract: False

Description:  Countable quantities. Used for countable types such as pregnancies and steps (taken by a physiotherapy patient), number of cigarettes smoked in a day, etc. Misuse:Not used for amounts of physical entities (which all have standardized units). Note that PcTs derived from DvCountType should make magnitude, error and accuracy attributes minOccurs = '1'. The magnitude element is restricted to integers via an xs:assert.

DvQuantityType
--------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DvQuantityType.html#DvQuantityType>`_

Derived from: DvQuantifiedType by extension

Abstract: False

Description: Quantified type representing “scientific” quantities, i.e. quantities expressed as a magnitude and units. Can also be used for time durations, where it is more convenient to treat these as simply a number of individual seconds, minutes, hours, days, months, years, etc. when no temporal calculation is to be performed. Note that PcTs derived from DvQuantityType should make magnitude, error and accuracy attributes minOccurs = '1'.


DvRatioType
-----------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DvRatioType.html#DvRatioType>`_

Derived from: DvQuantifiedType by extension

Abstract: False

Description: Models a ratio of values, i.e. where the numerator and denominator are both pure numbers. Should not be used to represent things like blood pressure which are often written using a ‘/’ character, giving the misleading impression that the item is a ratio, when in fact it is a structured value. Similarly, visual acuity, often written as (e.g.) “6/24” in clinical notes is not a ratio but an ordinal (which includes non-numeric symbols like CF = count fingers etc). Should not be used for formulations. 


DvTemporalType
--------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DvTemporalType.html#DvTemporalType>`_

Derived from: DvOrderedType by extension

Abstract: False

Description: Type defining the concept of date and time types. Must be constrained in PcTs to be one or more of the below elements.  This gives the modeler the ability to optionally allow full or partial dates at run time.  Setting maxOccurs and minOccurs to zero causes the element to be prohibited.


DvIntervalType
--------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DvIntervalType.html#DvIntervalType>`_

Derived from: DvAnyType by extension

Abstract: False

Description: Generic type defining an interval (i.e. range) of a comparable type. An interval is a contiguous subrange of a comparable base type. Used to define intervals of dates, times, quantities, etc. Whose datatypes are the same and are ordered.   


InvlType
--------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_InvlType.html#InvlType>`_

Derived from: n/a 

Abstract: False

Description: Defines the data type of the DvIntervalType upper and lower elements.  In a CCD restriction, the xs:choice is constrained to one of the reference model  elements with minOccurs = 1 and a fixed attribute defining the value. If the value is unbounded, then the element in the CCD will not have the fixed attribute. Instead it will have nillable="true" and an xs:assert to validate the instance has an empty element. E.g. <xs:assert test='boolean(invl-int/node()) = false()'/>
The instances must also declare the value as nil, e.g. <invl-int xsi:nil='true'/>


ReferenceRangeType
------------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_ReferenceRangeType.html#ReferenceRangeType>`_

Derived from: DvAnyType by extension

Abstract: False

Description: Defines a named range to be associated with any ORDERED datum. Each range is particular to the patient and context, e.g. sex, age, and any other factor which affects ranges. May be used to represent normal, therapeutic, dangerous, critical, etc. lists of concepts. 

AuditType
---------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_AuditType.html#AuditType>`_

Derived from: n/a

Abstract: False

Description: AuditType provides a mechanism to identifiy the who/where/when tracking of instances as they move from system to system.

PartyType
---------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_PartyType.html#PartyType>`_

Derived from: n/a

Abstract: False

Description: Description of a party, including an optional external link to data for this party in a demographic or other identity management system. An additional details element provides for the inclusion of information related to this party directly. If the party information is to be anonymous then do not include the details element. The string 'Self' may be entered as the party-name if an external_ref is include.

AttestationType
---------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_AttestationType.html#AttestationType>`_

Derived from: n/a

Abstract: False

Description: Record an attestation by a party of item(s) of record content. The type of attestation is recorded by the reason attribute, which may be coded.

ParticipationType
-----------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_ParticipationType.html#ParticipationType>`_

Derived from: n/a

Abstract: False

Description: Model of a participation of a Party (any Actor or Role) in an activity. Used to represent any participation of a Party in some activity, which is not explicitly in the model, e.g. assisting nurse. Can be used to record past or future participations. Should not be used in place of more permanent relationships between demographic entities.

ExceptionalValueType
--------------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_ExceptionalValueType.html#ExceptionalValueType>`_

Derived from: n/a

Abstract: True

Description:  Subtypes are used to indicate why a value is missing (Null) or is outside a measurable range. The element ev-name is fixed in restricted types to a descriptive string. The subtypes defined in the reference model are considered sufficiently generic to be useful in many instances.  CCDs may contain additional ExceptionalValueType restrictions. 


NIType
------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_NIType.html#NIType>`_

Derived from: ExceptionalValueType by restriction

Abstract: False

Description:  No Information: The value is exceptional (missing, omitted, incomplete, improper). No information as to the reason for being an exceptional value is provided. This is the most general exceptional value. It is also the default exceptional value.

MSKType
-------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_MSKType.html#MSKType>`_

Derived from: ExceptionalValueType by restriction

Abstract: False

Description:  Masked: There is information on this item available but it has not been provided by the sender due to security, privacy or other reasons. There may be an alternate mechanism for gaining access to this information. 
.. Warning:
    Using this exceptional value does provide information that may be a breach of confidentiality, even though no detail data is provided. Its primary purpose is for those circumstances where it is necessary to inform the receiver that the information does exist without providing any detail.

INVType
-------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_INVType.html#INVType>`_

Derived from: ExceptionalValueType by restriction

Abstract: False

Description:  Invalid: The value as represented in the instance is not a member of the set of permitted data values in the constrained value domain of a variable.

DERType
-------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DERType.html#DERType>`_

Derived from: ExceptionalValueType by restriction

Abstract: False

Description:  Derived: An actual value may exist, but it must be derived from the provided information; usually an expression is provided directly.

UNCType
-------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_UNCType.html#UNCType>`_

Derived from: ExceptionalValueType by restriction

Abstract: False

Description:  Unencoded: No attempt has been made to encode the information correctly but the raw source information is represented, usually in free text.

OTHType
-------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_OTHType.html#OTHType>`_

Derived from: ExceptionalValueType by restriction

Abstract: False

Description:  Other: The actual value is not a member of the permitted data values in the variable. (e.g., when the value of the variable is not by the coding system)


NINFType
--------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_NINFType.html#NINFType>`_

Derived from: ExceptionalValueType by restriction

Abstract: False

Description:  Negative Infinity: Negative infinity of numbers


PINFType
--------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_PINFType.html#PINFType>`_

Derived from: ExceptionalValueType by restriction

Abstract: False

Description:  Positive Infinity: Positive infinity of numbers

UNKType
-------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_UNKType.html#UNKType>`_

Derived from: ExceptionalValueType by restriction

Abstract: False

Description:  Unknown: A proper value is applicable, but not known.

ASKRType
--------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_ASKRType.html#ASKRType>`_

Derived from: ExceptionalValueType by restriction

Abstract: False

Description:  Asked and Refused: Information was sought but refused to be provided (e.g., patient was asked but refused to answer)

NASKType
--------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_NASKType.html#NASKType>`_

Derived from: ExceptionalValueType by restriction

Abstract: False

Description:  Not Asked: This information has not been sought (e.g., patient was not asked)


QSType
------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_QSType.html#QSType>`_

Derived from: ExceptionalValueType by restriction

Abstract: False

Description:  Sufficient Quantity : The specific quantity is not known, but is known to non-zero and it is not specified because it makes up the bulk of the material; Add 10mg of ingredient X, 50mg of ingredient Y and sufficient quantity of water to 100mL.

TRCType
-------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_TRCType.html#TRCType>`_

Derived from: ExceptionalValueType by restriction

Abstract: False

Description:  Trace: The content is greater or less than zero but too small to be quantified.

ASKUType
--------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_ASKUType.html#ASKUType>`_

Derived from: ExceptionalValueType by restriction

Abstract: False

Description:  Asked but Unknown: Information was sought but not found (e.g., patient was asked but did not know)


NAVType
-------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_NAVType.html#NAVType>`_

Derived from: ExceptionalValueType by restriction

Abstract: False

Description: Not Available: This information is not available and the specific reason is not known.

NAType
------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_NAType.html#NAType>`_

Derived from: ExceptionalValueType by restriction

Abstract: False

Description:  Not Applicable: No proper value is applicable in this context e.g.,the number of cigarettes smoked per day by a non-smoker subject.

ItemType
--------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_ItemType.html#ItemType>`_

Derived from: n/a 

Abstract: True

Description:  The abstract parent of ClusterType and DvAdapterType structural representation types.

ClusterType
-----------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DvAnyType.html#DvAnyType>`_

Derived from: ItemType by extension

Abstract: False

Description:  The grouping variant of Item, which may contain further instances of Item, in an ordered list. This provides the root ItemType for arbitrarily complex structures.

DvAdapterType
-------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DvAdapterType.html#DvAdapterType>`_

Derived from: ItemType by extension

Abstract: False

Description:  The leaf variant of Item, to which any DvAnyType subtype instance is attached for use in a Cluster. 

EntryType
---------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_EntryType.html#EntryType>`_

Derived from: n/a

Abstract: True

Description: The abstract parent of all Entry subtypes. An Entry is the root of a logical set of data items. Each subtype has an identical information structure. The subtyping is used to allow persistence to separate the types of Entries; primarily import in healthcare for the de-identification of clinical information.

CareEntryType
-------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_CareEntryType.html#CareEntryType>`_

Derived from: EntryType by extension

Abstract: False

Description:  Entry subtype for all entries related to care of a subject of record.

AdminEntryType
--------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_AdminEntryType.html#AdminEntryType>`_

Derived from: EntryType by extension

Abstract: False

Description:  Entry subtype for administrative information, i.e. information about setting up the clinical process, but not itself clinically relevant. Archetypes will define contained information. Used for administrative details of admission, episode, ward location, discharge, appointment (if not stored in a practice management or appointments system). Not used for any clinically significant information.

DemographicEntryType
--------------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DemographicEntryType.html#DemographicEntryType>`_

Derived from: EntryType by extension

Abstract: False

Description:  Entry subtype for demographic information, i.e. name structures, roles, locations, etc. modeled as a separate type from AdminEntryType in order to facilitate the separation of clinical and non-clinical information to support de-identification of clinical and administrative data.

CCDType
-------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_CCDType.html#CCDType>`_

Derived from: n/a

Abstract: False

Description:  This is the root node of a Concept Constraint Definition.


Example CCD 
--------------

`Schema Docs <http://mlhim.org/rm250_html/mlhim250_xsd_Complex_Type_mlhim2_DvAnyType.html#DvAnyType>`_

Please check the website documents section as well as the CCD Library on the CCD-Gen.
The CCD-Gen requires free registration in order to view the CCD Library. 
