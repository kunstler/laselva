#' extract tables from an ms access database file (.accdb)
#' 
#' uses mdbtools command line tools, specifically mdb-tables and mdb-export
#' 
#' @export
#' @keywords internal
#' @param file (character) a file path, must exist
#' @return a list of tibbles/data.frame's
#' @references https://github.com/brianb/mdbtools
#' @details mdbtools is required to run this function.
#' - macos: brew install mdbtools
#' - deb: apt-get install mdbtools
#' - fedora: yum install mdbtools
#' - windows: not sure, anyone?
#' @examples \dontrun{
#' file = "/Users/sckott/Downloads/laselva_data/spain/Sig_05.accdb"
#' extract_ma(file)
#' file = "/Users/sckott/Downloads/laselva_data/spain/Ifn3p05.accdb"
#' extract_ma(file)
#' }
extract_ma <- function(file) {
  os <- tolower(Sys.info()["sysname"])
  if (os == "windows")
    stop("required tool mdbtools is not available for Windows")
  check_for_a_pkg("sys")
  mdbtab <- Sys.which("mdb-tables")
  if (!nzchar(mdbtab[[1]]))
    stop("mdbtools is not installed or can not be found, see ?extract_ma")
  z <- sys::exec_internal("mdb-tables", c("-1", file), error = FALSE)
  if (z$status != 0) stop(rawToChar(z$stderr))
  
  tables <- strsplit(rawToChar(z$stdout), "\n")[[1]]
  res <- vector("list", length(tables))
  names(res) <- tables
  for (tab in tables) {
    f <- tempfile()
    b <- sys::exec_wait("mdb-export", c("-b", "strip", file, tab), std_out = f)
    res[[tab]] <- tibble::as_tibble(data.table::fread(f, data.table = FALSE))
  }
  return(res)
}
