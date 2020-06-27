# set cache path to a temp dir
laselva_cache$cache_path_set(full_path = "../files")

test_that("ls_fetch_eu", {
  vcr::use_cassette("ls_fetch_eu", {
    x <- ls_fetch_eu()
  })
  expect_is(x, "list")
  expect_named(x, c("genus", "species"))
  for (i in x) expect_is(i, "data.frame")
  for (i in x) expect_is(i, "tbl")
  for (i in x) expect_gt(NROW(i), 10)
})
