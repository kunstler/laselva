#' Spain's Third Naitonal Forest Inventory data
#' 
#' Note: command line tool mdbtools required to use this function
#'
#' @export
#' @param location (character) location name, must be length 1. see details.
#' you can pass in names with accepts or capitalized; we'll standardize
#' to lowercase and remove accents.
#' @param ... curl options passed on to [crul::verb-GET]
#' @section Command line tool required:
#' mdbtools is required to run this function. installation for most systems:
#' - macos: brew install mdbtools
#' - deb: apt-get install mdbtools
#' - fedora: yum install mdbtools
#' - windows: not sure, anyone?
#' @details Location name must be one of:
#' - alava
#' - albacete
#' - alicante
#' - almeria
#' - avila
#' - badajoz
#' - islas_baleares
#' - barcelona
#' - burgos
#' - caceres
#' - cadiz
#' - castellon
#' - ciudad_real
#' - cordoba
#' - a_coruna
#' - cuenca
#' - girona
#' - granada
#' - guadalajara
#' - guipuzcoa
#' - huelva
#' - huesca
#' - jaen
#' - leon
#' - lleida
#' @references https://www.miteco.gob.es/fr/biodiversidad/servicios/banco-datos-naturaleza/informacion-disponible/ifn3_base_datos_1_25.aspx
#' @return a list of tibbles
#' @examples \dontrun{
#' res = ls_fetch_esp(location = "alava")
#' res
#' ls_fetch_esp(location = "Álava")
#' ls_fetch_esp(location = "girona")
#' }
ls_fetch_esp <- function(location, ...) {
  assert(location, "character")
  stopifnot(length(location) == 1)
  location <- tolower(location)
  location <- gsub("\'", "", iconv(location, to="ASCII//TRANSLIT"))
  stopifnot(location %in% names(sp_files))
  urls <- file.path(sp_base, sp_files[[location]])
  stats::setNames(lapply(urls, function(w) {
    xx <- cache_GET(w, "spain", ...)
    der <- just_un_zip(xx)
    file <- list.files(der, pattern = ".accdb|.mdb", full.names = TRUE)
    extract_ma(file)
  }), gsub("-", "_", gsub("\\..+", "", basename(urls))))
}

sp_base <- "https://www.miteco.gob.es/fr/biodiversidad/servicios/banco-datos-naturaleza"
sp_files <- list(
  alava = c("sig_01_tcm36-293906.zip", "ifn3p01_tcm36-293907.zip"),
  albacete = c("sig_02_tcm36-293908.zip", "ifn3p02_tcm36-293909.zip"),
  alicante = c("sig_03_tcm36-293910.zip", "ifn3p03_tcm36-293911.zip"),
  almeria = c("sig_04_tcm36-293912.zip", "ifn3p04_tcm36-293913.zip"),
  avila = c("sig_05_tcm36-293914.zip", "ifn3p05_tcm36-293915.zip"),
  badajoz = c("sig_06_tcm36-293916.zip", "ifn3p06_tcm36-293917.zip"),
  islas_baleares = c("sig_07_tcm36-293918.zip", "ifn3p07_tcm36-293919.zip"),
  barcelona = c("sig_08_tcm36-293920.zip", "ifn3p08_tcm36-293921.zip"),
  burgos = c("sig_09_tcm36-293922.zip", "ifn3p09_tcm36-293923.zip"),
  caceres = c("sig_10_tcm36-293924.zip", "ifn3p10_tcm36-293925.zip"),
  cadiz = c("sig_11_tcm36-293926.zip", "ifn3p11_tcm36-293927.zip"),
  castellon = c("sig_12_tcm36-293928.zip", "ifn3p12_tcm36-293929.zip"),
  ciudad_real = c("sig_13_tcm36-293930.zip", "ifn3p13_tcm36-293931.zip"),
  cordoba = c("sig_14_tcm36-293932.zip", "ifn3p14_tcm36-293933.zip"),
  a_coruna = c("sig_15_tcm36-293934.zip", "ifn3p15_tcm36-293935.zip"),
  cuenca = c("sig_16_tcm36-293936.zip", "ifn3p16_tcm36-293937.zip"),
  girona = c("sig_17_tcm36-293938.zip", "ifn3p17_tcm36-293939.zip"),
  granada = c("sig_18_tcm36-293940.zip", "ifn3p18_tcm36-293941.zip"),
  guadalajara = c("sig_19_tcm36-293942.zip", "ifn3p19_tcm36-293943.zip"),
  guipuzcoa = c("sig_20_tcm36-293944.zip", "ifn3p20_tcm36-293945.zip"),
  huelva = c("sig_21_tcm36-293946.zip", "ifn3p21_tcm36-293947.zip"),
  huesca = c("sig_22_tcm36-293948.zip", "ifn3p22_tcm36-293949.zip"),
  jaen = c("sig_23_tcm36-293950.zip", "ifn3p23_tcm36-293951.zip"),
  leon = c("sig_24_tcm36-293952.zip", "ifn3p24_tcm36-293953.zip"),
  lleida = c("sig_25_tcm36-293954.zip", "ifn3p25_tcm36-293955.zip")
)
