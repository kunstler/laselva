library("vcr")
invisible(vcr::vcr_configure(
  dir = "../fixtures", write_disk_path = "../files"
))
vcr::check_cassette_names()

# set cache path to a temp dir
laselva_cache$cache_path_set(full_path = "../files")
