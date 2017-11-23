#' Fetch USA Forest Inventory and Analysis (FIA) datasets
#'
#' @export
#' @param state (character) one or more states (2 letter code), or the special
#' "all", for all states
#' @param what (character) what data to get, one or more values, default: tree
#' @param ... curl options passed on to [crul::HttpClient]
#' @return a tibble (a data.frame)
#' @examples \dontrun{
#' # Northern Mariana Islands - trees
#' fetch_usa(state = "MP")
#' # Guam - trees
#' fetch_usa(state = "GU")
#' # Guam - seedling
#' fetch_usa(state = "GU", what = "seedling")
#' # Alaska - plot
#' ak_plot <- fetch_usa(state = "AK", what = "plot")
#' # Arizona - vegetiation subplot - no data, empty data.frame
#' fetch_usa(state = "AZ", what = "veg_subplot")
#'
#' # multiple states
#' x <- fetch_usa(state = c('mp', 'gu'))
#' x$mp_tree
#' x$gu_tree
#'
#' # multiple datasets
#' y <- fetch_usa('as', what = c('seedling', 'plot'))
#' y$as_seedling
#' y$as_plot
#'
#' # multiple states and multiple datasets
#' z <- fetch_usa(state = c('mp', 'gu'), what = c('seedling', 'plot'))
#' z$mp_seedling
#' z$mp_plot
#' z$gu_seedling
#' z$gu_plot
#'
#' # all states, be careful, lots of data
#' ## fetch_usa("all", "subplot_regen")
#' }
fetch_usa <- function(state, what = "tree", ...) {
  stopifnot(inherits(what, "character"))
  stopifnot(length(what) >= 1)
  if (state == 'all') {
    urls <- file.path(fia_base(), "fia/datamart/CSV", paste0(what, ".zip"))
  } else {
    urls <- unlist(lapply(state, function(x) {
      file.path(fia_base(), "fia/datamart/CSV", paste0(x, "_", what, ".zip"))
    }))
  }
  nms <- gsub("\\.zip", "", basename(urls))
  stats::setNames(lapply(urls, function(z) {
    xx <- fia_cache_GET(z, ...)
    suppressMessages(readr::read_csv(un_zip(xx)))
  }), nms)
}
