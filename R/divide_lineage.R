#' Divide full pango lineage into individual parts
#' 
#' @param pango_lineage_full Full sting of pango lineage without aliases.
#' @return Tibble containing individual parts of the full pango lineage.
#' @examples
#' divide_lineage("B.1.1.529.5.3.1.1.1.1.1.1")
#' divide_lineage("B.1.1.529.5.3.1.1.1.1")
#' divide_lineage("B.1.1.529.5.2.1.1")
#' divide_lineage("B.1.466.2.5.1")
#' divide_lineage("B.1.1")

divide_lineage <- function(pango_lineage_full) {
  
  pango_lineage_full_tibble <-
    tibble::tibble(pango_lineage_full = pango_lineage_full) %>%
    fuzzyjoin::fuzzy_left_join(read_alias_key(),
                               by = c("pango_lineage_full" = "pango_long"),
                               match_fun = stringr::str_detect) %>%
    dplyr::bind_rows(tibble::tibble(pango_short = "no_alias", pango_long = pango_lineage_full)) %>%
    # arranging the tibble ensures the order in the table later on
    dplyr::arrange(stringr::str_length(pango_long)) %>%
    # extract the part of the full lineage which defines an abbreviation/alias
    dplyr::mutate(pango_long_relevant = stringr::str_replace(pango_long, dplyr::lag(pango_long), ""),
                  pango_long_relevant = dplyr::coalesce(pango_long_relevant, pango_long)) %>%
    dplyr::select(pango_short,
                  pango_long_relevant) %>%
    # remove row if there is no "remainder" of the full lineage which can't be
    # abbreviated
    dplyr::filter(pango_long_relevant != "")
  
  return(pango_lineage_full_tibble)
  
}
