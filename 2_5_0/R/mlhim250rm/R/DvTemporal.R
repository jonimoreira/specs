# Copyright 2015, Timothy W. Cook <tim@mlhim.org>
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#'
#' MLHIM 2.5.0 DvTemporal
#'
#'
#' Returns a data.frame of the collected nodes of a DvTemporal restriction from the XML fragment.
#'
#' The vectors are:
#'
#' label - the descriptive name of the fragment.
#'
#' vtb - valid time begin, the datetime that this data became valid
#'
#' vte - valid time end, the datetime this data expired or ceased to be valid
#'
#' ev_name - exceptional value name. When all data is valid according to the restrictions this is NA.
#'           See the MLHIM documentation for explainations of Exceptional Values.
#'
#' reference_ranges -
#'
#' normal_status - Optional normal status indicator of value with respect to normal range for this value.
#'                 Often included by lab, even if the normal range itself is not included.
#'                 Coded by ordinals in series HHH, HH, H, (nothing), L, LL, LLL, etc.
#'
#' ordinal - Value in ordered enumeration of values. The base integer is zero with any number of integer values used to order the symbols.
#'           Example 1: 0 = Trace, 1 = +, 2 = ++, 3 = +++, etc. Example 2: 0 = Mild, 1 = Moderate, 2 = Severe
#'
#' symbol - Coded textual representation of this value in the enumeration, which may be strings made from “+” symbols, or other enumerations of
#'          terms such as “mild”, “moderate”, “severe”, or even the same number series as the values, e.g. “1”, “2”, “3”.
#'
#' @param pcm - the XML fragment to parse.
#' @return A dataframe consisting of the vectors listed in the Description.
#'
#' @examples
#' parseBladderTestingOnly <- function(sourceName){
#'
#' doc <- XML::xmlTreeParse(sourceName, handlers=list('comment'=function(x,...){NULL}), asTree = TRUE)
#' root <- XML::xmlRoot(doc)
#'
#' pcm <- XML::getNodeSet(root, '//mlhim2:pcs-780f834c-f29f-46aa-bb50-3384e9884138', c(mlhim2='http://www.mlhim.org/ns/mlhim2/'))
#'
#' data <- lapply(pcm, mlhim250rm::DvTemporal)
#' data <- data.table::rbindlist(data)
#' data$ccd <- XML::xmlName(root)
#' data$pcs <- 'pcs-780f834c-f29f-46aa-bb50-3384e9884138'
#' data$sourceName <- sourceName
#'
#' return(data)
#' }
#'
#' @export
DvTemporal <- function(pcm) {
  nsDEF <- c(mlhim2='http://www.mlhim.org/ns/mlhim2/')

  # assign common vectors a default
  label <- 'Invalid data -- Missing label.'
  vtb <- NA
  vte <- NA
  if (length(pcm) > 0)
  {
    # test for an ExceptionalValue
    ev_name <- XML::getNodeSet(pcm, '//ev-name', nsDEF)
    if (length(ev_name) > 0) {
      ev_name <- XML::xmlValue(ev_name[[1]])
    } else {
      ev_name <- NA
    }

    n <- XML::getNodeSet(pcm, '//label', nsDEF)

    if (length(n) > 0)
    {
      label <- XML::xmlValue(n[[1]])

    }

    n <- XML::getNodeSet(pcm, '//vtb', nsDEF)
    if (length(n) > 0)
    {
      ds <- XML::xmlValue(n[[1]])
      ds <- gsub('T', ' ', ds)
      vtb <- as.POSIXct(ds)
    }

    n <- XML::getNodeSet(pcm, '//vte', nsDEF)
    if (length(n) > 0)
    {
      ds <- XML::xmlValue(n[[1]])
      ds <- gsub('T', ' ', ds)
      vte <- as.POSIXct(ds)
    }

    # PCMdefaults
    reference_ranges <- NA
    normal_status <- NA
    ordinal <- NA
    symbol <- NA

    n <- XML::getNodeSet(pcm, '//reference_ranges', nsDEF)
    if (length(n) > 0)
    {
      reference_ranges <- XML::xmlValue(n[[1]])
    }

    n <- XML::getNodeSet(pcm, '//normal-status', nsDEF)
    if (length(n) > 0)
    {
      normal_status <- XML::xmlValue(n[[1]])
    }

    n <- XML::getNodeSet(pcm, '//ordinal', nsDEF)
    if (length(n) > 0)
    {
      ordinal <- XML::xmlValue(n[[1]])
    }

    n <- XML::getNodeSet(pcm, '//symbol', nsDEF)
    if (length(n) > 0)
    {
      symbol <- XML::xmlValue(n[[1]])
    }

    data <- data.frame(label, vtb, vte,
                       reference_ranges, normal_status, dvtemporal_date, dvtemporal_time, dvtemporal_datetime, dvtemporal_datetime_stamp,
                       dvtemporal_day, dvtemporal_month, dvtemporal_year, dvtemporal_year_month, dvtemporal_month_day, dvtemporal_duration,
                       dvtemporal_ymduration, dvtemporal_dtduration,
                       ev_name, stringsAsFactors = FALSE)

  } else
  {
    data <- NA
  }

  return(data)

}
