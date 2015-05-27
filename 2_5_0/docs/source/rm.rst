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

The reference implementation complexType descriptions. The prefix 'xs:' is used to indicate W3C XML Schema datatypes. 

DvAnyType
---------

Derived from:  n/a
Abstract: True
*Description:*  Serves as a common ancestor of all data-types in MLHIM models.
*Contains elements:*

Name
Type
minOccurs
maxOccurs
Description
data-name
xs:string
1
1
Descriptive name of this fragment.
ExceptionalValue
ExceptionalValueType
0
1
Any of the restrictions of the ExceptionalValueType.
valid-time-begin
xs:dataTime
0
1
If present this must be a valid datetime including timezone. It is used to indicate the beginning time that information is considered valid or when the information was collected.

valid-time-end
xs:dataTime
0
1
If present this must be a valid datetime including timezone. It is used to indicate the ending time that information is considered valid.




DvBooleanType
--------------
Derived from: DvAnyType by extension
 Abstract: False

Description:  Items which represent boolean decisions, such as true/false or yes/no answers. Use for such data, it is important to devise the meanings (usually questions in subjective data) carefully, so that the only allowed results are in fact true or false.  The possible choices for True or False are enumerations in the CCD. The reference model defines valid-true and valid-false in a choice so only one or the other may be present in the instance data.
Potential Misuse: The DvBooleanType should not be used as a replacement for naively       modeled enumerated types such as male/female etc. Such values should be coded, and in any case the enumeration often has more than two values. The elements, valid-true and valid-false are contained in an xs:choice and only one or the other is instantiated in the instance data with its value coming from the enumerations defined in a CCD. 

Name
Type
minOccurs
maxOccurs
Description
valid-true
xs:string
0
1
A string that represents a boolean True in the implementation. These are generally constrained by a set of enumerations in the PcT. 
valid-false
xs:string
0
1
A string that represents a boolean False in the implementation. These are generally constrained by a set of enumerations in the PcT.





DvLinkType
----------
Derived from: DvAnyType by extension
 Abstract: False

Description:  Used to specify a Universal Resource Identifier. Set the pattern to accommodate your needs in a CCD.


Name
Type
minOccurs
maxOccurs
Description
DvURI-dv
xs:anyURI
1
1
anyURI as a pointer.
relation
xs:string
1
1
Normally constrained by on ontology such as the OBO RO http://purl.obolibrary.org/obo/ro.owl



DvStringType
------------
Derived from: DvAnyType by extension
 Abstract: False

Description:  The string data type can contain characters, line feeds, carriage returns, and tab characters.

Name
Type
minOccurs
maxOccurs
Description
DvString-dv
xs:string
0
1
The string value of the item.
language
xs:language
0
1
Optional indicator of the localized language in which this data-type is written. The ·value space· of language is the set of all strings that are valid language identifiers as defined [RFC 3066]. Only required when the language used here is different from the enclosing Entry.




DvFileType
----------
Derived from: DvAnyType by extension
 Abstract: False

Description:  A specialization of DvEncapsulatedType for audiovisual and bio-signal types. Includes further metadata relating to media types which are not applicable to other subtypes of DvEncapsulatedType.


Name
Type
minOccurs
maxOccurs
Description
mime-type
xs:string
0
1
MIME type of the original media-content w/o any compression. See IANA registered types: http://www.iana.org/assignments/media-types/index.html
compression-type
xs:string
0
1
Compression/archiving mime-type. Void means no compression/archiving. For a list of common mime-types for compression/archiving see: http://en.wikipedia.org/wiki/List_of_archive_formats
hash-result
xs:string
0
1
Hash function result of the 'media-content'. There must be a corresponding hash function type listed for this to have any meaning. See: http://en.wikipedia.org/wiki/List_of_hash_functions#Cryptographic_hash_functions
hash-function
xs:string
0
1
Hash function used to compute hash-result. See: http://en.wikipedia.org/wiki/List_of_hash_functions#Cryptographic_hash_functions
alt-txt
xs:string
0
1
Text to display in lieu of multimedia display or execution.
uri
xs:string
0
1
URI reference to electronic information stored outside the record as a file, database entry etc, if supplied as a reference.
media-content
xs:base64Binary
0
1
The content; if stored locally.


