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
#' \code{Connected To  - Testing Only.}
#'
#' Returns a data.frame of the collected nodes of: \code{Connected To  - Testing Only} from the XML instance passed as fileName.
#' The source name and the CCD ID are also included in each row to assist in identifying the source of the data.
#' The XML element name is pcs-a4b92ef6-1b6a-40e9-b92c-6bd7ef24c39a as a restriction of the DvLink
#' The vectors are: label, vtb, vte, #' link, relation, relation_uri, #' ccd, sourceName,
#' 
#'  X connected_to Y if and only if X and Y share a fiat boundary.
#' 
#' @references
#' The data is structured according to the Multi-Level Healthcare Information Modelling Reference Model release 2.5.0
#' \url{http://www.mlhim.org}
#' The semantic reference(s) for this data:
#' @references
#' 
#' @param fileList - The path/file name(s) of the XML file(s) to process.
#' @return A dataframe consisting of the vectors listed in the Description.
#' 
#' The examples use the included files. Any source that can be processed via the XML::xmlTreeParse function can be used.
#' @examples
#' files <- dir('./inst/examples', recursive=TRUE, full.names=TRUE, pattern='\\.xml$')
#' ConnectedToTestingOnly <- getConnectedToTestingOnly(files) 
#' 
#' @export
getConnectedToTestingOnly <- function(sourceList)
{
    data <- lapply(sourceList, parseConnectedToTestingOnly)
    data <- data.table::rbindlist(data, fill=TRUE)
    return(data)
}

#' @export
parseConnectedToTestingOnly <- function(sourceName) {
  nsDEF <- c(mlhim2='http://www.mlhim.org/ns/mlhim2/', xsi='http://www.w3.org/2001/XMLSchema-instance')
  doc <- XML::xmlTreeParse(sourceName, handlers=list('comment'=function(x,...){NULL}), asTree = TRUE)
  root <- XML::xmlRoot(doc)
  pcm <- XML::getNodeSet(root, '//mlhim2:pcs-a4b92ef6-1b6a-40e9-b92c-6bd7ef24c39a', nsDEF)
  data <- lapply(pcm, mlhim250rm::DvLink)
  data <- data.table::rbindlist(data, fill=TRUE)
  if (length(data) > 0) { 
      data$ccd <- XML::xmlName(root)
      data$pcs <- 'pcs-a4b92ef6-1b6a-40e9-b92c-6bd7ef24c39a'
      data$ccd <- XML::xmlName(root)
      data$sourceName <- sourceName
 } else {
    data <- data.frame()
  }
 return(data)
}
