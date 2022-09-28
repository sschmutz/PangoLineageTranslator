test_that("correct tibble is returned", {
  
  pango_lineage_full_1 <- "B.1.1.529.5.3.1.1.1.1.1.1"
  
  tibble_expected_1 <-
    tibble::tribble(
      ~"pango_short", ~"pango_long_relevant",
      "BA", "B.1.1.529",
      "BE", ".5.3.1",
      "BQ", ".1.1.1",
      "no_alias", ".1.1"
    )
    
  expect_equal(divide_lineage(pango_lineage_full_1), tibble_expected_1)
  
  # test for issue #10
  # B.1.1.70 does not wrongly match B.1.1.7
  pango_lineage_full_2 <- "B.1.1.70"
  
  tibble_expected_2 <-
    tibble::tribble(
      ~"pango_short", ~"pango_long_relevant",
      "AP", "B.1.1.70",
    )
  
  expect_equal(divide_lineage(pango_lineage_full_2), tibble_expected_2)
  
})