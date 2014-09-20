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
#' Returns a data.frame of the collected nodes of: \code{Test Ratio 2.4.5} from the XML instance passed as fileName.
#' The XML element name is el-bab10fad-edd7-49e4-ad76-a83314314b0b as a restriction of the mlhim244:DvRatio
#' The vectors are: ccd, data_name, ev-name, valid_time_begin, valid_time_end, ev_name, fileName,
#' reference_ranges, normal_status, magnitude, magnitude_status, error, accuracy, ratio_type, numerator, denominator, numerator_units, denominator_units, ratio_units
#' 
#' A DvRatio for testing.
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
#' TestRatio245 <- getTestRatio245(files) 
#' 
#' @export
getTestRatio245 <- function(fileList)
{
    ldata <- lapply(fileList, parseTestRatio245)
    clean <- ldata[!is.na(ldata)]
    data <- do.call(rbind,clean)
    return(data)
}

parseTestRatio245 <- function(fileName)
{
  doc <- xmlTreeParse(fileName, handlers=list('comment'=function(x,...){NULL}), asTree = TRUE)
  root <- xmlRoot(doc)
  ccduri <- ccduri() # function in each CCD metadata file
  nsDEF <- nsDEF() # function in each CCD metadata file
  pct <- getNodeSet(root, '//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b', nsDEF)
  # assign common vectors a default
  data_name <- "Invalid data -- Missing data-name."
  ev_name <- NA
  valid_time_begin <- NA
  valid_time_end <- NA
  if (length(pct) > 0)
  {
      ccd <- xmlName(root)
      # test for an ExceptionalValue
      children <- getNodeSet(root, '//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b/child::node()', nsDEF)
      if (!is.na(charmatch('mlhim244:',children[[2]]))) # the exceptional value elements are in the RM namespace
      {
        n <- getNodeSet(root, paste('//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b/',xmlName(children[[2]]),'/ev-name'), nsDEF)
        ev_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b/data-name', nsDEF)
      if (length(n) > 0)
      {
        data_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b/valid-time-begin', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_begin <- as.POSIXct(ds)
      }
      
      n <- getNodeSet(root, '//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b/valid-time-end', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_end <- as.POSIXct(ds)
      }
  
      # PcT defaults
      reference_ranges <- NA
      normal_status <- NA
      ratio_type <- NA
      magnitude <- NA
      numerator <- NA
      denominator <- NA
      magnitude_status <- NA
      error <- NA
      accuracy <- NA
      ratio_units <- NA
      numerator_units <- NA
      denominator_units <- NA
      
      n <- getNodeSet(root, '//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b/normal-status', nsDEF)
      if (length(n) > 0)
      {
        normal_status <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b/numerator', nsDEF)
      if (length(n) > 0)
       {
         numerator <- as.numeric(xmlValue(n[[1]]))
       }
      n <- getNodeSet(root, '//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b/denominator', nsDEF)
      if (length(n) > 0)
       {
         denominator <- as.numeric(xmlValue(n[[1]]))
       }
      n <- getNodeSet(root, '//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b/magnitude', nsDEF)
      if (length(n) > 0)
       {
         magnitude <- as.numeric(xmlValue(n[[1]]))
       }
       n <- getNodeSet(root, '//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b/mlhim244:ratio-type', nsDEF)
       if (length(n) > 0)
        {
         ratio_type <- xmlValue(n[[1]])
        }
       n <- getNodeSet(root, '//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b/mlhim244:magnitude-status', nsDEF)
       if (length(n) > 0)
        {
         magnitude_status <- xmlValue(n[[1]])
        }
      n <- getNodeSet(root, '//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b/error', nsDEF)
      if (length(n) > 0)
       {
         error <- as.numeric(xmlValue(n[[1]]))
       }
      n <- getNodeSet(root, '//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b/accuracy', nsDEF)
      if (length(n) > 0)
       {
         accuracy <- as.numeric(xmlValue(n[[1]]))
       }
      n <- getNodeSet(root, '//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b/ccd:el-70d4b917-9f7c-4ffb-bfcf-a603c4938c10/DvString-dv', nsDEF)
      if (length(n) > 0)
       {
         numerator_units <- xmlValue(n[[1]])
       }
      n <- getNodeSet(root, '//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b/ccd:el-fef4ff7b-148f-4318-bf22-2b715a2ac20b/DvString-dv', nsDEF)
      if (length(n) > 0)
       {
         denominator_units <- xmlValue(n[[1]])
       }
      n <- getNodeSet(root, '//ccd:el-bab10fad-edd7-49e4-ad76-a83314314b0b/ccd:el-none/DvString-dv', nsDEF)
      if (length(n) > 0)
       {
         ratio_units <- xmlValue(n[[1]])
       }
      data <- data.frame(ccd, data_name, valid_time_begin, valid_time_end,
                         normal_status, numerator, numerator_units, denominator, denominator_units, ratio_type, magnitude, ratio_units, magnitude_status, error, accuracy, reference_ranges,
                         ev_name, fileName, stringsAsFactors = FALSE)
      
  
  } else
  {
      data <- NA
  }
  
  return(data)
  
}
