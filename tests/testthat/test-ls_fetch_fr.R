test_that("ls_fetch_fr", {
  vcr::use_cassette("ls_fetch_fr", {
    x <- ls_fetch_fr(year = 2017)
  })
  for (i in names(x)) expect_match(i, "csv")
  for (i in x) expect_is(i, "data.frame")
  for (i in x) expect_is(i, "tbl")
  for (i in x) expect_gt(NROW(i), 10)
})

test_that("ls_fetch_fr fails well", {
  expect_error(ls_fetch_fr(), "\"year\" is missing")
  expect_error(ls_fetch_fr(2000), "not TRUE")
  expect_error(ls_fetch_fr(2030), "not TRUE")
})
