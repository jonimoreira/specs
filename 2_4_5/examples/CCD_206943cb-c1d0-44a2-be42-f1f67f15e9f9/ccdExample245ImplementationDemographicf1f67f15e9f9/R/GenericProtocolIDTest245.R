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
#' Returns a data.frame of the collected nodes of: \code{Generic Protocol ID - Test 2.4.5} from the XML instance passed as fileName.
#' The XML element name is el-90f19fde-c3b0-422a-85ad-30ed7139c57a as a restriction of the mlhim244:DvIdentifier
#' The vectors are: ccd, data_name, ev-name, valid_time_begin, valid_time_end, ev_name, fileName,
#' DvString_dv, language, id_name, issuer, assignor
#' 
#' A reusable system ID for Entry Protocol ID.
#' 
#' @references
#' The data is structured according to the Multi-Level Healthcare Information Modelling (MLHIM) Reference Model (RM) 2.4.4
#' \url{http://www.mlhim.org}
#' The semantic reference(s) for this data:
#' @references
#' \code{rdf:isDefinedBy} \url{http://www.mlhim.org}
#' 
#' @param fileList - The path/file name(s) of the XML file(s) to process.
#' @return A dataframe consisting of the vectors listed in the Description.
#' 
#' @examples
#' files <- dir('./inst/examples', recursive=TRUE, full.names=TRUE, pattern='\\.xml$')
#' GenericProtocolIDTest245 <- getGenericProtocolIDTest245(files) 
#' 
#' @export
getGenericProtocolIDTest245 <- function(fileList)
{
    ldata <- lapply(fileList, parseGenericProtocolIDTest245)
    clean <- ldata[!is.na(ldata)]
    data <- do.call(rbind,clean)
    return(data)
}

parseGenericProtocolIDTest245 <- function(fileName)
{
  doc <- xmlTreeParse(fileName, handlers=list('comment'=function(x,...){NULL}), asTree = TRUE)
  root <- xmlRoot(doc)
  ccduri <- ccduri() # function in each CCD metadata file
  nsDEF <- nsDEF() # function in each CCD metadata file
  pct <- getNodeSet(root, '//ccd:el-90f19fde-c3b0-422a-85ad-30ed7139c57a', nsDEF)
  # assign common vectors a default
  data_name <- "Invalid data -- Missing data-name."
  ev_name <- NA
  valid_time_begin <- NA
  valid_time_end <- NA
  if (length(pct) > 0)
  {
      ccd <- xmlName(root)
      # test for an ExceptionalValue
      children <- getNodeSet(root, '//ccd:el-90f19fde-c3b0-422a-85ad-30ed7139c57a/child::node()', nsDEF)
      if (!is.na(charmatch('mlhim244:',children[[2]]))) # the exceptional value elements are in the RM namespace
      {
        n <- getNodeSet(root, paste('//ccd:el-90f19fde-c3b0-422a-85ad-30ed7139c57a/',xmlName(children[[2]]),'/ev-name'), nsDEF)
        ev_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-90f19fde-c3b0-422a-85ad-30ed7139c57a/data-name', nsDEF)
      if (length(n) > 0)
      {
        data_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-90f19fde-c3b0-422a-85ad-30ed7139c57a/valid-time-begin', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_begin <- as.POSIXct(ds)
      }
      
      n <- getNodeSet(root, '//ccd:el-90f19fde-c3b0-422a-85ad-30ed7139c57a/valid-time-end', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_end <- as.POSIXct(ds)
      }
  
      # PcT defaults
      DvString_dv <- NA
      language <- NA
      id_name <- NA
      issuer <- NA
      assignor <- NA
      
      n <- getNodeSet(root, '//ccd:el-90f19fde-c3b0-422a-85ad-30ed7139c57a/DvString-dv', nsDEF)
      if (length(n) > 0)
      {
        DvString_dv <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-90f19fde-c3b0-422a-85ad-30ed7139c57a/language', nsDEF)
      if (length(n) > 0)
      {
        language <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-90f19fde-c3b0-422a-85ad-30ed7139c57a/id-name', nsDEF)
      if (length(n) > 0)
      {
        id_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-90f19fde-c3b0-422a-85ad-30ed7139c57a/issuer', nsDEF)
      if (length(n) > 0)
      {
        issuer <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-90f19fde-c3b0-422a-85ad-30ed7139c57a/assignor', nsDEF)
      if (length(n) > 0)
      {
        assignor <- xmlValue(n[[1]])
      }
      
      data <- data.frame(ccd, data_name, valid_time_begin, valid_time_end,
                         DvString_dv,language,id_name, issuer, assignor,
                         ev_name, fileName, stringsAsFactors = FALSE)
      
  
  } else
  {
      data <- NA
  }
  
  return(data)
  
}
