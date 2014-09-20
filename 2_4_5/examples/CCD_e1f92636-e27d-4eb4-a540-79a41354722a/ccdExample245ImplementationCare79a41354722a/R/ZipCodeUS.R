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
#' Returns a data.frame of the collected nodes of: \code{Zip Code (US)} from the XML instance passed as fileName.
#' The XML element name is el-3a45af86-b8fd-4161-b9e0-4ccf6322493a as a restriction of the mlhim244:DvString
#' The vectors are: ccd, data_name, ev-name, valid_time_begin, valid_time_end, ev_name, fileName,
#' DvString_dv, language
#' 
#' Used in address cluster for US Zip (postal) Codes. Minimum of 5 characters with a maximum of 10 characters. Accommodates the older 5 character codes or the Zip+4 with the additional 4 characters following a dash. 
#' 
#' Examples:
#' 12345
#' 12345-0987 
#' 
#' @references
#' The data is structured according to the Multi-Level Healthcare Information Modelling (MLHIM) Reference Model (RM) 2.4.4
#' \url{http://www.mlhim.org}
#' The semantic reference(s) for this data:
#' @references
#' \code{rdf:isDefinedBy} \url{https://www.usps.com/}
#' 
#' @param fileList - The path/file name(s) of the XML file(s) to process.
#' @return A dataframe consisting of the vectors listed in the Description.
#' 
#' @examples
#' files <- dir('./inst/examples', recursive=TRUE, full.names=TRUE, pattern='\\.xml$')
#' ZipCodeUS <- getZipCodeUS(files) 
#' 
#' @export
getZipCodeUS <- function(fileList)
{
    ldata <- lapply(fileList, parseZipCodeUS)
    clean <- ldata[!is.na(ldata)]
    data <- do.call(rbind,clean)
    return(data)
}

parseZipCodeUS <- function(fileName)
{
  doc <- xmlTreeParse(fileName, handlers=list('comment'=function(x,...){NULL}), asTree = TRUE)
  root <- xmlRoot(doc)
  ccduri <- ccduri() # function in each CCD metadata file
  nsDEF <- nsDEF() # function in each CCD metadata file
  pct <- getNodeSet(root, '//ccd:el-3a45af86-b8fd-4161-b9e0-4ccf6322493a', nsDEF)
  # assign common vectors a default
  data_name <- "Invalid data -- Missing data-name."
  ev_name <- NA
  valid_time_begin <- NA
  valid_time_end <- NA
  if (length(pct) > 0)
  {
      ccd <- xmlName(root)
      # test for an ExceptionalValue
      children <- getNodeSet(root, '//ccd:el-3a45af86-b8fd-4161-b9e0-4ccf6322493a/child::node()', nsDEF)
      if (!is.na(charmatch('mlhim244:',children[[2]]))) # the exceptional value elements are in the RM namespace
      {
        n <- getNodeSet(root, paste('//ccd:el-3a45af86-b8fd-4161-b9e0-4ccf6322493a/',xmlName(children[[2]]),'/ev-name'), nsDEF)
        ev_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-3a45af86-b8fd-4161-b9e0-4ccf6322493a/data-name', nsDEF)
      if (length(n) > 0)
      {
        data_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-3a45af86-b8fd-4161-b9e0-4ccf6322493a/valid-time-begin', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_begin <- as.POSIXct(ds)
      }
      
      n <- getNodeSet(root, '//ccd:el-3a45af86-b8fd-4161-b9e0-4ccf6322493a/valid-time-end', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_end <- as.POSIXct(ds)
      }
  
      # PcT defaults
      DvString_dv <- NA
      language <- NA
      
      n <- getNodeSet(root, '//ccd:el-3a45af86-b8fd-4161-b9e0-4ccf6322493a/DvString-dv', nsDEF)
      if (length(n) > 0)
      {
        DvString_dv <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-3a45af86-b8fd-4161-b9e0-4ccf6322493a/language', nsDEF)
      if (length(n) > 0)
      {
        language <- xmlValue(n[[1]])
      }
      
      data <- data.frame(ccd, data_name, valid_time_begin, valid_time_end,
                         DvString_dv,language,
                         ev_name, fileName, stringsAsFactors = FALSE)
      
  
  } else
  {
      data <- NA
  }
  
  return(data)
  
}
