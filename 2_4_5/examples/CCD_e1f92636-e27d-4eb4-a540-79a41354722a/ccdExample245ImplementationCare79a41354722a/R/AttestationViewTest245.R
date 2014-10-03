# Copyright 2014, Timothy W. Cook <tim@mlhim.org>
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#' Convert XML instance subset to a dataframe.
#'
#' Returns a data.frame of the collected nodes of: \code{Attestation View - Test 2.4.5} from the XML instance passed as fileName.
#' The XML element name is el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e as a restriction of the mlhim244:DvMedia
#' The vectors are: ccd, data_name, ev-name, valid_time_begin, valid_time_end, ev_name, fileName,
#' size, encoding, language, mime_type, compression_type, hash_result, hash_function, alt_txt, uri, media_content
#' 
#' A generic container for an attestation view.
#' 
#' @references
#' The data is structured according to the Multi-Level Healthcare Information Modelling (MLHIM) Reference Model (RM) 2.4.4
#' \url{http://www.mlhim.org}
#' The semantic reference(s) for this data:
#' (none provided by the modeller)
#' 
#' @param fileList - The path/file name(s) of the XML file(s) to process.
#' @return A dataframe consisting of the vectors listed in the Description.
#' 
#' @examples
#' files <- dir('./inst/examples', recursive=TRUE, full.names=TRUE, pattern='\\.xml$')
#' AttestationViewTest245 <- getAttestationViewTest245(files) 
#' 
#' @export
getAttestationViewTest245 <- function(fileList)
{
    ldata <- lapply(fileList, parseAttestationViewTest245)
    clean <- ldata[!is.na(ldata)]
    data <- do.call(rbind,clean)
    return(data)
}

parseAttestationViewTest245 <- function(fileName)
{
  doc <- xmlTreeParse(fileName, handlers=list('comment'=function(x,...){NULL}), asTree = TRUE)
  root <- xmlRoot(doc)
  ccduri <- ccduri() # function in each CCD metadata file
  nsDEF <- nsDEF() # function in each CCD metadata file
  pct <- getNodeSet(root, '//ccd:el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e', nsDEF)
  # assign common vectors a default
  data_name <- "Invalid data -- Missing data-name."
  ev_name <- NA
  valid_time_begin <- NA
  valid_time_end <- NA
  if (length(pct) > 0)
  {
      ccd <- xmlName(root)
      # test for an ExceptionalValue
      children <- getNodeSet(root, '//ccd:el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e/child::node()', nsDEF)
      if (!is.na(charmatch('mlhim244:',children[[2]]))) # the exceptional value elements are in the RM namespace
      {
        n <- getNodeSet(root, paste('//ccd:el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e/',xmlName(children[[2]]),'/ev-name'), nsDEF)
        ev_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e/data-name', nsDEF)
      if (length(n) > 0)
      {
        data_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e/valid-time-begin', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_begin <- as.POSIXct(ds)
      }
      
      n <- getNodeSet(root, '//ccd:el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e/valid-time-end', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_end <- as.POSIXct(ds)
      }
  
      # PcT defaults
      size <- NA
      encoding <- NA
      language <- NA
      mime_type <- NA
      compression_type <- NA
      hash_result <- NA
      hash_function <- NA
      alt_txt <- NA
      uri <- NA
      media_content <- NA
      
      n <- getNodeSet(root, '//ccd:el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e/size', nsDEF)
      if (length(n) > 0)
      {
        size <- as.numeric(xmlValue(n[[1]]))
      }
      
      n <- getNodeSet(root, '//ccd:el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e/encoding', nsDEF)
      if (length(n) > 0)
      {
        encoding <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e/language', nsDEF)
      if (length(n) > 0)
      {
        language <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e/mime-type', nsDEF)
      if (length(n) > 0)
      {
        mime_type <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e/compression-type', nsDEF)
      if (length(n) > 0)
      {
        compression_type <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e/hash-result', nsDEF)
      if (length(n) > 0)
      {
        hash_result <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e/hash-function', nsDEF)
      if (length(n) > 0)
      {
        hash_function <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e/alt-txt', nsDEF)
      if (length(n) > 0)
      {
        alt_txt <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e/uri', nsDEF)
      if (length(n) > 0)
      {
        uri <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-769d1fbc-ef3e-484b-bcec-c292bdb0f16e/media-content', nsDEF)
      if (length(n) > 0)
      {
        media_content <- xmlValue(n[[1]])
      }
      
      data <- data.frame(ccd, data_name, valid_time_begin, valid_time_end,
                         media_content,mime_type,language, size, encoding, alt_txt,uri,hash_function,hash_result,compression_type,
                         ev_name, fileName, stringsAsFactors = FALSE)
      
  
  } else
  {
      data <- NA
  }
  
  return(data)
  
}
