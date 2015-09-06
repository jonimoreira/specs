# Copyright 2015, Timothy W. Cook <tim@mlhim.org>
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#'
#' MLHIM 2.5.0 DvFile
#'
#'
#' Returns a data.frame of the collected nodes of a DvFile restriction from the XML fragment.
#'
#' The vectors are:
#'
#' label - the descriptive name of the fragment.
#'
#' vtb - valid time begin, the datetime that this data became valid
#'
#' vte - valid time end, the datetime this data expired or ceased to be valid
#'
#' ev_name - exceptional value name. When all data is valid according to the restrictions this is NA.
#'           See the MLHIM documentation for explainations of Exceptional Values.
#'
#' size - Original size in bytes of unencoded encapsulated data. I.e. encodings such as base64, hexadecimal, etc. do not change the value of this element.
#'
#' encoding - Name of character encoding scheme in which this value is encoded.
#'            Coded from the IANA charcater set table http://www.iana.org/assignments/character-sets
#'            Unicode is the default assumption in MLHIM2, with UTF-8 being the assumed encoding.
#'            This attribute allows for variations from these assumptions.
#'
#' dvfile_language - Optional indicator of the localised language of the content.
#'
#' formalism - Name of the formalism or syntax used to inform an application regarding a candidate parser to use on the content.
#'             Examples might include: 'ATL', 'MOLA', 'QVT', 'GDL', 'GLIF', etc.
#'
#' media_type - Media (MIME) type of the original media-content w/o any compression. See IANA registered types: http://www.iana.org/assignments/media-types/media-types.xhtml
#'
#' compression_type - Compression/archiving mime-type. If this elements does not exist then it means there is no compression/archiving.
#'                    For a list of common mime-types for compression/archiving see: http://en.wikipedia.org/wiki/List_of_archive_formats.
#'
#' hash_result - Hash function result of the 'media-content'. There must be a corresponding hash function type listed for this to have any meaning.
#'              See: http://en.wikipedia.org/wiki/List_of_hash_functions#Cryptographic_hash_functions
#'
#' hash_function - Hash function used to compute hash-result. See: http://en.wikipedia.org/wiki/List_of_hash_functions#Cryptographic_hash_functions
#'
#' alt_txt - Text to display in lieu of multimedia display or execution.
#'
#' uri - URI reference to electronic information stored outside the record as a file, database entry etc, if supplied as a reference.
#'
#' media_content - The content, if stored locally as binary content.
#'
#' text_content - The content, if stored locally as text content.
#'
#' NOTE: uri, media_content and text_content are mutually exclusive. One and only one of these three will have a value in a valid instance.
#'
#' @param pcm - the XML fragment to parse.
#' @return A dataframe consisting of the vectors listed in the Description.
#'
#' @examples
#' parseBladderTestingOnly <- function(sourceName){
#'
#' doc <- XML::xmlTreeParse(sourceName, handlers=list('comment'=function(x,...){NULL}), asTree = TRUE)
#' root <- XML::xmlRoot(doc)
#'
#' pcm <- XML::getNodeSet(root, '//mlhim2:pcs-780f834c-f29f-46aa-bb50-3384e9884138', c(mlhim2='http://www.mlhim.org/ns/mlhim2/'))
#'
#' data <- lapply(pcm, mlhim250rm::DvFile)
#' data <- data.table::rbindlist(data)
#' data$ccd <- XML::xmlName(root)
#' data$pcs <- 'pcs-780f834c-f29f-46aa-bb50-3384e9884138'
#' data$sourceName <- sourceName
#'
#' return(data)
#' }
#'
#' @export
DvFile <- function(pcm) {
  nsDEF <- c(mlhim2='http://www.mlhim.org/ns/mlhim2/')

  # assign common vectors a default
  label <- 'Invalid data -- Missing label.'
  vtb <- NA
  vte <- NA
  if (length(pcm) > 0)
  {
    # test for an ExceptionalValue
    ev_name <- XML::getNodeSet(pcm, '//ev-name', nsDEF)
    if (length(ev_name) > 0) {
      ev_name <- XML::xmlValue(ev_name[[1]])
    } else {
      ev_name <- NA
    }

    n <- XML::getNodeSet(pcm, '//label', nsDEF)

    if (length(n) > 0)
    {
      label <- XML::xmlValue(n[[1]])

    }

    n <- XML::getNodeSet(pcm, '//vtb', nsDEF)
    if (length(n) > 0)
    {
      ds <- XML::xmlValue(n[[1]])
      ds <- gsub('T', ' ', ds)
      vtb <- as.POSIXct(ds)
    }

    n <- XML::getNodeSet(pcm, '//vte', nsDEF)
    if (length(n) > 0)
    {
      ds <- XML::xmlValue(n[[1]])
      ds <- gsub('T', ' ', ds)
      vte <- as.POSIXct(ds)
    }

    # PCMdefaults
    size <- NA
    encoding <- NA
    dvfile_language <- NA
    formalism <- NA
    media_type <- NA
    compression_type <- NA
    hash_result <- NA
    hash_function <- NA
    alt_txt <- NA
    uri <- NA
    media_content <- NA
    text_content <- NA

    n <- XML::getNodeSet(pcm, '//size', nsDEF)
    if (length(n) > 0)
    {
      size <- XML::xmlValue(n[[1]])
    }

    n <- XML::getNodeSet(pcm, '//encoding', nsDEF)
    if (length(n) > 0)
    {
      encoding <- XML::xmlValue(n[[1]])
    }

    n <- XML::getNodeSet(pcm, '//dvfile-language', nsDEF)
    if (length(n) > 0)
    {
      dvfile_language <- XML::xmlValue(n[[1]])
    }

    n <- XML::getNodeSet(pcm, '//formalism', nsDEF)
    if (length(n) > 0)
    {
      formalism <- XML::xmlValue(n[[1]])
    }

    n <- XML::getNodeSet(pcm, '//media-type', nsDEF)
    if (length(n) > 0)
    {
      media_type <- XML::xmlValue(n[[1]])
    }

    n <- XML::getNodeSet(pcm, '//compression-type', nsDEF)
    if (length(n) > 0)
    {
      compression_type <- XML::xmlValue(n[[1]])
    }

    n <- XML::getNodeSet(pcm, '//hash-result', nsDEF)
    if (length(n) > 0)
    {
      hash_result <- XML::xmlValue(n[[1]])
    }

    n <- XML::getNodeSet(pcm, '//hash-function', nsDEF)
    if (length(n) > 0)
    {
      hash_function <- XML::xmlValue(n[[1]])
    }

    n <- XML::getNodeSet(pcm, '//alt-txt', nsDEF)
    if (length(n) > 0)
    {
      alt_txt <- XML::xmlValue(n[[1]])
    }

    n <- XML::getNodeSet(pcm, '//uri', nsDEF)
    if (length(n) > 0)
    {
      uri <- XML::xmlValue(n[[1]])
    }

    n <- XML::getNodeSet(pcm, '//media-content', nsDEF)
    if (length(n) > 0)
    {
      media_content <- XML::xmlValue(n[[1]])
    }

    n <- XML::getNodeSet(pcm, '//text-content', nsDEF)
    if (length(n) > 0)
    {
      text_content <- XML::xmlValue(n[[1]])
    }

    data <- data.frame(label, vtb, vte,
                       size, encoding, dvfile_language, formalism, media_type, compression_type, hash_result, hash_function, alt_txt,
                       uri, media_content, text_content,
                       ev_name, stringsAsFactors = FALSE)

  } else
  {
    data <- NA
  }

  return(data)

}
