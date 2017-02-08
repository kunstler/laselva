#' List US FIA datasets
#'
#' @export
#' @param ... curl options passed on to \code{\link[httr]{GET}}
#' @return a list of three data.frames (as tibble's)
#' @examples \dontrun{
#' list_datasets_usa()
#' }
list_datasets_usa <- function(...) {
  xx <- cuf8(fia_GET(file.path(fia_base(), "CSV/datamart_csv.html"), ...))
  tabs <- rvest::html_table(xml2::read_html(xx), fill = TRUE, header = TRUE)[-1]
  tabs <- stats::setNames(tabs, c('ref_table', 'by_state', 'all_states'))
  lapply(tabs, tibble::as_data_frame)
}
