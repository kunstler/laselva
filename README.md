laselva
=======



[![Build Status](https://travis-ci.org/ropenscilabs/laselva.svg?branch=master)](https://travis-ci.org/ropenscilabs/laselva)
[![codecov](https://codecov.io/gh/ropenscilabs/laselva/branch/master/graph/badge.svg)](https://codecov.io/gh/ropenscilabs/laselva)

Access to Global Forest Inventory Data

Docs: https://docs.ropensci.org/laselva/

Please cite `laselva` if you use it in a paper: `citation(package = 'laselva')`

## Data sources

- French IGN Institut National de L'Information Geographique et Forestiere
- [Spain][esp]
- European plots [Scientific Data paper][eupaper], [dataset][eufig]
- Australian plots [Ecology paper][auspaper], [dataset][ausfig]
- United States Forest Inventory and Analysis (FIA)

## Install


```r
remotes::install_github("ropenscilabs/laselva")
```


```r
library("laselva")
```

## Meta

* Please [report any issues or bugs](https://github.com/ropenscilabs/laselva/issues).
* License: MIT
* Get citation information for `laselva` in R doing `citation(package = 'laselva')`
* Please note that this project is released with a [Contributor Code of Conduct][coc]
By participating in this project you agree to abide by its terms.

[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)

[coc]: https://github.com/ropenscilabs/laselva/blob/master/.github/CODE_OF_CONDUCT.md
[auspaper]: https://doi.org/10.1890/14-0458R.1
[ausfig]: https://figshare.com/collections/Long-term_stem_inventory_data_from_tropical_rain_forest_plots_in_Australia/3307029
[eupaper]: https://doi.org/10.1038/sdata.2016.123
[eufig]: https://doi.org/10.6084/m9.figshare.c.3288407.v1
[esp]: https://www.miteco.gob.es/fr/biodiversidad/servicios/banco-datos-naturaleza/informacion-disponible/ifn3_base_datos_1_25.aspx
