
<!-- README.md is generated from README.Rmd. Please edit that file -->

# *Pango* Lineage Translator <a href='https://sschmutz.shinyapps.io/PangoLineageTranslator/'><img src='man/figures/README-app-screenshot-1.png' align="right" height="200px" /></a>

<br> <br> <br>

## Background

The [*Pango* Lineage Translator
App](https://sschmutz.shinyapps.io/PangoLineageTranslator/) was inspired
by a series of similar tweets making fun of the growing length of the
full SARS-CoV-2 Pango Lineage names. For example:

<div>

<a href='https://twitter.com/theosanderson/status/1572537385250070529?t=2-MfB36IsUaZ-HVsIEH5pg&s=03'>
<img src="man/figures/README-tweet-1.png" width="500px"> </a>

</div>

<br>

These two names do indeed describe the same Pango Lineage and are
synonyms only that the short form uses [defined
aliases](https://github.com/cov-lineages/pango-designation/blob/master/pango_designation/alias_key.json)
to abbreviate the long form.

With the evolution of SARS-CoV-2, a structured solution to designate and
name new lineages was required.  
The idea and implementation of naming lineages using the Pango
nomenclature system are well described on the [Pango Network
website](https://www.pango.network/the-pango-nomenclature-system/statement-of-nomenclature-rules/).  
The side effect of such a nomenclature system is that:  
- from the abbreviated names, it is not easy to track its ancestry,
and  
- the non-abbreviated names get pretty long.

Here is where this App tries to bring everything together and
interactively illustrate the ancestry of abbreviated Pango Lineage names
by highlighting all the aliases of the full name.

## How it works

The first step is to translate and remove all aliases of a given lineage
name to get the full name.

``` r
(pango_lineage_full <- translate_lineage("BQ.1.1"))
#> [1] "B.1.1.529.5.3.1.1.1.1.1.1"
```

Next, aliases are assigned again to the relevant parts of the full
lineage name. There might be a remainder that can not be further
abbreviated at the end.

``` r
(pango_lineage_full_tibble <- divide_lineage(pango_lineage_full))
#> # A tibble: 4 × 2
#>   pango_short pango_long_relevant
#>   <chr>       <chr>              
#> 1 BA          B.1.1.529          
#> 2 BE          .5.3.1             
#> 3 BQ          .1.1.1             
#> 4 no_alias    .1.1
```

Different color schemes are used to highlight the different variants of
concern [defined by the
WHO](https://www.who.int/activities/tracking-SARS-CoV-2-variants), such
as
<a style='font-weight:500;background-color:#E69000;color:#3A0301;padding: 5px 5px 5px 5px;'>Omicron</a>.

``` r
(color_vector <- VOC_color(pango_lineage_full))
#>                  font background_level_base 
#>             "#3A0301"             "#E69000"
```

Lastly, a [gt table](https://gt.rstudio.com/) is put together with
nested [spanner column
labels](https://gt.rstudio.com/reference/tab_spanner.html) for each
alias.

``` r
create_pango_lineage_table(pango_lineage_full_tibble, color_vector)
```

<div align="left">

<img src="man/figures/README-table-example-1.png" width="200px">

</div>
