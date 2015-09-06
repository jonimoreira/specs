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
#' MLHIM 2.5.0 DvLink
#'
#'
#' Returns a data.frame of the collected nodes of a DvLink restriction from the XML fragment.
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
#' link - A required URI. A dereferenceable or not, URL to another CCD or just the ccd-uuid.
#'
#' relation - A required term, normally drawn from a vocabulary or ontology such as the OBO RO.
#'
#' relation_uri - A URI where the definition of the relation element term can be found.
#'                Normally points to an ontology such as the OBO RO http://purl.obolibrary.org/obo/ro.owl
#'
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
#' data <- lapply(pcm, mlhim250rm::DvLink)
#' data <- data.table::rbindlist(data)
#' data$ccd <- XML::xmlName(root)
#' data$pcs <- 'pcs-780f834c-f29f-46aa-bb50-3384e9884138'
#' data$sourceName <- sourceName
#'
#' return(data)
#' }
#'
#' @export
DvLink <- function(pcm) {
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
    link <- NA
    relation <- NA
    relation_uri <- NA

    n <- XML::getNodeSet(pcm, '//link', nsDEF)
    if (length(n) > 0)
    {
      link <- XML::xmlValue(n[[1]])
    }

    n <- XML::getNodeSet(pcm, '//relation', nsDEF)
    if (length(n) > 0)
    {
      relation <- XML::xmlValue(n[[1]])
    }

    n <- XML::getNodeSet(pcm, '//relation-uri', nsDEF)
    if (length(n) > 0)
    {
      relation_uri <- XML::xmlValue(n[[1]])
    }

    data <- data.frame(label, vtb, vte,
                       link, relation, relation_uri,
                       ev_name, stringsAsFactors = FALSE)

  } else
  {
    data <- NA
  }

  return(data)

}
