===================
MLHIM Data Analysis
===================
The real value in data and especially in semantically computable data is in how you can use it after it is captured. Each implementation will have different analysis requirements from static reports to dynamic dashboards and decision support. MLHIM data is designed to accommodate all of these use cases. 
In many cases XQuery1 is a natural choice for analyzing data. However, there is excellent support in all major programming languages for XML data and implementers may choose to develop in their favorite programming language. 
The popular R2 programming language is specifically designed for data analysis and supports XML data via an XML package3 using the commonly used libxml2 library4 used by most of the other languages. Libxml2 includes complete XPath, Xpointer and Xinclude implementations. There is also a companion library called libxslt5 based on libxml2 that is used to provide support for XML transformations (XSLT6)
The CCD-Gen provides example R code, automatically generated for each CCD as an R project in R Studio7 or at the R command line. 
