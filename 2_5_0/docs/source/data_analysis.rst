===================
MLHIM Data Analysis
===================

The real value in data and especially in *semantically computable data* is in how you can use it after it is captured. Each implementation will have different analysis requirements from static reports to dynamic dashboards and decision support. MLHIM data is designed to accommodate all of these use cases. 

In many cases `XQuery <http://en.wikibooks.org/wiki/XQuery>`_ is a natural choice for analyzing data. However, there is excellent support in all major programming languages for XML data and implementers may choose to develop in their favorite programming language. 

The popular `R <http://cran.r-project.org/>`_ programming language is specifically designed for data analysis and supports XML data via an `XML package <http://cran.r-project.org/web/packages/XML/index.html>`_ using the commonly used `libxml2 library <http://xmlsoft.org/>`_ used by most of the other languages. Libxml2 includes complete XPath, Xpointer and Xinclude implementations. There is also a companion library called `libxslt <http://xmlsoft.org/XSLT/>`_ based on libxml2 that is used to provide support for `XML transformations <http://www.w3.org/TR/xslt>`_

The CCD-Gen provides example R code, automatically generated for each CCD as an R project for use in `R Studio <http://www.rstudio.com/>`_ or at the R command line. 

Data Description Levels
-----------------------
With the growing interest in *Big Data analytics*, various efforts are ongoing to improve the description of data and datasets. The various domains are attempting to use commonly developed vocabularies, such as the `Dublin Core Metadata Initiative <http://dublincore.org/>`_ terms, the `Data Catalog Vocabulary <http://www.w3.org/TR/vocab-dcat/>`_, `Schema.org <http://schema.org/>`_ and others. 

The popular approach is to use the vocabularies to directly *annotate the data*. We call this the *direct markup approach*. While this approach will work, to some limited extent. There are several problems with this method. The glaringly obvious one is that, more often than not, high quality, precise metadata is often much larger than the actual data being represented. Every instance of data and every copy of the dataset, must carry all of its own metadata. While storage size, memory size, processing speed and network bandwidth have improved immensely over the past decade. They are not infinite and every byte still counts; affecting overall performance in an inverse relationship. 

In conservative testing with MLHIM, we can see that the syntactic and semantic metadata for a data instance is typically about three times the size of the data instance itself. So including metadata with the data means a small 16kb data file is now 64kb. Not too bad when you look at it on that scale. However, the growth is linear with this *direct markup approach*. 

Let us say you record a time-series from some device and your data is 10MB. Now, for that one instance if it is marked up individually, the size blooms to 40MB. Even with today's technology, this is a significant payload to transfer. 

`Estimates are <http://www.storagenewsletter.com/rubriques/market-reportsresearch/ibm-cmo-study/>`_ that every day we create 2.5 quintillion (10 :sup:`18`) bytes of data. 
That linear expansion that resulted in a growth of 48kb is now a growth of **7.5 quintillion bytes; every day**.

Regardless of any sustainability estimates. Is it even a smart thing to do? 
When the data instances are marked up with semantics and they are being exchanged between systems (as medical information should be), there is no single point of reference to insure that the syntax or semantics of the information wasn't modified along the way. 

The MLHIM approach to the computable semantic interoperability problem does not have these issues. The metadata is developed by the modeler and it is immutable. In other words, this is what the modeler intended for the data to mean at this time and in this context. The model can then be referred to by any required number of data instances. The multi-level modeling approach to development is what enables this level of efficiency in data management. MLHIM uses the ubiquitous XML technology stack to accomplish this solution. Other multi-level modeling approaches may use a domain specific language that is not in common use and does not have tools widely available for management and analysis of the models and data. 

As stated earlier, the growth in size of the data is only one issue with the direct markup approach. An additional concern is the specific file format used for distribution. In the direct markup approach there may be differences in `semantics <http://goo.gl/oSTC1g>`_ or in the ability to even markup the data at all, using various syntaxes. In MLHIM this is solved, as a result of the well known and proven approaches for transforming XML to and from other syntaxes. Because we are only transforming the data and not the metadata, it cannot be corrupted, misrepresented or misinterpreted. 

We have provided open source examples of this transformation process, specifically to and from JSON without any loss of semantics or the ability to validate the data against the schema (CCD). See the `MXIC project <https://github.com/mlhim/mxic>`_ for further details. 

One last comment on the issues with the *direct markup approach* is that is not robust enough for mission-critical data management; certainly not for your clinical healthcare data. This issue is widely recognized and is being addressed by `W3C <http://www.w3.org/2012/12/rdf-val/report>`_. However, we know from previous experience that the W3C process is a slow one. 

In a few years, there may be widespread adoption and tools for validation of RDF syntaxes and/or the various levels of OWL. At that time it will be easy enough to migrate to MLHIM 3.x using that approach. But we need solutions today and MLHIM offers that solution now; with XML and RDF mix of technologies.
