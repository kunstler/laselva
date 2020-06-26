handle_errors <- function(x, path) {
  if (x$status_code > 201) {
    unlink(path, recursive = TRUE, force = TRUE)
    x$raise_for_status(x)
  }
}

cache_GET <- function(url, path, ...) {
  fpath <- file.path(laselva_cache$cache_path_get(), path, basename(url))
  if (file.exists(fpath)) {
    message(basename(url), " - found in cache")
    return(fpath)
  } else {
    temp_path <- tempfile()
    conn <- crul::HttpClient$new(url = url, opts = list(...))
    res <- conn$get(disk = temp_path)

    # if download has failed, it will stop here
    handle_errors(res, fpath)

    # create directory if it doesn't exist yet
    laselva_cache$mkdir()
    invisible(file.rename(temp_path, fpath))

    # return file path
    return(fpath)
  }
}
