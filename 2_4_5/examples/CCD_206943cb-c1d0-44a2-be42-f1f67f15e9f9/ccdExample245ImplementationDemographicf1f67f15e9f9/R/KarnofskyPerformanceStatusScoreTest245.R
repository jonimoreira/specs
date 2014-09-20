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
#' Returns a data.frame of the collected nodes of: \code{Karnofsky Performance Status Score - Test 2.4.5} from the XML instance passed as fileName.
#' The XML element name is el-a11f7b2d-4391-4177-989f-06cd48b7ec5b as a restriction of the mlhim244:DvOrdinal
#' The vectors are: ccd, data_name, ev-name, valid_time_begin, valid_time_end, ev_name, fileName,
#' reference_ranges, normal_status, DvOrdinal_dv, symbol
#' 
#' Score from the Karnofsky Performance status scale, representing the functional capabilities of a person. 
#' 
#' @references
#' The data is structured according to the Multi-Level Healthcare Information Modelling (MLHIM) Reference Model (RM) 2.4.4
#' \url{http://www.mlhim.org}
#' The semantic reference(s) for this data:
#' @references
#' \code{rdf:isDefinedBy} \url{https://cdebrowser.nci.nih.gov/CDEBrowser/search?elementDetails=9&FirstTimer=0&PageId=ElementDetailsGroup&publicId=2003853&version=4.2}
#' 
#' @param fileList - The path/file name(s) of the XML file(s) to process.
#' @return A dataframe consisting of the vectors listed in the Description.
#' 
#' @examples
#' files <- dir('./inst/examples', recursive=TRUE, full.names=TRUE, pattern='\\.xml$')
#' KarnofskyPerformanceStatusScoreTest245 <- getKarnofskyPerformanceStatusScoreTest245(files) 
#' 
#' @export
getKarnofskyPerformanceStatusScoreTest245 <- function(fileList)
{
    ldata <- lapply(fileList, parseKarnofskyPerformanceStatusScoreTest245)
    clean <- ldata[!is.na(ldata)]
    data <- do.call(rbind,clean)
    return(data)
}

parseKarnofskyPerformanceStatusScoreTest245 <- function(fileName)
{
  doc <- xmlTreeParse(fileName, handlers=list('comment'=function(x,...){NULL}), asTree = TRUE)
  root <- xmlRoot(doc)
  ccduri <- ccduri() # function in each CCD metadata file
  nsDEF <- nsDEF() # function in each CCD metadata file
  pct <- getNodeSet(root, '//ccd:el-a11f7b2d-4391-4177-989f-06cd48b7ec5b', nsDEF)
  # assign common vectors a default
  data_name <- "Invalid data -- Missing data-name."
  ev_name <- NA
  valid_time_begin <- NA
  valid_time_end <- NA
  if (length(pct) > 0)
  {
      ccd <- xmlName(root)
      # test for an ExceptionalValue
      children <- getNodeSet(root, '//ccd:el-a11f7b2d-4391-4177-989f-06cd48b7ec5b/child::node()', nsDEF)
      if (!is.na(charmatch('mlhim244:',children[[2]]))) # the exceptional value elements are in the RM namespace
      {
        n <- getNodeSet(root, paste('//ccd:el-a11f7b2d-4391-4177-989f-06cd48b7ec5b/',xmlName(children[[2]]),'/ev-name'), nsDEF)
        ev_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-a11f7b2d-4391-4177-989f-06cd48b7ec5b/data-name', nsDEF)
      if (length(n) > 0)
      {
        data_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-a11f7b2d-4391-4177-989f-06cd48b7ec5b/valid-time-begin', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_begin <- as.POSIXct(ds)
      }
      
      n <- getNodeSet(root, '//ccd:el-a11f7b2d-4391-4177-989f-06cd48b7ec5b/valid-time-end', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_end <- as.POSIXct(ds)
      }
  
      # PcT defaults
      reference_ranges <- NA
      normal_status <- NA
      DvOrdinal_dv <- NA
      symbol <- NA
      
      n <- getNodeSet(root, '//ccd:el-a11f7b2d-4391-4177-989f-06cd48b7ec5b/normal-status', nsDEF)
      if (length(n) > 0)
      {
        normal_status <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-a11f7b2d-4391-4177-989f-06cd48b7ec5b/DvOrdinal-dv', nsDEF)
      if (length(n) > 0)
      {
        DvOrdinal_dv <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-a11f7b2d-4391-4177-989f-06cd48b7ec5b/symbol', nsDEF)
      if (length(n) > 0)
      {
        symbol <- xmlValue(n[[1]])
      }
      
      data <- data.frame(ccd, data_name, valid_time_begin, valid_time_end,
                         normal_status, reference_ranges,
                         ev_name, fileName, stringsAsFactors = FALSE)
      
  
  } else
  {
      data <- NA
  }
  
  return(data)
  
}
