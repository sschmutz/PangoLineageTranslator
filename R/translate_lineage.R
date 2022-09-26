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
  
  lineage_cleaned <-
    lineage %>%
    # remove any non-word character and non-dots from lineage which are possible
    # copy-paste errors
    stringr::str_replace_all(pattern = "[^\\w\\.]",
                             replacement = "")

  pango_lineage <-
    tibble::tibble(pango_lineage = lineage_cleaned) %>%
    tidyr::separate(pango_lineage, into = c("pango_short", "pango_rest"), sep = "\\.", extra = "merge") %>%
    dplyr::mutate(pango_short = stringr::str_to_upper(pango_short))
  
  pango_lineage_full <-
    read_alias_key() %>%
    dplyr::inner_join(pango_lineage, by = "pango_short") %>%
    tidyr::unite("pango_lineage_full", c(pango_long, pango_rest), sep = ".") %>%
    dplyr::pull(pango_lineage_full)
  
  if (length(pango_lineage_full) == 0) {
    # in case the given lineage can not be expanded/translated, it is assumed
    # that it's already the full lineage
    message("There is nothing to translate.")
    pango_lineage_full <- lineage_cleaned
  }
  
  return(pango_lineage_full)
  
}
