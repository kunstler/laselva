skip_on_cran()
skip_on_os('windows') # not sure how to install mdbtools on Windows

# set cache path to a temp dir
laselva_cache$cache_path_set(full_path = "../files")

test_that("ls_fetch_jpn", {
  vcr::use_cassette("ls_fetch_jpn", {
    x <- ls_fetch_jpn()
  })
  expect_named(x, c("species_list", "site_list", "tree_data", "metadata"))
  expect_is(x$species_list, "data.frame")
  expect_is(x$site_list, "data.frame")
  for (i in names(x$tree_data)) expect_match(i, "_")
  for (i in x$tree_data) expect_is(i, "data.frame")
  expect_is(x$metadata, "emld")
})
