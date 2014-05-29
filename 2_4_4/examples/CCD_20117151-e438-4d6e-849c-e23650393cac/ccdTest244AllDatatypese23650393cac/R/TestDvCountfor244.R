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
#' Returns a data.frame of the collected nodes of: \code{Test DvCount for 2.4.4} from the XML instance passed as fileName.
#' The XML element name is el-d4ff557f-4064-47c6-b4f0-de7e2cd5bfc7 as a restriction of the mlhim244:DvCount
#' The vectors are: ccd, data_name, ev-name, valid_time_begin, valid_time_end, ev_name, fileName,
#' reference_ranges, normal_status, DvCount_units
#' 
#' Test DvCount for 2.4.4       
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
#' TestDvCountfor244 <- getTestDvCountfor244(files) 
#' 
#' @export
getTestDvCountfor244 <- function(fileList)
{
    ldata <- lapply(fileList, parseTestDvCountfor244)
    clean <- ldata[!is.na(ldata)]
    data <- do.call(rbind,clean)
    return(data)
}

parseTestDvCountfor244 <- function(fileName)
{
  doc <- xmlTreeParse(fileName, handlers=list('comment'=function(x,...){NULL}), asTree = TRUE)
  root <- xmlRoot(doc)
  ccduri <- ccduri() # function in each CCD metadata file
  nsDEF <- nsDEF() # function in each CCD metadata file
  pct <- getNodeSet(root, '//ccd:el-d4ff557f-4064-47c6-b4f0-de7e2cd5bfc7', nsDEF)
  # assign common vectors a default
  data_name <- "Invalid data -- Missing data-name."
  ev_name <- NA
  valid_time_begin <- NA
  valid_time_end <- NA
  if (length(pct) > 0)
  {
      ccd <- xmlName(root)
      # test for an ExceptionalValue
      children <- getNodeSet(root, '//ccd:el-d4ff557f-4064-47c6-b4f0-de7e2cd5bfc7/child::node()', nsDEF)
      if (!is.na(charmatch('mlhim244:',children[[2]]))) # the exceptional value elements are in the RM namespace
      {
        n <- getNodeSet(root, paste('//ccd:el-d4ff557f-4064-47c6-b4f0-de7e2cd5bfc7/',xmlName(children[[2]]),'/ev-name'), nsDEF)
        ev_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-d4ff557f-4064-47c6-b4f0-de7e2cd5bfc7/data-name', nsDEF)
      if (length(n) > 0)
      {
        data_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-d4ff557f-4064-47c6-b4f0-de7e2cd5bfc7/valid-time-begin', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_begin <- as.POSIXct(ds)
      }
      
      n <- getNodeSet(root, '//ccd:el-d4ff557f-4064-47c6-b4f0-de7e2cd5bfc7/valid-time-end', nsDEF)
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
      DvCount_units <- 'Invalid data -- Missing units.'
      
      n <- getNodeSet(root, '//ccd:el-d4ff557f-4064-47c6-b4f0-de7e2cd5bfc7/normal-status', nsDEF)
      if (length(n) > 0)
      {
        normal_status <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-d4ff557f-4064-47c6-b4f0-de7e2cd5bfc7/magnitude', nsDEF)
      if (length(n) > 0)
       {
         magnitude <- as.numeric(xmlValue(n[[1]]))
       }
       n <- getNodeSet(root, '//ccd:el-d4ff557f-4064-47c6-b4f0-de7e2cd5bfc7/mlhim244:magnitude-status', nsDEF)
       if (length(n) > 0)
        {
         magnitude_status <- xmlValue(n[[1]])
        }
      n <- getNodeSet(root, '//ccd:el-d4ff557f-4064-47c6-b4f0-de7e2cd5bfc7/error', nsDEF)
      if (length(n) > 0)
       {
         error <- as.numeric(xmlValue(n[[1]]))
       }
      n <- getNodeSet(root, '//ccd:el-d4ff557f-4064-47c6-b4f0-de7e2cd5bfc7/accuracy', nsDEF)
      if (length(n) > 0)
       {
         accuracy <- as.numeric(xmlValue(n[[1]]))
       }
      n <- getNodeSet(root, '//ccd:el-d4ff557f-4064-47c6-b4f0-de7e2cd5bfc7/ccd:el-d6ce7add-82bb-4051-a503-ea61ed3589aa/DvString-dv', nsDEF)
      if (length(n) > 0)
       {
         DvCount_units <- xmlValue(n[[1]])
       }
      data <- data.frame(ccd, data_name, valid_time_begin, valid_time_end,
                         normal_status, magnitude, DvCount_units, magnitude_status, error, accuracy, reference_ranges,
                         ev_name, fileName, stringsAsFactors = FALSE)
      
  
  } else
  {
      data <- NA
  }
  
  return(data)
  
}
