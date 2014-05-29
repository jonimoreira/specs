# Copyright 2014, Timothy W. Cook <tim@mlhim.org>
# metadata.R for ccd-20117151-e438-4d6e-849c-e23650393cac.xsd
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
  dc_title='Test 2.4.4 All Datatypes',
  dc_creator='Tim Cook <tim@mlhim.org>',
  dc_contributors='None',
  dc_subject='Test 2.4.4 All Datatypes',
  dc_source='http://www.mlhim.org',
  dc_relation='None',
  dc_coverage='Universal',
  dc_type='MLHIM Concept Constraint Definition (CCD)',
  dc_identifier='ccd-20117151-e438-4d6e-849c-e23650393cac',
  dc_description='Test 2.4.4 All Datatypes',
  dc_publisher='MLHIM LAB, UERJ',
  dc_date=as.POSIXct(strptime('2014-05-20 15:5454', '%Y-%m-%d %HH:%MM%SS')),
  dc_format='text/xml',
  dc_language='en-us',
  stringsAsFactors=FALSE)
  
nsDEF <- function(){
  return(c(ccd='http://www.mlhim.org/ccd',mlhim244='http://www.mlhim.org/xmlns/mlhim2/2_4_4'))  
} 

ccduri <- function(){
    return('http://www.ccdgen.com/ccdlib/ccd-20117151-e438-4d6e-849c-e23650393cac.xsd')
}

