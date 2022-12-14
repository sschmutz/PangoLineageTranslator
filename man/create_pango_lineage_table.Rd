% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_pangolin_table.R
\name{create_pango_lineage_table}
\alias{create_pango_lineage_table}
\title{Illustrates individual parts of a full pango lineage}
\usage{
create_pango_lineage_table(pango_lineage_full_tibble, color_vector)
}
\arguments{
\item{pango_lineage_full_tibble}{Tibble containing individual parts of the full pango lineage.}

\item{color_vector}{Named vector containing Hex codes for "font" and "background_level_base" color.}
}
\value{
gt table.
}
\description{
Illustrates individual parts of a full pango lineage
}
\examples{
pango_lineage_full_tibble <- divide_lineage("B.1.1.529.5.3.1.1.1.1.1.1")
color_vector <- VOC_color("B.1.1.529.5.3.1.1.1.1.1.1")
create_pango_lineage_table(pango_lineage_full_tibble, color_vector)

pango_lineage_full_tibble <- divide_lineage("B.1.617.2.2")
color_vector <- VOC_color("B.1.617.2.2")
create_pango_lineage_table(pango_lineage_full_tibble, color_vector)
}
