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
#' Returns a data.frame of the collected nodes of: \code{Date of most recent contact - Test 2.4.5} from the XML instance passed as fileName.
#' The XML element name is el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200 as a restriction of the mlhim244:DvTemporal
#' The vectors are: ccd, data_name, ev-name, valid_time_begin, valid_time_end, ev_name, fileName,
#' reference_ranges, normal_status
#' One or more of: dvtemporal_date, dvtemporal_time, dvtemporal_datetime, dvtemporal_day, dvtemporal_month, dvtemporal_year, dvtemporal_year_month, dvtemporal_month_day, dvtemporal_duration, dvtemporal_ymduration, dvtemporal_dtduration
#' 
#' Date as required for Clinical Trials Monitoring Service submissions. Exchange format is YYYYMMDD. Display format is DDMMMYYYY, with the month display the first three letters of each month (Jan, Feb, Mar, etc.).
#' 
#' @references
#' The data is structured according to the Multi-Level Healthcare Information Modelling (MLHIM) Reference Model (RM) 2.4.4
#' \url{http://www.mlhim.org}
#' The semantic reference(s) for this data:
#' @references
#' \code{rdf:isDefinedBy} \url{https://cdebrowser.nci.nih.gov/CDEBrowser/search?listValidValuesForDataElements=9&tabClicked=2&PageId=GetDetailsGroup}
#' 
#' @param fileList - The path/file name(s) of the XML file(s) to process.
#' @return A dataframe consisting of the vectors listed in the Description.
#' 
#' @examples
#' files <- dir('./inst/examples', recursive=TRUE, full.names=TRUE, pattern='\\.xml$')
#' DateofmostrecentcontactTest245 <- getDateofmostrecentcontactTest245(files) 
#' 
#' @export
getDateofmostrecentcontactTest245 <- function(fileList)
{
    ldata <- lapply(fileList, parseDateofmostrecentcontactTest245)
    clean <- ldata[!is.na(ldata)]
    data <- do.call(rbind,clean)
    return(data)
}

parseDateofmostrecentcontactTest245 <- function(fileName)
{
  doc <- xmlTreeParse(fileName, handlers=list('comment'=function(x,...){NULL}), asTree = TRUE)
  root <- xmlRoot(doc)
  ccduri <- ccduri() # function in each CCD metadata file
  nsDEF <- nsDEF() # function in each CCD metadata file
  pct <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200', nsDEF)
  # assign common vectors a default
  data_name <- "Invalid data -- Missing data-name."
  ev_name <- NA
  valid_time_begin <- NA
  valid_time_end <- NA
  if (length(pct) > 0)
  {
      ccd <- xmlName(root)
      # test for an ExceptionalValue
      children <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/child::node()', nsDEF)
      if (!is.na(charmatch('mlhim244:',children[[2]]))) # the exceptional value elements are in the RM namespace
      {
        n <- getNodeSet(root, paste('//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/',xmlName(children[[2]]),'/ev-name'), nsDEF)
        ev_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/data-name', nsDEF)
      if (length(n) > 0)
      {
        data_name <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/valid-time-begin', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_begin <- as.POSIXct(ds)
      }
      
      n <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/valid-time-end', nsDEF)
      if (length(n) > 0)
      {
        ds <- xmlValue(n[[1]])
        ds <- gsub('T', ' ', ds)
        valid_time_end <- as.POSIXct(ds)
      }
  
      # PcT defaults
      reference_ranges <- NA
      normal_status <- NA
      dvtemporal_date <- NA
      dvtemporal_time <- NA
      dvtemporal_datetime <- NA
      dvtemporal_day <- NA
      dvtemporal_month <- NA
      dvtemporal_year <- NA
      dvtemporal_year_month <- NA
      dvtemporal_month_day <- NA
      dvtemporal_duration <- NA
      dvtemporal_ymduration <- NA
      dvtemporal_dtduration <- NA
      
      n <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/normal-status', nsDEF)
      if (length(n) > 0)
      {
        normal_status <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/dvtemporal-date', nsDEF)
      if (length(n) > 0)
      {
        dvtemporal_date <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/dvtemporal-time', nsDEF)
      if (length(n) > 0)
      {
        dvtemporal_time <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/dvtemporal-datetime', nsDEF)
      if (length(n) > 0)
      {
        dvtemporal_datetime <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/dvtemporal-day', nsDEF)
      if (length(n) > 0)
      {
        dvtemporal_day <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/dvtemporal-month', nsDEF)
      if (length(n) > 0)
      {
        dvtemporal_month <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/dvtemporal-year', nsDEF)
      if (length(n) > 0)
      {
        dvtemporal_year <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/dvtemporal-year-month', nsDEF)
      if (length(n) > 0)
      {
        dvtemporal_year_month <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/dvtemporal-month-day', nsDEF)
      if (length(n) > 0)
      {
        dvtemporal_month_day <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/dvtemporal-duration', nsDEF)
      if (length(n) > 0)
      {
        dvtemporal_duration <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/dvtemporal-ymduration', nsDEF)
      if (length(n) > 0)
      {
        dvtemporal_ymduration <- xmlValue(n[[1]])
      }
      
      n <- getNodeSet(root, '//ccd:el-7120e227-5cf2-4cbd-ab30-5aa9e64bc200/dvtemporal-dtduration', nsDEF)
      if (length(n) > 0)
      {
        dvtemporal_dtduration <- xmlValue(n[[1]])
      }
      
      data <- data.frame(ccd, data_name, valid_time_begin, valid_time_end,
                         normal_status, reference_ranges, dvtemporal_date, dvtemporal_time, dvtemporal_datetime, dvtemporal_day, dvtemporal_month, dvtemporal_year, dvtemporal_year_month, dvtemporal_month_day, dvtemporal_duration, dvtemporal_ymduration, dvtemporal_dtduration,
                         ev_name, fileName, stringsAsFactors = FALSE)
      
  
  } else
  {
      data <- NA
  }
  
  return(data)
  
}
