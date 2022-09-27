test_that("a gt table is returned", {
  
  pango_lineage_full_tibble <- divide_lineage("B.1.617.2.2")
  color_vector <- VOC_color("B.1.617.2.2")
  
  expect_s3_class(create_pango_lineage_table(pango_lineage_full_tibble, color_vector),
                  "gt_tbl")

})