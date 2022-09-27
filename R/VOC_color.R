#' Get font and background color based on VOC
#' 
#' @param pango_lineage_full Full string of pango lineage without aliases.
#' @return Named vector containing Hex code for font and background_level_base color.
#' @examples
#' VOC_color("B.1.1.529.5.3.1.1.1.1.1.1")
#' VOC_color("B.1.617.2.2")

VOC_color <- function(pango_lineage_full) {
  
  VOC_regex <-
    VOC %>%
    dplyr::mutate(pango_lineage_full_regex = stringr::str_replace_all(pango_lineage_full,
                                                                      pattern = "\\.",
                                                                      replacement = "\\\\."))
  
  color_vector <-
    tibble::tibble(pango_lineage_full = pango_lineage_full) %>%
    fuzzyjoin::fuzzy_inner_join(VOC_regex,
                                by = c("pango_lineage_full" = "pango_lineage_full_regex"),
                                match_fun = stringr::str_detect) %>%
    dplyr::select(color_font, color_background_level_base) %>%
    tidyr::pivot_longer(c(color_font, color_background_level_base),
                        names_to = "color_type",
                        names_pattern = "color_(.*)",
                        values_to = "color") %>%
    tibble::deframe()
  
  if (length(color_vector) == 0) {
    # when no VOC is assigned to given lineage, return grey colors
    color_vector <- c("font" = "#0B0C0E",
                      "background_level_base" = "#777D88")
  }
  
  return(color_vector)
  
}