#' list datasets
#'
#' @export
#' @param state (character) a state, two letter code
#' @param what (character) what data to get, default: tree
#' @param overwrite (logical) Will only overwrite existing path if \code{TRUE}.
#' default: \code{FALSE}
#' @param ... curl options passed on to \code{\link[httr]{GET}}
#' @return a tibble (a data.frame)
#' @examples \dontrun{
#' fia_fetch(state = "MP")
#' }
fia_fetch <- function(state, what = "tree", overwrite = FALSE, ...) {
  url <- file.path(fia_base(), "CSV", paste0(state, "_", what, ".zip"))
  xx <- fia_cache_GET(url, overwrite, ...)
  readr::read_csv(un_zip(xx))
}