DvOrderedType
-------------
Derived from: DvAnyType by extension
 Abstract: True

Description:  Abstract class defining the concept of ordered values, which includes ordinals as well as true quantities. The implementations require the functions ‘<’, '>' and is_strictly_comparable_to ('==').


Name
Type
minOccurs
maxOccurs
Description
reference-ranges
ReferenceRangeType
0
unbounded
Optional list of ReferenceRanges for this value in its particular measurement context. Implemented as restrictions on the ReferenceRangeType.

normal-status
xs:string
0
1
Optional normal status indicator of value with respect to normal range for this value. Often included by lab, even if the normal range itself is not included. Coded by ordinals in series HHH, HH, H, (nothing), L, LL, LLL, etc. 


DvOrdinalType
-------------
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


Name
Type
minOccurs
maxOccurs
Description
DvOrdinal-dv
xs:decimal
1
1
Value in ordered enumeration of values. The base integer is zero with any number of integer values used to order the symbols. Example 1: 0 = Trace, 1 = +, 2 = ++, 3 = +++, etc. Example 2: 0 = Mild, 1 = Moderate, 2 = Severe
symbol
xs:string
1
1
Coded textual representation of this value in the enumeration, which may be strings made from “+” symbols, or other enumerations of terms such as “mild”, “moderate”, “severe”, or even the same number series as the values, e.g. “1”, “2”, “3”.


DvQuantifiedType
----------------
Derived from: DvOrderedType by extension
 Abstract: True

Description:  Abstract type defining the concept of true quantified values, i.e. values which are not only ordered, but which have a precise magnitude.


Name
Type
minOccurs
maxOccurs
Description
magnitude
xs:decimal
0
1
Numeric value of the quantity in canonical (i.e. single value) form.
magnitude-status
xs:string
0
1
Optional status of magnitude with values:
                
                “=” : magnitude is a point value
                
                “<“ : value is < magnitude
                
                “>” : value is > magnitude
                
                “<=” : value is <= magnitude
                
                “>=” : value is >= magnitude
                
                “~” : value is the approximate magnitude

error
xs:int
0
1
Error margin of measurement, indicating error in the recording method or instrument (+/- %). Implemented in subtypes. A logical value of 0 indicates 100% accuracy, i.e. no error.
accuracy
xs:decimal
0
1
Accuracy of the value in the magnitude attribute. 0% to +/- 100% A value of 0 means that the accuracy is unknown.


DvCountType
-----------
Derived from: DvQuantifiedType by extension
 Abstract: False

Description:  Countable quantities. Used for countable types such as pregnancies and steps (taken by a physiotherapy patient), number of cigarettes smoked in a day, etc. Misuse:Not used for amounts of physical entities (which all have standardized units). Note that PcTs derived from DvCountType should make magnitude, error and accuracy attributes minOccurs = '1'. The magnitude element is restricted to integers via an xs:assert.


Name
Type
minOccurs
maxOccurs
Description
DvCount-units
DvStringType
1
1
The name or type of the countable quantity. Examples: cigarettes, drinks, pregnancies, episodes, etc. implemented as a DvStringType restriction. 



DvQuantityType
--------------
Derived from: DvQuantifiedType by extension
 Abstract: False

Description: Quantified type representing “scientific” quantities, i.e. quantities expressed as a magnitude and units. Can also be used for time durations, where it is more convenient to treat these as simply a number of individual seconds, minutes, hours, days, months, years, etc. when no temporal calculation is to be performed. Note that PcTs derived from DvQuantityType should make magnitude, error and accuracy attributes minOccurs = '1'.


Name
Type
minOccurs
maxOccurs
Description
DvQuanity-units
DvStringType
1
1
Stringified units, expressed in unit syntax, e.g. "kg/m2", “mm[Hg]", "ms-1", "km/h". A DvCodedStringType should be used when possible. UOM codes can be found: http://www.obofoundry.org Also available in other terminologies such as SNOMEDCT; implemented as a DvStringType restriction. 



