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
#' Returns a data.frame of the collected nodes of: \code{Participation Mode - Test 2.4.5} from the XML instance passed as fileName.
#' The XML element name is el-fa1a3488-43d7-4e2f-8807-a3f9ddeeccee as a restriction of the mlhim244:DvCodedString
#' The vectors are: ccd, data_name, ev-name, valid_time_begin, valid_time_end, ev_name, fileName,
#' DvString_dv, language, terminology_abbrev, terminology_name, terminology_version, terminology_code
#' 
#' A generic definition that the participation mode is some type of agent. 
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
#' ParticipationModeTest245 <- getParticipationModeTest245(files) 
#' 
#' @export
getParticipationModeTest245 <- function(fileList)
{
    ldata <- lapply(fileList, parseParticipationModeTest245)
    clean <- ldata[!is.na(ldata)]
    data <- do.call(rbind,clean)
    return(data)
}

parseParticipationModeTest245 <- function(fileName)
{
  doc <- xmlTreeParse(fileName, handlers=list('comment'=function(x,...){NULL}), asTree = TRUE)
  root <- xmlRoot(doc)
  ccduri <- ccduri() # function in each CCD metadata file
  nsDEF <- nsDEF() # function in each CCD metadata file
  pct <- getNodeSet(root, '//ccd:el-fa1a3488-43d7-4e2f-8807-a3f9ddeeccee', nsDEF)
  # assign common vectors a default
  data_name <- "Invalid data -- Missing data-name."
  ev_name <- NA
  valid_time_begin <- NA
  valid_time_end <- NA
  if (length(pct) > 0)
  {
      ccd <- xmlName(root)
      # test for an ExceptionalValue
      children <- getNodeSet(root, '//ccd:el-fa1a3488-43d7-4e2f-8807-a3f9ddeeccee/child::node()', nsDEF)
      if (!is.na(charmatch('mlhim244:',children[[2]]))) # the exceptional value elements are in the RM namespace
      {
        n <- getNodeSet(root, paste('//ccd:el-fa1a3488-43d7-4e2f-8807-a3f9ddeeccee/',xmlName(children[[2]]),'/ev-name'), nsDEF)
        ev_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-fa1a3488-43d7-4e2f-8807-a3f9ddeeccee/data-name', nsDEF)
      if (length(n) > 0)
      {
        data_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-fa1a3488-43d7-4e2f-8807-a3f9ddeeccee/valid-time-begin', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_begin <- as.POSIXct(ds)
      }
      
      n <- getNodeSet(root, '//ccd:el-fa1a3488-43d7-4e2f-8807-a3f9ddeeccee/valid-time-end', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_end <- as.POSIXct(ds)
      }
  
      # PcT defaults
      DvString_dv <- NA
      language <- NA
      terminology_abbrev <- NA
      terminology_name <- NA
      terminology_version <- NA
      terminology_code <- 'Invalid Data - Missing code.'
      
      n <- getNodeSet(root, '//ccd:el-fa1a3488-43d7-4e2f-8807-a3f9ddeeccee/DvString-dv', nsDEF)
      if (length(n) > 0)
      {
        DvString_dv <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-fa1a3488-43d7-4e2f-8807-a3f9ddeeccee/language', nsDEF)
      if (length(n) > 0)
      {
        language <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-fa1a3488-43d7-4e2f-8807-a3f9ddeeccee/terminology-abbrev', nsDEF)
      if (length(n) > 0)
      {
        terminology_abbrev <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-fa1a3488-43d7-4e2f-8807-a3f9ddeeccee/terminology-name', nsDEF)
      if (length(n) > 0)
      {
        terminology_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-fa1a3488-43d7-4e2f-8807-a3f9ddeeccee/terminology-version', nsDEF)
      if (length(n) > 0)
      {
        terminology_version <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-fa1a3488-43d7-4e2f-8807-a3f9ddeeccee/terminology-code', nsDEF)
      if (length(n) > 0)
      {
        terminology_code <- xmlValue(n[[1]])
      }
      
      data <- data.frame(ccd, data_name, valid_time_begin, valid_time_end,
                         DvString_dv,language,terminology_code,terminology_abbrev,terminology_name,terminology_version,
                         ev_name, fileName, stringsAsFactors = FALSE)
      
  
  } else
  {
      data <- NA
  }
  
  return(data)
  
}
