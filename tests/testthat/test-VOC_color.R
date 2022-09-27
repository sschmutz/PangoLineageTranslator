test_that("correct vector is returned", {
  
  # Alpha
  expect_equal(VOC_color("B.1.1.7"),
               c("font" = "#040912",
                 "background_level_base" = "#3C79D9"))
  
  # Beta
  expect_equal(VOC_color("B.1.351.1"),
               c("font" = "#001A0E",
                 "background_level_base" = "#069631"))
  
  # Gamma
  expect_equal(VOC_color("B.1.1.28.1.1"),
               c("font" = "#425810",
                 "background_level_base" = "#A1D427"))
  
  # Delta
  expect_equal(VOC_color("B.1.617.2.1"),
               c("font" = "#010F1B",
                 "background_level_base" = "#0C81DE"))
  
  # Omicron
  expect_equal(VOC_color("B.1.1.529.1"),
               c("font" = "#3A0301",
                 "background_level_base" = "#E69000"))
  
  # non-VOC
  expect_equal(VOC_color("B.1"),
               c("font" = "#0B0C0E",
                 "background_level_base" = "#777D88"))
  
})