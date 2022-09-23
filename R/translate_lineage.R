#' Translate abbreviated pango lineage
#' 
#' @param lineage Abbreviated pango lineage.
#' @return Full sting of pango lineage without aliases.
#' @examples
#' translate_lineage("BQ.1.1")
#' translate_lineage("BE.1.1.1")
#' translate_lineage("BF.1")
#' translate_lineage("AU.5.1")
#' translate_lineage("B.1.1")

translate_lineage <- function(lineage) {
  # read pango lineage abbreviation table directly from the cov-lineages/pango-designation/
  # GitHub repository
  lineage_alias_key <-
    jsonlite::fromJSON("https://raw.githubusercontent.com/cov-lineages/pango-designation/master/pango_designation/alias_key.json") %>%
    unlist() %>%
    tibble::as_tibble(rownames = "pango_short") %>%
    dplyr::rename(pango_long = value) %>%
    # remove recombinant lineages
    dplyr::filter(stringr::str_detect(pango_short, "^X", negate = TRUE)) %>%
    dplyr::filter(pango_long != "")
  
  pango_lineage <-
    tibble::tibble(pango_lineage = lineage) %>%
    tidyr::separate(pango_lineage, into = c("pango_short", "pango_rest"), sep = "\\.", extra = "merge")
  
  pango_lineage_full <-
    lineage_alias_key %>%
    dplyr::inner_join(pango_lineage, by = "pango_short") %>%
    tidyr::unite("pango_lineage_full", c(pango_long, pango_rest), sep = ".") %>%
    dplyr::pull(pango_lineage_full)
  
  if (length(pango_lineage_full) == 0) {
    message("There is nothing to translate.")
  }
  
  return(pango_lineage_full)
  
}
