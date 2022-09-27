#' Read and prepare pango designation aliases
#' 
#' @param link Link to alias_key.json from the pango_designation repository.
#' @param remove_recombinants Logical, if recombinant aliases should be omitted.
#' @param remove_empty_translations Logical, if original haplotypes (empty translations) should be omitted.
#' @return tibble containing columns pango_short and pango_long which can be used
#' to translate pango lineages.
#' @examples
#' read_alias_key()
#' read_alias_key(remove_recombinants=FALSE)
#' read_alias_key(remove_empty_translations=FALSE)

read_alias_key <- function(link = "https://raw.githubusercontent.com/cov-lineages/pango-designation/master/pango_designation/alias_key.json",
                           remove_recombinants = TRUE,
                           remove_empty_translations = TRUE) {
  
  # read pango lineage abbreviation table directly from the cov-lineages/pango-designation/
  # GitHub repository
  lineage_alias_key <-
    jsonlite::fromJSON(link) %>%
    unlist() %>%
    tibble::as_tibble(rownames = "pango_short") %>%
    dplyr::rename(pango_long = value)
  
  if (remove_recombinants) {
    # remove recombinant lineages
    lineage_alias_key <-
      lineage_alias_key %>%
      dplyr::filter(stringr::str_detect(pango_short, "^X", negate = TRUE))
  }
  
  if (remove_empty_translations) {
    # remove original haplotypes (A and B) where there's no value
    lineage_alias_key <-
      lineage_alias_key %>%
      dplyr::filter(pango_long != "")
  }
  
  return(lineage_alias_key)
  
}