DvRatioType
-----------
Derived from: DvQuantifiedType by extension
 Abstract: False

Description: Models a ratio of values, i.e. where the numerator and denominator are both pure numbers. Should not be used to represent things like blood pressure which are often written using a ‘/’ character, giving the misleading impression that the item is a ratio, when in fact it is a structured value. Similarly, visual acuity, often written as (e.g.) “6/24” in clinical notes is not a ratio but an ordinal (which includes non-numeric symbols like CF = count fingers etc). Should not be used for formulations. 


Name
Type
minOccurs
maxOccurs
Description
ratio-type
xs:string
1
1
Indicates semantic type of ratio must be set as fixed to one of the below strings in PcTs.
ratio = a relationship between two numbers.
proportion = a relationship between two numbers where there is a bi-univocal relationship between the numerator and the denominator (the numerator is contained in the denominator)
rate = a relationship between two numbers where there is not a bi-univocal relationship between the numerator and the denominator (the numerator is not contained in the denominator) 
numerator
xs:decimal
0
1
numerator of ratio 
denominator
xs:decimal
0
1
denominator of ratio
numerator-units
DvStringType
0
1
Used to convey the meaning of the numerator. Typically countable units such as; cigarettes, drinks, exercise periods, etc. May or may not come from a terminology such as OBO Foundry Units ontology; implemented as a DvStringType restriction. 
denominator-units
DvStringType
0
1
Used to convey the meaning of the denominator. Typically units such as; days, years, months, etc. May or may not come from a standard terminology; implemented as a DvStringType restriction. 
ratio-units
DvStringType
0
1
Used to convey the meaning of the magnitude (ratio units). May or may not come from a standard terminology. In many cases there is not a meaningful term for the magnitude.  Implemented as a DvStringType restriction. 



DvTemporalType
--------------
Derived from: DvOrderedType by extension
 Abstract: False

Description: Type defining the concept of date and time types. Must be constrained in PcTs to be one or more of the below elements.  This gives the modeler the ability to optionally allow full or partial dates at run time.  Setting maxOccurs and minOccurs to zero causes the element to be prohibited.


Name
Type
minOccurs
maxOccurs
Description
dvtemporal-date
xs:date
0
1
See the W3C documentation.
dvtemporal-time
xs:time
0
1
See the W3C documentation.
dvtemporal-datetime
xs:dateTime
0
1
See the W3C documentation.
dvtemporal-day
xs:gDay
0
1
See the W3C documentation.
dvtemporal-month
xs:gMonth
0
1
See the W3C documentation.
dvtemporal-year
xs:gYear
0
1
See the W3C documentation.
dvtemporal-year-month
xs:gYearMonth
0
1
See the W3C documentation.
dvtemporal-month-day
xs:gMonthDay
0
1
See the W3C documentation.
dvtemporal-duration
xs:duration
0
1
See the W3C documentation.
dvtemporal-ymduration
xs:yearMonthDuration
0
1
See the W3C documentation.
dvtemporal-dtduration
xs:dayTimeDuration
0
1
See the W3C documentation.



DvIntervalType
--------------
Derived from: DvAnyType by extension
 Abstract: False

Description: Generic type defining an interval (i.e. range) of a comparable type. An interval is a contiguous subrange of a comparable base type. Used to define intervals of dates, times, quantities, etc. Whose datatypes are the same and are ordered.   


Name
Type
minOccurs
maxOccurs
Description
lower
inv-type
0
1
Defines the lower value of the interval.
upper
inv-type
0
1
Defines the upper value of the interval.
lower-included
xs:boolean
1
1
Is the lower value of the interval inclusive?. 
upper-included
xs:boolean
1
1
Is the upper value of the interval inclusive?.
lower-bounded
xs:boolean
1
1
Is the lower value of the interval bounded?. 
upper-bounded
xs:boolean
1
1
Is the upper value of the interval bounded?.
IntervalUnits
----
0
1
A group of the two following elements for an optional units definition. 
units-name
xs:string
1
1
The common name or abbreviation for the units.
units-uri
xs:anyURI
1
1
The URI for a definition of the units.


invl-type
Derived from: n/a 
 Abstract: False

