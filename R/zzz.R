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
  z <- just_un_zip(x)
  return(list.files(z, pattern = ".csv", full.names = TRUE))
}

just_un_zip <- function(x, exdir = NULL) {
  if (is.null(exdir)) exdir <- sub("\\.zip", "", x)
  utils::unzip(x, exdir = exdir, junkpaths = TRUE)
  return(exdir)
}

assert <- function(x, y) {
  if (!is.null(x)) {
    if (!inherits(x, y)) {
      stop(deparse(substitute(x)), " must be of class ",
        paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}

f_read <- function(x, sep = "auto") {
  tibble::as_tibble(data.table::fread(x, sep = sep, data.table = FALSE))
}

strct <- function(str, pattern) regmatches(str, regexpr(pattern, str))

check_for_a_pkg <- function(x, condition = stop) {
  if (!requireNamespace(x, quietly = TRUE)) {
    condition("Please install ", x, call. = FALSE)
  } else {
    invisible(TRUE)
  }
}
