skip_on_cran()

# set cache path to a temp dir
laselva_cache$cache_path_set(full_path = "../files")

test_that("ls_fetch_fra", {
  vcr::use_cassette("ls_fetch_fra", {
    x <- ls_fetch_fra(year = 2017)
  })
  for (i in names(x)) expect_match(i, "csv")
  for (i in x) expect_is(i, "data.frame")
  for (i in x) expect_is(i, "tbl")
  for (i in x) expect_gt(NROW(i), 10)
})

test_that("ls_fetch_fra fails well", {
  expect_error(ls_fetch_fra(), "\"year\" is missing")
  expect_error(ls_fetch_fra(2000), "not TRUE")
  expect_error(ls_fetch_fra(2030), "not TRUE")
})
