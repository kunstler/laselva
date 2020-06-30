skip_on_cran()
skip_on_ci() # skip on ci for now, service is down

# set cache path to a temp dir
laselva_cache$cache_path_set(full_path = "../files")

test_that("ls_list_usa", {
  vcr::use_cassette("ls_list_usa", {
    x <- ls_list_usa()
  })
  expect_is(x, "list")
  expect_named(x, c("ref_table", "by_state", "all_states"))
  expect_is(x$ref_table, "data.frame")
  expect_is(x$by_state, "data.frame")
  expect_is(x$all_states, "data.frame")
})

# test_that("ls_list_usa fails well", {
#   expect_error(ls_list_usa(), "\"state\" is missing")
#   expect_error(ls_list_usa("MP", 23), "not TRUE")
# })