Description: Defines the data type of the DvIntervalType upper and lower elements.  In a CCD restriction, the xs:choice is constrained to one of the reference model  elements with minOccurs = 1 and a fixed attribute defining the value. If the value is unbounded, then the element in the CCD will not have the fixed attribute. Instead it will have nillable="true" and an xs:assert to validate the instance has an empty element. E.g. <xs:assert test='boolean(invl-int/node()) = false()'/>
The instances must also declare the value as nil, e.g. <invl-int xsi:nil='true'/>

Name
Type
minOccurs
maxOccurs
Description
invl-int
xs:int
0
1
Defines the upper or lower interval datatype.
invl-decimal
xs:decimal
0
1
Defines the upper or lower interval datatype.
invl-float
xs:float
0
1
Defines the upper or lower interval datatype.
invl-date
xs:date
0
1
Defines the upper or lower interval datatype.
invl-time
xs:time
0
1
Defines the upper or lower interval datatype.
invl-datetime
xs:dateTime
0
1
Defines the upper or lower interval datatype.
invl-duration
xs:duration
0
1
Defines the upper or lower interval datatype.

ReferenceRangeType
------------------
Derived from: DvAnyType by extension
 Abstract: False

Description: Defines a named range to be associated with any ORDERED datum. Each range is particular to the patient and context, e.g. sex, age, and any other factor which affects ranges. May be used to represent normal, therapeutic, dangerous, critical, etc. lists of concepts. 


Name
Type
minOccurs
maxOccurs
Description
referencerange-definition
xs:string
1
1
Term whose value indicates the meaning of this range, e.g. “normal”, “critical”, “therapeutic” etc.
data-range
DvIntervalType
1
1
The data range for this meaning, as a restriction on a DvIntervalType.
is-normal
xs:boolean
1
1
True if this reference range only contains values that are considered to be normal.

AuditType
---------
Derived from: n/a
 Abstract: False

Description: AuditType provides a mechanism to identifiy the who/where/when tracking of instances as they move from system to system.

Name
Type
minOccurs
maxOccurs
Description
system-id
DvIdentifierType
1
1
Identifier of the system which handled the information item.'Systems' can also be defined as an individual application or a data repository in which the data was manipulated.
system-user

PartyType
0
1
User(s) who created, committed, forwarded or otherwise handled the item.
location
ItemType
0
1
Location information of the particular site/facility within an organization which handled the item.
timestamp
xs:dateTime
1
1
Timestamp of handling the item. For an originating system, this will be time of creation,for an intermediate feeder system, this will be a time of accession or other time of handling, where available.


PartyType
---------
Derived from: n/a
 Abstract: False

Description: Description of a party, including an optional external link to data for this party in a demographic or other identity management system. An additional details element provides for the inclusion of information related to this party directly. If the party information is to be anonymous then do not include the details element. The string 'Self' may be entered as the party-name if an external_ref is include.


Name
Type
minOccurs
maxOccurs
Description
party-name
xs:string
0
1
Optional human-readable name (in String form).
external-ref
DvURIType
0
1
Optional reference to more detailed demographic or identification information for this party, in an external system.
details
ItemType
0
1
Structural details about the party.



AttestationType
---------------
Derived from: n/a
 Abstract: False

Description: Record an attestation by a party of item(s) of record content. The type of attestation is recorded by the reason attribute, which may be coded.
 
Name
Type
minOccurs
maxOccurs
Description
attested-view
DvMediaType
0
1
Optional visual representation of content attested e.g. screen image.
proof
DvParsableType
0
1
Proof of attestation such as a GPG signature. 
reason
DvStringType
0
1
Reason of this attestation. Coded from a standardized vocabulary.
committer
PartyType
0
1
Identity of person who committed the item.
time-commited
xs:dateTime
0
1
Datetime of committal of the item.
is-pending
xs:boolean
0
1
True if this attestation is outstanding; 'false' means it has been completed.



ParticipationType
-----------------
Derived from: n/a
 Abstract: False

Description: Model of a participation of a Party (any Actor or Role) in an activity. Used to represent any participation of a Party in some activity, which is not explicitly in the model, e.g. assisting nurse. Can be used to record past or future participations. Should not be used in place of more permanent relationships between demographic entities.


