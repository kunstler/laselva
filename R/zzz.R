fia_GET <- function(base, path, ...) {
	conn <- crul::HttpClient$new(url = base, opts = list(...))
  res <- conn$get(path)
  res$raise_for_status()
  return(res)
}

tc <- function(x) Filter(Negate(is.null), x)

fia_base <- function() "https://apps.fs.usda.gov"
# "https://apps.fs.fed.us/fiadb-downloads"

# http://apps.fs.fed.us/fiadb-downloads/CSV/AL_BOUNDARY.csv
# http://apps.fs.fed.us/fiadb-downloads/CSV/AL_BOUNDARY.zip
# http://apps.fs.fed.us/fiadb-downloads/CSV/OR_TREE.zip

un_zip <- function(x) {
  exdir <- sub("\\.zip", "", x)
  utils::unzip(x, exdir = exdir)
  return(list.files(exdir, pattern = ".csv", full.names = TRUE))
}
