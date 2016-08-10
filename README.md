laselva
=======



[![Build Status](https://travis-ci.org/ropenscilabs/laselva.svg?branch=master)](https://travis-ci.org/ropenscilabs/laselva)



## Install


```r
devtools::install_github("ropenscilabs/laselva")
```


```r
library("laselva")
```

## list data


```r
fia_datasets()
#> $ref_table
#> # A tibble: 21 x 5
#>                     ZIP Files                  CSV Files Number of Records
#>                         <chr>                      <chr>             <int>
#> 1                BEGINEND.zip               BEGINEND.csv                 2
#> 2  LICHEN_SPECIES_SUMMARY.zip LICHEN_SPECIES_SUMMARY.csv              2404
#> 3            REF_CITATION.zip           REF_CITATION.csv                35
#> 4       REF_FIADB_VERSION.zip      REF_FIADB_VERSION.csv                20
#> 5         REF_FOREST_TYPE.zip        REF_FOREST_TYPE.csv               207
#> 6   REF_FOREST_TYPE_GROUP.zip  REF_FOREST_TYPE_GROUP.csv                34
#> 7            REF_GRM_TYPE.zip           REF_GRM_TYPE.csv               142
#> 8  REF_HABTYP_DESCRIPTION.zip REF_HABTYP_DESCRIPTION.csv              8710
#> 9  REF_HABTYP_PUBLICATION.zip REF_HABTYP_PUBLICATION.csv               125
#> 10   REF_INVASIVE_SPECIES.zip   REF_INVASIVE_SPECIES.csv              1832
#> # ... with 11 more rows, and 2 more variables: Last Created Date <chr>,
#> #   Last Modified Date <chr>
#> 
#> $by_state
#> # A tibble: 3,304 x 5
#>                         Zip Files                      CSV Files
#>                             <chr>                          <chr>
#> 1                                                           <NA>
#> 2                  ALABAMA AL.zip                               
#> 3                 AL_BOUNDARY.zip                AL_BOUNDARY.csv
#> 4                     AL_COND.zip                    AL_COND.csv
#> 5            AL_COND_DWM_CALC.zip           AL_COND_DWM_CALC.csv
#> 6                   AL_COUNTY.zip                  AL_COUNTY.csv
#> 7  AL_DWM_COARSE_WOODY_DEBRIS.zip AL_DWM_COARSE_WOODY_DEBRIS.csv
#> 8     AL_DWM_DUFF_LITTER_FUEL.zip    AL_DWM_DUFF_LITTER_FUEL.csv
#> 9    AL_DWM_FINE_WOODY_DEBRIS.zip   AL_DWM_FINE_WOODY_DEBRIS.csv
#> 10      AL_DWM_MICROPLOT_FUEL.zip      AL_DWM_MICROPLOT_FUEL.csv
#> # ... with 3,294 more rows, and 3 more variables: Number of Records <int>,
#> #   Last Created Date <chr>, Last Modified Date <chr>
#> 
#> $all_states
#> # A tibble: 57 x 5
#>                      ZIP Files                   CSV Files
#>                          <chr>                       <chr>
#> 1                 BOUNDARY.zip                BOUNDARY.csv
#> 2                     COND.zip                    COND.csv
#> 3            COND_DWM_CALC.zip           COND_DWM_CALC.csv
#> 4                   COUNTY.zip                  COUNTY.csv
#> 5  DWM_COARSE_WOODY_DEBRIS.zip DWM_COARSE_WOODY_DEBRIS.csv
#> 6     DWM_DUFF_LITTER_FUEL.zip    DWM_DUFF_LITTER_FUEL.csv
#> 7    DWM_FINE_WOODY_DEBRIS.zip   DWM_FINE_WOODY_DEBRIS.csv
#> 8       DWM_MICROPLOT_FUEL.zip      DWM_MICROPLOT_FUEL.csv
#> 9        DWM_RESIDUAL_PILE.zip       DWM_RESIDUAL_PILE.csv
#> 10    DWM_TRANSECT_SEGMENT.zip    DWM_TRANSECT_SEGMENT.csv
#> # ... with 47 more rows, and 3 more variables: Number of Records <int>,
#> #   Last Created Date <chr>, Last Modified Date <chr>
```

## get data


```r
fia_fetch(state = "MP")
#> # A tibble: 2,208 x 158
#>              CN      PLT_CN PREV_TRE_CN INVYR STATECD UNITCD COUNTYCD
#>           <dbl>       <dbl>       <chr> <int>   <int>  <int>    <int>
#> 1  2.754838e+14 2.73488e+14        <NA>  2004      69      1      100
#> 2  2.754838e+14 2.73488e+14        <NA>  2004      69      1      100
#> 3  2.754838e+14 2.73488e+14        <NA>  2004      69      1      100
#> 4  2.754838e+14 2.73488e+14        <NA>  2004      69      1      100
#> 5  2.754838e+14 2.73488e+14        <NA>  2004      69      1      100
#> 6  2.754838e+14 2.73488e+14        <NA>  2004      69      1      100
#> 7  2.754838e+14 2.73488e+14        <NA>  2004      69      1      100
#> 8  2.754838e+14 2.73488e+14        <NA>  2004      69      1      100
#> 9  2.754838e+14 2.73488e+14        <NA>  2004      69      1      100
#> 10 2.754838e+14 2.73488e+14        <NA>  2004      69      1      100
#> # ... with 2,198 more rows, and 151 more variables: PLOT <int>,
#> #   SUBP <int>, TREE <int>, CONDID <int>, AZIMUTH <int>, DIST <dbl>,
#> #   PREVCOND <chr>, STATUSCD <int>, SPCD <int>, SPGRPCD <int>, DIA <dbl>,
#> #   DIAHTCD <int>, HT <int>, HTCD <int>, ACTUALHT <int>, TREECLCD <int>,
#> #   CR <int>, CCLCD <int>, TREEGRCD <chr>, AGENTCD <chr>, CULL <int>,
#> #   DAMLOC1 <int>, DAMTYP1 <int>, DAMSEV1 <int>, DAMLOC2 <int>,
#> #   DAMTYP2 <int>, DAMSEV2 <int>, DECAYCD <int>, STOCKING <dbl>,
#> #   WDLDSTEM <chr>, VOLCFNET <dbl>, VOLCFGRS <dbl>, VOLCSNET <dbl>,
#> #   VOLCSGRS <dbl>, VOLBFNET <dbl>, VOLBFGRS <dbl>, VOLCFSND <dbl>,
#> #   GROWCFGS <chr>, GROWBFSL <chr>, GROWCFAL <chr>, MORTCFGS <chr>,
#> #   MORTBFSL <chr>, MORTCFAL <chr>, REMVCFGS <chr>, REMVBFSL <chr>,
#> #   REMVCFAL <chr>, DIACHECK <int>, MORTYR <chr>, SALVCD <chr>,
#> #   UNCRCD <int>, CPOSCD <chr>, CLIGHTCD <chr>, CVIGORCD <chr>,
#> #   CDENCD <chr>, CDIEBKCD <chr>, TRANSCD <chr>, TREEHISTCD <chr>,
#> #   DIACALC <chr>, BHAGE <chr>, TOTAGE <chr>, CULLDEAD <chr>,
#> #   CULLFORM <chr>, CULLMSTOP <chr>, CULLBF <chr>, CULLCF <chr>,
#> #   BFSND <chr>, CFSND <chr>, SAWHT <chr>, BOLEHT <chr>, FORMCL <chr>,
#> #   HTCALC <chr>, HRDWD_CLUMP_CD <int>, SITREE <chr>, CREATED_BY <chr>,
#> #   CREATED_DATE <date>, CREATED_IN_INSTANCE <int>, MODIFIED_BY <chr>,
#> #   MODIFIED_DATE <date>, MODIFIED_IN_INSTANCE <int>, MORTCD <chr>,
#> #   HTDMP <dbl>, ROUGHCULL <chr>, MIST_CL_CD <chr>, CULL_FLD <int>,
#> #   RECONCILECD <chr>, PREVDIA <chr>, FGROWCFGS <chr>, FGROWBFSL <chr>,
#> #   FGROWCFAL <chr>, FMORTCFGS <chr>, FMORTBFSL <chr>, FMORTCFAL <chr>,
#> #   FREMVCFGS <chr>, FREMVBFSL <chr>, FREMVCFAL <chr>, P2A_GRM_FLG <chr>,
#> #   TREECLCD_NERS <chr>, TREECLCD_SRS <chr>, TREECLCD_NCRS <chr>,
#> #   TREECLCD_RMRS <chr>, ...
```
