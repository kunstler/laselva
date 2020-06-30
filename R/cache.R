handle_errors <- function(x, path) {
  if (x$status_code > 201) {
    unlink(path, recursive = TRUE, force = TRUE)
    x$raise_for_status(x)
  }
}

cache_GET <- function(url, path, file = NULL, ...) {
  ending <- if (is.null(file)) basename(url) else file
  fpath <- file.path(laselva_cache$cache_path_get(), path, ending)
  if (file.exists(fpath)) {
    thing_found <- if (!is.null(file)) file else basename(url)
    message(thing_found, " - found in cache")
    return(fpath)
  } else {
    temp_path <- tempfile()
    conn <- crul::HttpClient$new(url = url, opts = list(...))
    res <- conn$get(disk = temp_path)

    # if download has failed, it will stop here
    handle_errors(res, fpath)

    # create directory if it doesn't exist yet
    laselva_cache$mkdir()
    dir.create(file.path(laselva_cache$cache_path_get(), path), FALSE, TRUE)
    invisible(file.rename(temp_path, fpath))

    # return file path
    return(fpath)
  }
}
