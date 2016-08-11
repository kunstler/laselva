#' fetch datasets
#'
#' @export
#' @param state (character) one or more states (2 letter code), or the special
#' "all", for all states
#' @param what (character) what data to get, one or more values, default: tree
#' @param overwrite (logical) Will only overwrite existing path if \code{TRUE}.
#' default: \code{FALSE}
#' @param ... curl options passed on to \code{\link[httr]{GET}}
#' @return a tibble (a data.frame)
#' @examples \dontrun{
#' # Northern Mariana Islands - trees
#' fia_fetch(state = "MP")
#' # Guam - trees
#' fia_fetch(state = "GU")
#' # Guam - seedling
#' fia_fetch(state = "GU", what = "seedling")
#' # Alaska - plot
#' ak_plot <- fia_fetch(state = "AK", what = "plot")
#' # Arizona - vegetiation subplot - no data, empty data.frame
#' fia_fetch(state = "AZ", what = "veg_subplot")
#'
#' # multiple states
#' x <- fia_fetch(state = c('mp', 'gu'))
#' x$mp_tree
#' x$gu_tree
#'
#' # multiple datasets
#' y <- fia_fetch('as', what = c('seedling', 'plot'))
#' y$as_seedling
#' y$as_plot
#'
#' # multiple states and multiple datasets
#' z <- fia_fetch(state = c('mp', 'gu'), what = c('seedling', 'plot'))
#' z$mp_seedling
#' z$mp_plot
#' z$gu_seedling
#' z$gu_plot
#'
#' # all states, be careful, lots of data
#' ## fia_fetch("all", "subplot_regen")
#' }
fia_fetch <- function(state, what = "tree", overwrite = FALSE, ...) {
  stopifnot(inherits(what, "character"))
  stopifnot(length(what) >= 1)
  urls <- unlist(lapply(state, function(x) {
    file.path(fia_base(), "CSV", paste0(x, "_", what, ".zip"))
  }))
  nms <- gsub("\\.zip", "", basename(urls))
  setNames(lapply(urls, function(z) {
    xx <- fia_cache_GET(z, overwrite, ...)
    suppressMessages(readr::read_csv(un_zip(xx)))
  }), nms)
}
