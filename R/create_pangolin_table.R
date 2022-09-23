#' Illustrates individual parts of a full pango lineage
#' 
#' @param pango_lineage_full_tibble Tibble containing individual parts of the full pango lineage.
#' @return gt table.
#' @examples
#' pango_lineage_full_tibble <- divide_lineage("B.1.1.529.5.3.1.1.1.1.1.1")
#' create_pango_lineage_table(pango_lineage_full_tibble)
#' 
#' pango_lineage_full_tibble <- divide_lineage("B.1.1.529.5.3.1.1.1.1")
#' create_pango_lineage_table(pango_lineage_full_tibble)
#' 
#' pango_lineage_full_tibble <- divide_lineage("B.1.1.529.5.2.1.1")
#' create_pango_lineage_table(pango_lineage_full_tibble)
#' 
#' pango_lineage_full_tibble <- divide_lineage("B.1.466.2.5.1")
#' create_pango_lineage_table(pango_lineage_full_tibble)
#' 
#' pango_lineage_full_tibble <- divide_lineage("B.1.1")
#' create_pango_lineage_table(pango_lineage_full_tibble)

create_pango_lineage_table <- function(pango_lineage_full_tibble,
                                       color_font="#652624",
                                       color_background_level_base = "#E69000") {
  # How many aliases are there? Defines the colored classes of the final table.
  n_aliases <-
    pango_lineage_full_tibble %>%
    dplyr::filter(pango_short != "no_alias") %>%
    nrow()
  
  if (n_aliases == 0) {
    stop("There is nothing to illustrate.")
  }
  
  # create a named list containing all pango_short values
  # will later be used to replace column labels with empty strings
  cols_label_list <-
    pango_lineage_full_tibble %>%
    dplyr::mutate(cols_label = "") %>%
    dplyr::select(pango_short,
                  cols_label) %>%
    tibble::deframe()
  
  # max factor as defined in gt::adjust_luminance() documentation
  color_step_max <- 2
  
  translation_table <-
    pango_lineage_full_tibble %>%
    tidyr::pivot_wider(names_from = pango_short, values_from = pango_long_relevant) %>%
    gt::gt() %>%
    gt::cols_label(.list = cols_label_list) %>%
    gt::cols_align(align = "center") %>%
    gt::opt_table_lines(extent = "none") %>%
    gt::tab_options(table.font.color = color_font,
                    column_labels.padding = 2,
                    data_row.padding = 2,
                    table.font.size = 18) %>%
    gt::opt_table_font(font = list(gt::google_font(name = "Roboto")))
  
  
  
  for (i in 1:n_aliases) {
    if (n_aliases<2) {
      color_step <- 0
    } else {
      color_step <- (i-1) * color_step_max / (n_aliases-1)
    }
    
    color_background_level_i <- gt::adjust_luminance(color_background_level_base, color_step)
    pango_short <- pango_lineage_full_tibble$pango_short[i]
    pango_short_columns <- pango_lineage_full_tibble$pango_short[1:i]
    
    translation_table <-
      translation_table %>%
      gt::tab_spanner(label = gt::html(paste0("<div style='font-weight:500;background-color:", color_background_level_i, ";'>", pango_short,"</div>")),
                      columns = all_of(pango_short_columns)) %>%
      gt::tab_style(style = list(gt::cell_fill(color = color_background_level_i)),
                    locations = gt::cells_body(columns = all_of(pango_short)))
  }
  
  return(translation_table)
  
}
