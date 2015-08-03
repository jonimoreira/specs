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
#' \code{Fever duration: 3 weeks or less  - Testing Only.}
#'
#' Returns a data.frame of the collected nodes of: \code{Fever duration: 3 weeks or less  - Testing Only} from the XML instance passed as fileName.
#' The source name and the CCD ID are also included in each row to assist in identifying the source of the data.
#' The XML element name is pcs-6f6bb8d8-2f5f-4e97-bdd5-ef9a2eb24ba6 as a restriction of the DvBoolean
#' The vectors are: label, vtb, vte, #' true_value, false_value, #' ccd, sourceName,
#' 
#' Yes/No field for the duration of the fever. It should be filled when the date of onset of the fever is not known.
#' 
#' @references
#' The data is structured according to the Multi-Level Healthcare Information Modelling Reference Model release 2.5.0
#' \url{http://www.mlhim.org}
#' The semantic reference(s) for this data:
#' @references
#' \code{rdfs:isDefinedBy} \url{http://bvsms.saude.gov.br/bvs/periodicos/boletim_eletronico_epi_ano04_n04.pdf} and can be accessed via the CCD. A CCD is an XML Schema with embeded RDF.
#' 
#' @param fileList - The path/file name(s) of the XML file(s) to process.
#' @return A dataframe consisting of the vectors listed in the Description.
#' 
#' The examples use the included files. Any source that can be processed via the XML::xmlTreeParse function can be used.
#' @examples
#' files <- dir('./inst/examples', recursive=TRUE, full.names=TRUE, pattern='\\.xml$')
#' Feverduration3weeksorlessTestingOnly <- getFeverduration3weeksorlessTestingOnly(files) 
#' 
#' @export
getFeverduration3weeksorlessTestingOnly <- function(sourceList)
{
    data <- lapply(sourceList, parseFeverduration3weeksorlessTestingOnly)
    data <- data.table::rbindlist(data, fill=TRUE)
    return(data)
}

#' @export
parseFeverduration3weeksorlessTestingOnly <- function(sourceName) {
  nsDEF <- c(mlhim2='http://www.mlhim.org/ns/mlhim2/', xsi='http://www.w3.org/2001/XMLSchema-instance')
  doc <- XML::xmlTreeParse(sourceName, handlers=list('comment'=function(x,...){NULL}), asTree = TRUE)
  root <- XML::xmlRoot(doc)
  pcm <- XML::getNodeSet(root, '//mlhim2:pcs-6f6bb8d8-2f5f-4e97-bdd5-ef9a2eb24ba6', nsDEF)
  data <- lapply(pcm, mlhim250rm::DvBoolean)
  data <- data.table::rbindlist(data, fill=TRUE)
  if (length(data) > 0) { 
      data$ccd <- XML::xmlName(root)
      data$pcs <- 'pcs-6f6bb8d8-2f5f-4e97-bdd5-ef9a2eb24ba6'
      data$ccd <- XML::xmlName(root)
      data$sourceName <- sourceName
 } else {
    data <- data.frame()
  }
 return(data)
}
