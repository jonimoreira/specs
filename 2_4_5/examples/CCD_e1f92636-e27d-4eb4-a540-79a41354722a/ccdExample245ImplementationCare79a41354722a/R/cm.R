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
#' Returns a data.frame of the collected nodes of: \code{cm} from the XML instance passed as fileName.
#' The XML element name is el-9158aae9-4493-4d25-b3a9-d4608bbc9995 as a restriction of the mlhim245:DvString
#' The vectors are: ccd, data_name, ev-name, valid_time_begin, valid_time_end, ev_name, fileName,
#' DvString_dv, language
#' 
#' cm
#' 
#' @references
#' The data is structured according to the Multi-Level Healthcare Information Modelling (MLHIM) Reference Model (RM) 2.4.5
#' \url{http://www.mlhim.org}
#' The semantic reference(s) for this data:
#' (none provided by the modeller)
#' 
#' @param fileList - The path/file name(s) of the XML file(s) to process.
#' @return A dataframe consisting of the vectors listed in the Description.
#' 
#' @examples
#' files <- dir('./inst/examples', recursive=TRUE, full.names=TRUE, pattern='\\.xml$')
#' cm <- getcm(files) 
#' 
#' @export
getcm <- function(fileList)
{
    ldata <- lapply(fileList, parsecm)
    clean <- ldata[!is.na(ldata)]
    data <- do.call(rbind,clean)
    return(data)
}

parsecm <- function(fileName)
{
  ccduri <- ccduri() # function in each CCD metadata file
  nsDEF <- nsDEF() # function in each CCD metadata file
  doc <- xmlTreeParse(fileName, handlers=list('comment'=function(x,...){NULL}), asTree = TRUE)
  root <- xmlRoot(doc)
  pct <- getNodeSet(root, '//ccd:el-9158aae9-4493-4d25-b3a9-d4608bbc9995', nsDEF)
  # assign common vectors a default
  data_name <- 'Invalid data -- Missing data-name.'
  ev_name <- NA
  valid_time_begin <- NA
  valid_time_end <- NA
  if (length(pct) > 0)
  {
      ccd <- xmlName(root)
      # test for an ExceptionalValue
      children <- getNodeSet(root, '//ccd:el-9158aae9-4493-4d25-b3a9-d4608bbc9995/child::node()', nsDEF)
      if (!is.na(charmatch('mlhim245:',children[[2]]))) # the exceptional value elements are in the RM namespace
      {
        n <- getNodeSet(root, paste('//ccd:el-9158aae9-4493-4d25-b3a9-d4608bbc9995/',xmlName(children[[2]]),'/ev-name'), nsDEF)
        ev_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-9158aae9-4493-4d25-b3a9-d4608bbc9995/data-name', nsDEF)
      if (length(n) > 0)
      {
        data_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-9158aae9-4493-4d25-b3a9-d4608bbc9995/valid-time-begin', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_begin <- as.POSIXct(ds)
      }
      
      n <- getNodeSet(root, '//ccd:el-9158aae9-4493-4d25-b3a9-d4608bbc9995/valid-time-end', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_end <- as.POSIXct(ds)
      }
  
      # PcT defaults
      DvString_dv <- NA
      language <- NA
      
      n <- getNodeSet(root, '//ccd:el-9158aae9-4493-4d25-b3a9-d4608bbc9995/DvString-dv', nsDEF)
      if (length(n) > 0)
      {
        DvString_dv <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-9158aae9-4493-4d25-b3a9-d4608bbc9995/language', nsDEF)
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
