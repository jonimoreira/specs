# Process reference ranges
# Return a dataframe for each RR.
#
ReferenceRange <- function(rr) {
  nsDEF <- c(mlhim2='http://www.mlhim.org/ns/mlhim2/')
  rr_definition <- NA
  rr_vtb <- NA
  rr_vte <- NA
  rr_is_normal <- NA
  interval_label <- NA
  interval_lower <- NA
  interval_upper <- NA
  lower_included <- NA
  upper_included <- NA
  lower_bounded <- NA
  upper_bounded <- NA

  n <- XML::getNodeSet(rr, '//definition', nsDEF)
  if (length(n) > 0)
  {
    rr_definition <- XML::xmlValue(n[[1]])
  }

  n <- XML::getNodeSet(rr, '//vtb', nsDEF)
  if (length(n) > 0)
  {
    ds <- XML::xmlValue(n[[1]])
    ds <- gsub('T', ' ', ds)
    rr_vtb <- as.POSIXct(ds)
  }

  n <- XML::getNodeSet(rr, '//vte', nsDEF)
  if (length(n) > 0)
  {
    ds <- XML::xmlValue(n[[1]])
    ds <- gsub('T', ' ', ds)
    rr_vte <- as.POSIXct(ds)
  }

  n <- XML::getNodeSet(rr, '//is-normal', nsDEF)
  if (length(n) > 0)
  {
    rr_is_normal <- XML::xmlValue(n[[1]])
  }

  n <- XML::getNodeSet(rr, '//interval/label', nsDEF)
  if (length(n) > 0)
  {
    interval_label <- XML::xmlValue(n[[1]])
  }

  n <- XML::getNodeSet(rr, '//interval/lower/child::node()', nsDEF)
  if (length(n) > 0)
  {
    interval_lower <- XML::xmlValue(n[[1]])
  }

  n <- XML::getNodeSet(rr, '//interval/upper/child::node()', nsDEF)
  if (length(n) > 0)
  {
    interval_upper <- XML::xmlValue(n[[1]])
  }

  n <- XML::getNodeSet(rr, '//interval/lower-included', nsDEF)
  if (length(n) > 0)
  {
    lower_included <- XML::xmlValue(n[[1]])
  }

  n <- XML::getNodeSet(rr, '//interval/upper-included', nsDEF)
  if (length(n) > 0)
  {
    upper_included <- XML::xmlValue(n[[1]])
  }

  n <- XML::getNodeSet(rr, '//interval/lower-bounded', nsDEF)
  if (length(n) > 0)
  {
    lower_bounded <- XML::xmlValue(n[[1]])
  }

  n <- XML::getNodeSet(rr, '//interval/upper-bounded', nsDEF)
  if (length(n) > 0)
  {
    upper_bounded <- XML::xmlValue(n[[1]])
  }

  data <- data.frame(rr_definition, rr_vtb, rr_vte, rr_is_normal, interval_label, interval_lower, interval_upper, lower_included, upper_included,
                     lower_bounded, upper_bounded, stringsAsFactors = FALSE)
  return(data)
}