Name
Type
minOccurs
maxOccurs
Description
performer
PartyType
0
1

function
DvStringType
0
1

mode
DvStringType
0
1

start-time
xs:dateTime
0
1

end-time
xs:dateTime
0
1





ExceptionalValueType
--------------------
Derived from: n/a
 Abstract: True

Description:  Subtypes are used to indicate why a value is missing (Null) or is outside a measurable range. The element ev-name is fixed in restricted types to a descriptive string. The subtypes defined in the reference model are considered sufficiently generic to be useful in many instances.  CCDs may contain additional ExceptionalValueType restrictions. 


Name
Type
minOccurs
maxOccurs
Description
ev-name
xs:string
1
1
The fixed name of the exceptional value.



NIType
--------------
Derived from: ExceptionalValueType by restriction
 Abstract: False

Description:  No Information: The value is exceptional (missing, omitted, incomplete, improper). No information as to the reason for being an exceptional value is provided. This is the most general exceptional value. It is also the default exceptional value.


MSKType
--------------
Derived from: ExceptionalValueType by restriction
 Abstract: False

Description:  Masked: There is information on this item available but it has not been provided by the sender due to security, privacy or other reasons. There may be an alternate mechanism for gaining access to this information. 
Warning:
    Using this exceptional value does provide information that may be a breach of confidentiality, even though no detail data is provided. Its primary purpose is for those circumstances where it is necessary to inform the receiver that the information does exist without providing any detail.


INVType
--------------
Derived from: ExceptionalValueType by restriction
 Abstract: False

Description:  Invalid: The value as represented in the instance is not a member of the set of permitted data values in the constrained value domain of a variable.


DERType
--------------
Derived from: ExceptionalValueType by restriction
 Abstract: False

Description:  Derived: An actual value may exist, but it must be derived from the provided information; usually an expression is provided directly.


UNCType
--------------
Derived from: ExceptionalValueType by restriction
 Abstract: False

Description:  Unencoded: No attempt has been made to encode the information correctly but the raw source information is represented, usually in free text.


OTHType
--------------
Derived from: ExceptionalValueType by restriction
 Abstract: False

Description:  Other: The actual value is not a member of the permitted data values in the variable. (e.g., when the value of the variable is not by the coding system)


NINFType
--------------
Derived from: ExceptionalValueType by restriction
 Abstract: False

Description:  Negative Infinity: Negative infinity of numbers


PINFType
--------------
Derived from: ExceptionalValueType by restriction
 Abstract: False

Description:  Positive Infinity: Positive infinity of numbers


UNKType
--------------
Derived from: ExceptionalValueType by restriction
 Abstract: False

Description:  Unknown: A proper value is applicable, but not known.


ASKRType
--------------
Derived from: ExceptionalValueType by restriction
 Abstract: False

Description:  Asked and Refused: Information was sought but refused to be provided (e.g., patient was asked but refused to answer)


NASKType
--------------
Derived from: ExceptionalValueType by restriction
 Abstract: False

Description:  Not Asked: This information has not been sought (e.g., patient was not asked)


QSType
--------------
Derived from: ExceptionalValueType by restriction
 Abstract: False

Description:  Sufficient Quantity : The specific quantity is not known, but is known to non-zero and it is not specified because it makes up the bulk of the material; Add 10mg of ingredient X, 50mg of ingredient Y and sufficient quantity of water to 100mL.


TRCType
--------------
Derived from: ExceptionalValueType by restriction
 Abstract: False

Description:  Trace: The content is greater or less than zero but too small to be quantified.


ASKUType
--------------
Derived from: ExceptionalValueType by restriction
 Abstract: False

Description:  Asked but Unknown: Information was sought but not found (e.g., patient was asked but did not know)


NAVType
--------------
Derived from: ExceptionalValueType by restriction
 Abstract: False

Description: Not Available: This information is not available and the specific reason is not known.


NAType
--------------
Derived from: ExceptionalValueType by restriction
 Abstract: False

Description:  Not Applicable: No proper value is applicable in this context e.g.,the number of cigarettes smoked per day by a non-smoker subject.

