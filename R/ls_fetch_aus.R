#' Queensland, Australian data
#'
#' @export
#' @param ... curl options passed on to [crul::verb-GET]
#' @references https://doi.org/10.1890/14-0458R.1 
#' http://esapubs.org/archive/ecol/E095/209/metadata.php
#' https://figshare.com/articles/Data_Paper_Data_Paper/3560154
#' @return a list of tibbles
#' 
#' - AuxiliaryData.csv: Each record represents presence data for species on
#' each plot not recorded as a stem ≥10 cm DBH or understory individuals.
#' - TreeMeasurementData.csv: Each record represents the data for one stem for
#' a particular year shown in the variable 'year'.
#' - UnderstoryData.csv: Each record represents the data for a species in the
#' understory (≥50 cm in height and <10 cm DBH) in a particular plot and
#' subplot and the presence or absence in two size classes (≥50 cm in height
#' to 3 m in height, and >3 m in height to <10 cm DBH).
#' - VoucherData.csv: Each record represents a voucher specimen for a species
#' represented either by a stem ≥10 cm DBH, an understory species, or and
#' auxiliary species.
#' 
#' See http://esapubs.org/archive/ecol/E095/209/metadata.php and/or
#' https://figshare.com/articles/Data_Paper_Data_Paper/3560154 for more
#' information on what all the variables mean
#'  
#' @examples \dontrun{
#' res = ls_fetch_aus()
#' res
#' }
ls_fetch_aus <- function(...) {
  xx <- cache_GET(aus_base, "aus", "3560154.zip", ...)
  res <- just_un_zip(xx)
  res2 <- just_un_zip(list.files(res, pattern = ".zip", full.names = TRUE))
  csv_files <- list.files(res2, pattern = ".csv", full.names = TRUE)
  bb <- suppressMessages(lapply(csv_files, f_read, sep = ","))
  stats::setNames(bb, strct(basename(csv_files), "[A-Za-z]+\\.csv"))
}

aus_base <- "https://ndownloader.figshare.com/articles/3560154/versions/1"
