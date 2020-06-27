#' Tree inventory data for 21 countries in Europe
#'
#' @export
#' @param ... curl options passed on to [crul::verb-GET]
#' @references https://doi.org/10.1038/sdata.2016.123
#' https://doi.org/10.6084/m9.figshare.c.3288407.v1
#' @return a list of tibbles
#' 
#' - genus: data at the generic level
#' - species: data at the species level
#' 
#' @section Fields:
#' - `x`/`y`: coordinates in a ETRS89-LAEA reference coordinate system,
#' representing the centroid of the INSPIRE-compliant 1 kmx1 km European grid
#' - `country`: the country where the forest plot was sampled
#' - `genus_name`: the name of the genus sampled
#' - `species_name`: the name of the species sampled
#' - `dbh_1`/`dbh_2`: the class for the diameter at breast height of the
#' trunk, which is used to distinguish a new recruit of a given tree.
#' This latter measurement has a value of 1 for trunks with a diameter
#' of less than 120 mm, 2 for trunks with diameter greater than 120 mm,
#' and -9999 for trunks with unknown diameters. The value of 120 mm
#' represents the common minimum threshold adopted by the nfis,
#' although single nfis have different minimum thresholds, ranging from
#' 0 mm in Finland to 120 mm in Cyprus and Switzerland. The choice
#' of threshold has important implications, since estimations of biomass
#' based on different thresholds can deliver very different results.
#' - `nfi`: 1 if the data comes from the nfi, -9999 if not
#' - `ff`: 1 if the data comes from the ff, -9999 if not
#' - `bs`: 1 if the data comes from the bs, -9999 if not
#' - `eeo`: whether or not the target occurrence falls within the
#' species geographical range, measured as the extent of occurrence, 
#' 1 for yes, 0 for no
#' 
#' Acronyms
#' - bs: Biosoil
#' - ff: Forest Focus monitoring database
#' - nfi: National Forest Inventories dataset
#' 
#' See https://doi.org/10.1038/sdata.2016.123 for more information
#'  
#' @examples \dontrun{
#' res = ls_fetch_eu()
#' res
#' }
ls_fetch_eu <- function(...) {
  x_gen <- cache_GET(eu_genus, "eu", "EUForestgenus.csv", ...)
  x_spp <- cache_GET(eu_species, "eu", "EUForestspecies.csv", ...)
  bb <- suppressMessages(lapply(c(x_gen, x_spp), f_read, sep = ","))
  bb <- lapply(bb, function(w) stats::setNames(w, fix_names(w)))
  stats::setNames(bb, c("genus", "species"))
}

eu_genus <- "https://ndownloader.figshare.com/files/6864174"
eu_species <- "https://ndownloader.figshare.com/files/6662535"

fix_names <- function(x) {
  x <- tolower(names(x))
  gsub("-|\\s|\\.", "_", x)
}
