laselva_cache <- NULL # nocov start

.onLoad <- function(libname, pkgname){
  x <- hoardr::hoard()
  x$cache_path_set("laselva")
  laselva_cache <<- x
} # nocov end
