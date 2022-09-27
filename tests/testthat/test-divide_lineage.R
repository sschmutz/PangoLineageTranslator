test_that("correct tibble is returned", {
  
  pango_lineage_full <- "B.1.1.529.5.3.1.1.1.1.1.1"
  
  tibble_expected <-
    tibble::tribble(
      ~"pango_short", ~"pango_long_relevant",
      "BA", "B.1.1.529",
      "BE", ".5.3.1",
      "BQ", ".1.1.1",
      "no_alias", ".1.1"
    )
    
  expect_equal(divide_lineage(pango_lineage_full), tibble_expected)
  
})