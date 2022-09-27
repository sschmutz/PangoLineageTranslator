test_that("expected column names are present", {

  expect_named(read_alias_key(), c("pango_short", "pango_long"))
  
})

test_that("tibble is not empty", {
  
  expect_gt(nrow(read_alias_key()), 0)

})

test_that("data is stored as string", {
  
  expect_type(read_alias_key()$pango_short, "character")
  expect_type(read_alias_key()$pango_long, "character")
  
})

test_that("removing certain rows works", {
  
  alias_key_default <- read_alias_key()
  alias_key_recombinants <- read_alias_key(remove_empty_translations = FALSE)
  alias_key_full <- read_alias_key(remove_recombinants = FALSE,
                                   remove_empty_translations = FALSE)
  
  expect_gt(nrow(alias_key_recombinants), nrow(alias_key_default))
  expect_gt(nrow(alias_key_full), nrow(alias_key_recombinants))
  
})