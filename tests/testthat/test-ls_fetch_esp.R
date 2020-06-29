skip_on_cran()

# set cache path to a temp dir
laselva_cache$cache_path_set(full_path = "../files")

test_that("ls_fetch_esp", {
  vcr::use_cassette("ls_fetch_esp", {
    x <- ls_fetch_esp(location = "girona")
  })
  for (i in names(x)) expect_match(i, "17")
  for (i in x) expect_is(i, "list")
  for (i in x) for (j in i) expect_is(j, "tbl")
})

test_that("ls_fetch_esp fails well", {
  expect_error(ls_fetch_esp(), "\"location\" is missing")
  expect_error(ls_fetch_esp(letters), "not TRUE")
  expect_error(ls_fetch_esp(23423), "must be")
})
