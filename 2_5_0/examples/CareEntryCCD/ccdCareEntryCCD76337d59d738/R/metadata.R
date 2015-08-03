# Copyright 2013-2015, Timothy W. Cook <tim@mlhim.org>
# metadata.R for ccd-72f3fa87-20b4-4bef-9eed-76337d59d738.xsd
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#' @title getMetadata
#'
#' The Concept Constraint Definition (CCD) Metadata
#' @export
getMetadata <- data.frame(
  dc_title='CareEntry CCD',
  dc_creator='Tim Cook <tim@mlhim.org>',
  dc_contributors='None',
  dc_subject='CareEntry CCD  - Testing Only',
  dc_source='http://www.mlhim.org',
  dc_relation='None',
  dc_coverage='Universal',
  dc_type='MLHIM Concept Constraint Definition (CCD)',
  dc_identifier='ccd-72f3fa87-20b4-4bef-9eed-76337d59d738',
  dc_description='Testing CCD-Gen Implementation of the MLHIM RM functionality.',
  dc_publisher='MLHIM LAB, UERJ',
  dc_date=as.POSIXct(strptime('2015-08-03 19:0328', '%Y-%m-%d %HH:%MM%SS')),
  dc_format='text/xml',
  dc_language='en-us',
  stringsAsFactors=FALSE)
  
ccduri <- function(){
    return('http://www.ccdgen.com/ccdlib/ccd-72f3fa87-20b4-4bef-9eed-76337d59d738.xsd')
}

