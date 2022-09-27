#' Data of SARS-CoV-2 Variants of concern (VOC)
#' 
#' The WHO assignes a letter of the Greek Alphabet which are easy-to-pronounce and non-stigmatising labels.
#' This data also already includes Hex color codes for the font and background of the illustration.
#' 
#' @format A tibble with 5 rows and 4 variables:
#' \describe{
#'   \item{who_label}{chr letter of the Greek Alphabet assigned by the WHO}
#'   \item{pango_lineage}{chr Pango lineage}
#'   \item{pango_lineage_full}{chr Full Pango lineage (without abbreviation)}
#'   \item{color_font}{chr Hex color code used for the font}
#'   \item{color_background_level_base}{chr Hex color code used for the background}
#' }
#' @source \url{https://www.who.int/activities/tracking-SARS-CoV-2-variants}
"VOC"