#' List USA Forest Inventory and Analysis (FIA) datasets
#'
#' @export
#' @param ... curl options passed on to [crul::verb-GET]
#' @return a list of three data.frames (as tibble's), one for
#' reference metadata files, datasets by state and datasets
#' with all states combined
#' @references 
#' https://apps.fs.usda.gov/fia/datamart/CSV/datamart_csv.html
#' @examples \dontrun{
#' x <- ls_list_usa()
#' x
#' x$ref_table
#' x$by_state
#' x$all_states
#' }
ls_list_usa <- function(...) {
  xx <- fia_GET(fia_base(), "fia/datamart/CSV/datamart_csv.html",
  	...)$parse("UTF-8")
  tabs <- rvest::html_table(xml2::read_html(xx), fill = TRUE,
  	header = TRUE)[-1]
  tabs <- stats::setNames(tabs, c('ref_table', 'by_state', 'all_states'))
  lapply(tabs, tibble::as_tibble)
}
