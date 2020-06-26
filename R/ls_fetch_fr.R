#' French IGN NFI data
#' 
#' Fetch French IGN Institut National de L'Information Geographique
#' et Forestiere data
#'
#' @export
#' @param year (integer/numeric) data year to get. possible years: 2005-2018
#' @param ... curl options passed on to [crul::verb-GET]
#' @details `ls_fetch_fr()` gets the given years data, while
#' `ls_fetch_fr_revisit()` gets revisit data for 5 years after the supplied
#' year
#' @references https://inventaire-forestier.ign.fr/
#' @return a list of tibbles
#' 
#' Documentation
#' - documentation_year.csv
#' - documentation_flora.csv
#' 
#' Dead and windfallen trees
#' - dead_trees_forest_year.csv
#' - dead_trees_poplar_year.csv
#' 
#' Covers
#' - cover_forest_year.csv
#' 
#' Ecology
#' - ecology_year.csv
#' 
#' FLora
#' - flora_year.csv
#' 
#' First visits plots
#' - plots_forest_year.csv
#' - plots_poplar_year.csv
#' 
#' Living trees
#' - trees_forest_year.csv
#' - trees_poplar_year.csv
#'  
#' @examples \dontrun{
#' res = ls_fetch_fr(year = 2017)
#' res
#' ls_fetch_fr(year = 2007)
#' 
#' # revisit data
#' ls_fetch_fr_revisit(year = 2007)
#' }
ls_fetch_fr <- function(year, ...) {
  assert(year, c("numeric", "integer"))
  stopifnot(year <= 2018, year >= 2005)
  url <- file.path(fr_base(), sprintf("%s-en.zip", year))
  xx <- cache_GET(url, "france-ign", ...)
  csv_files <- suppressMessages(un_zip(xx))
  bb <- suppressMessages(lapply(csv_files, f_read, sep = ";"))
  stats::setNames(bb, basename(csv_files))
}

#' @export
#' @rdname ls_fetch_fr 
ls_fetch_fr_revisit <- function(year, ...) {
  assert(year, c("numeric", "integer"))
  stopifnot(year <= 2018, year >= 2005)
  url <- file.path(fr_base(), sprintf("%s-%s-en.zip", year, year + 5))
  xx <- cache_GET(url, "france-ign", ...)
  csv_files <- suppressMessages(un_zip(xx))
  bb <- suppressMessages(lapply(csv_files, f_read, sep = ";"))
  stats::setNames(bb, basename(csv_files))
}

fr_base <- function() "https://inventaire-forestier.ign.fr/IMG/zip"