ItemType
--------------
Derived from: n/a 
 Abstract: True

Description:  The abstract parent of ClusterType and DvAdapterType structural representation types.

ClusterType
--------------
Derived from: ItemType by extension
 Abstract: False

Description:  The grouping variant of Item, which may contain further instances of Item, in an ordered list. This provides the root ItemType for arbitrarily complex structures.

Name
Type
minOccurs
maxOccurs
Description
cluster-subject
xs:string
1
1
Descriptive name of this branch.
items
ItemType
0
unbounded
List of Item types.



DvAdapterType
--------------
Derived from: ItemType by extension
 Abstract: False

Description:  The leaf variant of Item, to which any DvAnyType subtype instance is attached for use in a Cluster. 

Name
Type
minOccurs
maxOccurs
Description
DvAdapter-dv
DvAnyType
0
unbounded
Data value type of this leaf.
NOTE: The purpose for maxOccurs being unbounded is for validation of multiple instances of a DvAnyType subtype.  This seems odd, but it is how it works.  It is NOT for allowing multiple DvAnyType restrictions in one DvAdapterType. 

EntryType
--------------
Derived from: n/a
 Abstract: True

Description: The abstract parent of all Entry subtypes. An Entry is the root of a logical set of data items. Each subtype has an identical information structure. The subtyping is used to allow persistence to separate the types of Entries; primarily import in healthcare for the de-identification of clinical information.

Name
Type
minOccurs
maxOccurs
Description
entry-links
DvURIType
0
unbounded
Optional link(s) to other locatable structures or external entities.
entry-audit
AuditType
0
unbounded
Audit trail from the system of original commit of information forming the content of this node through each system of handling the data.
language
xs:language
1
1
Mandatory indicator of the localised language in which this Entry is written. The value space of language is the set of all strings that are valid language identifiers as defined [RFC 3066] 
encoding
xs:string
1
1
Name of character set encoding in which text values in this Entry are encoded. Default should be utf-8.
entry-subject
PartyType
0
1
Id of human subject of this Entry, e.g.: • subject of record (patient, etc.) • organ donor • fetus • a family member • another clinically relevant person.
entry-provider
PartyType
0
1
Optional identification of the source of the information in this Entry, which might be: • the patient• a patient agent, e.g. parent, guardian • the clinician • a device or software
other-participations
ParticipationType
0
unbounded
List of other participations at Entry level.
protocol-id
DvIdentifierType
0
1
Optional external identifier of protocol used to create this Entry. This could be a clinical guideline, an operations protocol,etc.
current-state
xs:string
0
1
The current state according to the state machine / workflow engine identified in workflow-id as a string.
workflow-id
DvURIType
0
1
Identifier of externally held workflow engine (state machine) data for this workflow execution.
attestation
AttestationType
0
1
Attestation recorded.
entry-data
ItemType
1
1
The data structure of the Entry.



CareEntryType
--------------
Derived from: EntryType by extension
 Abstract: False

Description:  Entry subtype for all entries related to care of a subject of record.

AdminEntryType
--------------
Derived from: EntryType by extension
 Abstract: False

Description:  Entry subtype for administrative information, i.e. information about setting up the clinical process, but not itself clinically relevant. Archetypes will define contained information. Used for administrative details of admission, episode, ward location, discharge, appointment (if not stored in a practice management or appointments system). Not used for any clinically significant information.

DemographicEntryType
--------------------
Derived from: EntryType by extension
 Abstract: False

Description:  Entry subtype for demographic information, i.e. name structures, roles, locations, etc. modeled as a separate type from AdminEntryType in order to facilitate the separation of clinical and non-clinical information to support de-identification of clinical and administrative data.

CCDType
--------------
Derived from: n/a
 Abstract: False

Description:  This is the root node of a Concept Constraint Definition.

Name
Type
minOccurs
maxOccurs
Description
definition
EntryType
1
1
Structural definition element for this CCD.



Example CCD 
--------------
Please check the website documents section as well as the CCD Library on the CCD-Gen.
The CCD-Gen requires free registration in order to view the CCD Library. 
