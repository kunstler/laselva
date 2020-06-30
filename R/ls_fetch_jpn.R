#' Japan's Forest Data
#' 
#' Japan Ministry of the Environment, Monitoring Sites 1000 Project
#'
#' @export
#' @param ... curl options passed on to [crul::verb-GET]
#' @references
#' http://db.cger.nies.go.jp/JaLTER/ER_DataPapers/archives/2011/ERDP-2011-01/metadata
#' @return a list of data and metadata:
#' - species_list: a data.frame with species information
#' - site_list: a data.frame with site information
#' - tree_data: a list of data.frame's named by their sites, which match the 
#' column `PlotID` in the `site_list` data.frame (except `-` is swapped with
#' `_` for easier indexing)
#' - metadata: an object of class `emld` containing metadata for the data
#' @note The `emld` R package is required for EML metadata access. If you
#' don't have it installed we'll just return an empty list
#' @examples \dontrun{
#' res = ls_fetch_jpn()
#' res
#' }
ls_fetch_jpn <- function(...) {
  # species list
  sppl <- jpn_get(jpn_fm$sp_list$data_id, jpn_fm$sp_list$docname, ...)
  spp_df <- f_read(sppl)
  
  # site list
  sitel <- jpn_get(jpn_fm$site_list$data_id, jpn_fm$site_list$docname, ...)
  site_df <- f_read(sitel)

  # tree data
  trees <- jpn_get(jpn_fm$tree_data$data_id, jpn_fm$tree_data$docname, ...)
  trees_dir <- just_un_zip(trees)
  csv_files <- list.files(trees_dir, pattern = ".csv", full.names = TRUE)
  bb <- suppressMessages(lapply(csv_files, f_read, sep = ","))
  nms <- gsub("-", "_", strct(basename(csv_files), "[A-Za-z]+-[A-Za-z0-9]+"))
  tree_data <- stats::setNames(bb, nms)

  # EML metadata
  meta <- list()
  check_emld = check_for_a_pkg("emld", warning)
  if (isTRUE(check_emld)) {
    emlpath <- cache_GET(jpn_eml, "japan", "ERDP_2011_01.10.2.xml", ...)
    meta <- emld::as_emld(emlpath)
  }

  list(
    species_list = spp_df, 
    site_list = site_df, 
    tree_data = tree_data,
    metadata = meta
  )
}

jpn_base <- "http://db.cger.nies.go.jp/JaLTER"
jpn_data <- file.path(jpn_base, "script/licence.php")
jpn_eml <- file.path(jpn_base, 
  "metacat/metacat?action=read&qformat=xml&docid=ERDP_2011_01.10.2")
jpn_get <- function(data_id, docname, ...) {
  fpath <- file.path(laselva_cache$cache_path_get(), "japan", docname)
  if (file.exists(fpath)) {
    message(docname, " - found in cache")
    return(fpath)
  } else {
    laselva_cache$mkdir()
    dir.create(file.path(laselva_cache$cache_path_get(), "japan"), FALSE, TRUE)
    con <- HttpClient$new(url = jpn_data,
      headers = list(`Content-Type` = "application/x-www-form-urlencoded"),
      opts = list(...))
    body <- list(username="janedoe", orgname="foobar",
      mailaddr="foo@bar.com", purpose="research", other_reason="x",
      data_id=data_id, docname=docname, lang="en")
    res <- con$post(body = body, encode = "form", disk = fpath)
    res$raise_for_status()
    return(res$content)
  }
}
jpn_fm <- list(
  sp_list = list(data_id = "ERDP_2011_01.3.1", docname = "SpList.csv"),
  site_list = list(data_id = "ERDP_2011_01.5.1", docname = "SiteList.csv"),
  tree_data = list(data_id = "ERDP_2011_01.7.1", docname = "TreeData.zip")
)
