test_that("correct full pango lineage is returned", {
  
  expect_equal(translate_lineage("BQ.1.1"),
               "B.1.1.529.5.3.1.1.1.1.1.1")
  
  expect_equal(translate_lineage("AY.2"),
               "B.1.617.2.2")
  
  expect_equal(translate_lineage("AA.5"),
               "B.1.177.15.5")
  
  expect_equal(translate_lineage("P.1"),
               "B.1.1.28.1")
  
})

test_that("any non-word character and non-dots are removed from lineage", {
  
  expect_equal(translate_lineage("BA.5  "),
               "B.1.1.529.5")
  
  expect_equal(translate_lineage("BA.5*"),
               "B.1.1.529.5")
  
})

test_that("input is returned with message if there's nothing to translate", {
  
  expect_message(
    expect_equal(translate_lineage("B.1.1"),
                 "B.1.1")
  )
  
})