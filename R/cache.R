handle_errors <- function(x, path) {
  if (x$status_code > 201) {
    httr::stop_for_status(x)
    unlink(path, recursive = TRUE, force = TRUE)
  }
}

fia_cache_GET <- function(url, overwrite, ...) {
  fpath <- file.path(fia_cache_path(), basename(url))
  if (file.exists(fpath)) {
    message("File in cache")
    return(fpath)
  } else {
    temp_path <- tempfile()
    res <- httr::GET(url, httr::write_disk(path = temp_path, overwrite = overwrite), ...)

    # if download has failed, it will stop here
    handle_errors(res, fpath)

    # create directory if it doesn't exist yet
    dir.create(dirname(fpath), showWarnings = FALSE, recursive = TRUE)
    file.rename(temp_path, fpath)

    # return file path
    return(fpath)
  }
}
