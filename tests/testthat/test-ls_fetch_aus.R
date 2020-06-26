# set cache path to a temp dir
laselva_cache$cache_path_set(full_path = "../files")

test_that("ls_fetch_aus", {
  vcr::use_cassette("ls_fetch_aus", {
    x <- ls_fetch_aus()
  })
  expect_is(x, "list")
  for (i in names(x)) expect_match(i, "csv")
  for (i in x) expect_is(i, "data.frame")
  for (i in x) expect_is(i, "tbl")
  for (i in x) expect_gt(NROW(i), 10)
})
