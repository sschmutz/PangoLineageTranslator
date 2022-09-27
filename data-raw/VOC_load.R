# read VOC data from csv file and store as .rda
VOC <- readr::read_csv(here::here("data-raw", "VOC.csv"))
usethis::use_data(VOC, overwrite = TRUE)
