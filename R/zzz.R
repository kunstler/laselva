fia_GET <- function(x, ...) {
  res <- httr::GET(x, ...)
  httr::stop_for_status(res)
}

cuf8 <- function(x) httr::content(x, "text", encoding = 'UTF-8')

tc <- function(x) Filter(Negate(is.null), x)

fia_base <- function() "http://apps.fs.fed.us/fiadb-downloads"

# http://apps.fs.fed.us/fiadb-downloads/CSV/AL_BOUNDARY.csv
# http://apps.fs.fed.us/fiadb-downloads/CSV/AL_BOUNDARY.zip
# http://apps.fs.fed.us/fiadb-downloads/CSV/OR_TREE.zip

un_zip <- function(x) {
  exdir <- sub("\\.zip", "", x)
  utils::unzip(x, exdir = exdir)
  return(list.files(exdir, pattern = ".csv", full.names = TRUE))
}

fia_cache_path <- function() rappdirs::user_cache_dir("fia-data")
