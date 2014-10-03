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
#' Returns a data.frame of the collected nodes of: \code{Systolic Blood Pressure Value} from the XML instance passed as fileName.
#' The XML element name is el-4016fb70-0ef8-4a26-b6e0-d1c6549efe1a as a restriction of the mlhim245:DvQuantity
#' The vectors are: ccd, data_name, ev-name, valid_time_begin, valid_time_end, ev_name, fileName,
#' reference_ranges, normal_status, magnitude, magnitude_status, error, accuracy, DvQuantity_units
#' 
#' The pressure of the blood against the artery walls during systole (the contraction phase). 
#' 
#' @references
#' The data is structured according to the Multi-Level Healthcare Information Modelling (MLHIM) Reference Model (RM) 2.4.5
#' \url{http://www.mlhim.org}
#' The semantic reference(s) for this data:
#' @references
#' \code{rdf:isDefinedBy} \url{https://cdebrowser.nci.nih.gov/CDEBrowser/}
#' 
#' @param fileList - The path/file name(s) of the XML file(s) to process.
#' @return A dataframe consisting of the vectors listed in the Description.
#' 
#' @examples
#' files <- dir('./inst/examples', recursive=TRUE, full.names=TRUE, pattern='\\.xml$')
#' SystolicBloodPressureValue <- getSystolicBloodPressureValue(files) 
#' 
#' @export
getSystolicBloodPressureValue <- function(fileList)
{
    ldata <- lapply(fileList, parseSystolicBloodPressureValue)
    clean <- ldata[!is.na(ldata)]
    data <- do.call(rbind,clean)
    return(data)
}

parseSystolicBloodPressureValue <- function(fileName)
{
  ccduri <- ccduri() # function in each CCD metadata file
  nsDEF <- nsDEF() # function in each CCD metadata file
  doc <- xmlTreeParse(fileName, handlers=list('comment'=function(x,...){NULL}), asTree = TRUE)
  root <- xmlRoot(doc)
  pct <- getNodeSet(root, '//ccd:el-4016fb70-0ef8-4a26-b6e0-d1c6549efe1a', nsDEF)
  # assign common vectors a default
  data_name <- 'Invalid data -- Missing data-name.'
  ev_name <- NA
  valid_time_begin <- NA
  valid_time_end <- NA
  if (length(pct) > 0)
  {
      ccd <- xmlName(root)
      # test for an ExceptionalValue
      children <- getNodeSet(root, '//ccd:el-4016fb70-0ef8-4a26-b6e0-d1c6549efe1a/child::node()', nsDEF)
      if (!is.na(charmatch('mlhim245:',children[[2]]))) # the exceptional value elements are in the RM namespace
      {
        n <- getNodeSet(root, paste('//ccd:el-4016fb70-0ef8-4a26-b6e0-d1c6549efe1a/',xmlName(children[[2]]),'/ev-name'), nsDEF)
        ev_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-4016fb70-0ef8-4a26-b6e0-d1c6549efe1a/data-name', nsDEF)
      if (length(n) > 0)
      {
        data_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-4016fb70-0ef8-4a26-b6e0-d1c6549efe1a/valid-time-begin', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_begin <- as.POSIXct(ds)
      }
      
      n <- getNodeSet(root, '//ccd:el-4016fb70-0ef8-4a26-b6e0-d1c6549efe1a/valid-time-end', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_end <- as.POSIXct(ds)
      }
  
      # PcT defaults
      reference_ranges <- NA
      normal_status <- NA
      magnitude <- NA
      magnitude_status <- NA
      error <- NA
      accuracy <- NA
      DvQuantity_units <- 'Invalid data -- Missing units.'
      
      n <- getNodeSet(root, '//ccd:el-4016fb70-0ef8-4a26-b6e0-d1c6549efe1a/normal-status', nsDEF)
      if (length(n) > 0)
      {
        normal_status <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-4016fb70-0ef8-4a26-b6e0-d1c6549efe1a/magnitude', nsDEF)
      if (length(n) > 0)
       {
         magnitude <- as.numeric(xmlValue(n[[1]]))
       }
       n <- getNodeSet(root, '//ccd:el-4016fb70-0ef8-4a26-b6e0-d1c6549efe1a/mlhim245:magnitude-status', nsDEF)
       if (length(n) > 0)
        {
         magnitude_status <- xmlValue(n[[1]])
        }
      n <- getNodeSet(root, '//ccd:el-4016fb70-0ef8-4a26-b6e0-d1c6549efe1a/error', nsDEF)
      if (length(n) > 0)
       {
         error <- as.numeric(xmlValue(n[[1]]))
       }
      n <- getNodeSet(root, '//ccd:el-4016fb70-0ef8-4a26-b6e0-d1c6549efe1a/accuracy', nsDEF)
      if (length(n) > 0)
       {
         accuracy <- as.numeric(xmlValue(n[[1]]))
       }
      n <- getNodeSet(root, '//ccd:el-4016fb70-0ef8-4a26-b6e0-d1c6549efe1a/ccd:el-1667f08f-9fed-461f-bb69-b206a61938e6/DvString-dv', nsDEF)
      if (length(n) > 0)
       {
         DvQuantity_units <- xmlValue(n[[1]])
       }
      data <- data.frame(ccd, data_name, valid_time_begin, valid_time_end,
                         normal_status, magnitude, DvQuantity_units, magnitude_status, error, accuracy, reference_ranges,
                         ev_name, fileName, stringsAsFactors = FALSE)
      
  
  } else
  {
      data <- NA
  }
  
  return(data)
  
}
