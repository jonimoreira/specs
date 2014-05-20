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
#' Returns a data.frame of the collected nodes of: \code{Test DvQuantity for 2.4.4} from the XML instance passed as fileName.
#' The XML element name is el-0fd33260-ea64-4d18-9c92-f28f83474a98 as a restriction of the mlhim244:DvQuantity
#' The vectors are: ccd, data_name, ev-name, valid_time_begin, valid_time_end, ev_name, fileName,
#' reference_ranges, normal_status, magnitude, magnitude_status, error, accuracy, DvQuantity_units
#' 
#' Test DvQuantity for 2.4.4
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
#' TestDvQuantityfor244 <- getTestDvQuantityfor244(files) 
#' 
#' @export
getTestDvQuantityfor244 <- function(fileList)
{
    ldata <- lapply(fileList, parseTestDvQuantityfor244)
    clean <- ldata[!is.na(ldata)]
    data <- do.call(rbind,clean)
    return(data)
}

parseTestDvQuantityfor244 <- function(fileName)
{
  doc <- xmlTreeParse(fileName, handlers=list('comment'=function(x,...){NULL}), asTree = TRUE)
  root <- xmlRoot(doc)
  ccduri <- ccduri() # function in each CCD metadata file
  nsDEF <- nsDEF() # function in each CCD metadata file
  pct <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98', nsDEF)
  # assign common vectors a default
  data_name <- "Invalid data -- Missing data-name."
  ev_name <- NA
  valid_time_begin <- NA
  valid_time_end <- NA
  if (length(pct) > 0)
  {
      ccd <- xmlName(root)
      # test for an ExceptionalValue
      children <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/child::node()', nsDEF)
      if (!is.na(charmatch('mlhim244:',children[[2]]))) # the exceptional value elements are in the RM namespace
      {
        n <- getNodeSet(root, paste('//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/',xmlName(children[[2]]),'/ev-name'), nsDEF)
        ev_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/data-name', nsDEF)
      if (length(n) > 0)
      {
        data_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/valid-time-begin', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_begin <- as.POSIXct(ds)
      }
      
      n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/valid-time-end', nsDEF)
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
      
      
      n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/ccd:el-15cbc674-659a-4f6d-9362-fb3eebb8842c', nsDEF)
      if (length(n) > 0)
      {
        is_normal <- FALSE
        referencerange_definition <- 'Invalid data -- Missing definition.'
        interval_type <- 'Invalid data -- Missing Interval type.'
        upper <- NA
        lower <- NA
        upper_included <- TRUE
        lower_included <- TRUE
        n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/ccd:el-15cbc674-659a-4f6d-9362-fb3eebb8842c/referencerange-definition', nsDEF)
        if (length(n) > 0)
        {
          referencerange_definition <- xmlValue(n[[1]])
        }
        
        n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/ccd:el-15cbc674-659a-4f6d-9362-fb3eebb8842c/is-normal', nsDEF)
        if (length(n) > 0)
        {
          is_normal <- (xmlValue(n[[1]]) == 'true') #default is FALSE
        }
        
        n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/ccd:el-15cbc674-659a-4f6d-9362-fb3eebb8842c/ccd:el-8cd8265e-f6b0-4c7e-9cf7-3fcf84782160/lower', nsDEF)
        if (length(n) > 0)
        {
          lower <- xmlValue(n[[1]])
        }
        n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/ccd:el-15cbc674-659a-4f6d-9362-fb3eebb8842c/ccd:el-8cd8265e-f6b0-4c7e-9cf7-3fcf84782160/upper', nsDEF)
        if (length(n) > 0)
        {
          upper <- xmlValue(n[[1]])
        }
        
        n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/ccd:el-15cbc674-659a-4f6d-9362-fb3eebb8842c/ccd:el-8cd8265e-f6b0-4c7e-9cf7-3fcf84782160/mlhim244:interval-type', nsDEF)
        if (length(n) > 0)
        {
          interval_type <- xmlValue(n[[1]])
        }
        
        if (!is.na(charmatch('int',interval_type)))
        {
          lower <- as.numeric(lower)
          upper <- as.numeric(upper)
        }
        
        if (!is.na(charmatch('decimal',interval_type)))
        {
          lower <- as.numeric(lower)
          upper <- as.numeric(upper)
        }
        
        if (!is.na(charmatch('dateTime',interval_type)))
        {
          lower <- as.POSIXct(gsub('T', ' ',lower))
          upper <- as.POSIXct(gsub('T', ' ',upper))
        }
        
        if (!is.na(charmatch('date',interval_type)))
        {
          lower <- as.Date(lower, '%Y-%m-%d')
          upper <- as.Date(upper, '%Y-%m-%d')
        }
        
        if (!is.na(charmatch('time',interval_type)))
        {
          lower <- lower
          upper <- upper
        }
        
        if (!is.na(charmatch('duration',interval_type)))
        {
          lower <- lower
          upper <- upper
        }
        
        n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/ccd:el-15cbc674-659a-4f6d-9362-fb3eebb8842c/ccd:el-8cd8265e-f6b0-4c7e-9cf7-3fcf84782160/lower-included', nsDEF)
        if (length(n) > 0)
        {
          lower_included <- (xmlValue(n[[1]]) == 'true') #default is TRUE
        }
        n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/ccd:el-15cbc674-659a-4f6d-9362-fb3eebb8842c/ccd:el-8cd8265e-f6b0-4c7e-9cf7-3fcf84782160/upper-included', nsDEF)
        if (length(n) > 0)
        {
          upper_included <- (xmlValue(n[[1]]) == 'true') #default is TRUE
        }
         
        
        rr0 <- data.frame(referencerange_definition, is_normal, interval_type, lower, lower_included, upper, upper_included, stringsAsFactors = FALSE)
      }
      
      reference_ranges <- c(rr0)
      
      n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/normal-status', nsDEF)
      if (length(n) > 0)
      {
        normal_status <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/magnitude', nsDEF)
      if (length(n) > 0)
       {
         magnitude <- as.numeric(xmlValue(n[[1]]))
       }
       n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/mlhim244:magnitude-status', nsDEF)
       if (length(n) > 0)
        {
         magnitude_status <- xmlValue(n[[1]])
        }
      n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/error', nsDEF)
      if (length(n) > 0)
       {
         error <- as.numeric(xmlValue(n[[1]]))
       }
      n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/accuracy', nsDEF)
      if (length(n) > 0)
       {
         accuracy <- as.numeric(xmlValue(n[[1]]))
       }
      n <- getNodeSet(root, '//ccd:el-0fd33260-ea64-4d18-9c92-f28f83474a98/ccd:el-d6ce7add-82bb-4051-a503-ea61ed3589aa/DvString-dv', nsDEF)
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
