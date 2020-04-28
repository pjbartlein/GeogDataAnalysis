Note that the data sets on this web page are instructional in nature, intended for illustrating various aspects of data analysis and visualization.  It would be a bad idea to attempt to use them as research-grade data sets.

----

##  .csv files (Dataframes) ##

| Data sets | Description |
|---|---|
| ==========================|=============================================================================|
| [sumcr.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/sumcr.csv) | Summit Cr. stream-channel data |
| [orstationc.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/orstationc.csv) |Oregon climate-station data
| [ortann.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/ortann.csv) | Oregon climate-station data, annual temperatures only
| [orcountyp.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/orcountyp.csv) | Oregon county census data
| [cities.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/cities.csv) | Large cities of the world |
| [cities2.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/cities2.csv) | Large cities of the world, including country names
| [cirques.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/cirques.csv) | Oregon cirque locations and elevations
| [scanvote.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/scanvote.csv) | Scandinavian EU preference votes
| [midwtf2.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/midwtf2.csv) | Midwest pollen and climate data
| [orgrid.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/orgrid.csv) | Gridded Oregon climate data  
| [sierra.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/sierra.csv) | Sierra Nevada dendroclimatological reconstructions
| [specmap.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/specmap.csv) | pecmap oxygen-isotope and insolation data
| [yell\_prato.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/yell_pratio.csv) | Yellowstone precipitation seasonality data
| [yellpolsqrt.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/yellpolsqrt.csv) | Transformed Yellowstone surface-sample pollen data
| [cidat.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/cidat.csv) | Synthetic data for illustrating confidence intervals
| [ttestdat.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/ttestdat.csv) | Synthetic data for illustrating t-tests
| [foursamples.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/foursamples.csv) | Synthetic data for illustrating t-tests
| [anovadat.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/anovadat.csv) | Synthetic data for illustrating analysis of variance
| [orsim.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/orsim.csv) | Future climate simulations for Oregon
| [probdist.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/probdist.csv) | Data and distribution functions for various distributions
| [wus\_pratio.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/wus_pratio.csv) | Western U.S. climate station precipitation ratios
| [wus\_alpha.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/wus_alpha.csv) |Western U.S. climate station AE/PE ratios (alpha) |
| [regrex1.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/regrex1.csv) | Regression analysis example data set 1
| [regrex2.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/regrex2.csv) | Regression analysis example data set 2
| [regrex3.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/regrex3.csv) | Regression analysis example data set 3
| [streams4.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/streams4.csv) | Eastern Oregon stream-health geomorphic data
| [tstreams4.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/tstreams4.csv) | Eastern Oregon stream-health geomorphic data\--transformed values
| [boxes.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/boxes.csv) | Davis PCA example data
| [IPCC-RF.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/IPCC-RF.csv) | IPCC AR5 radiative forcing time series
| [IPCC-RFtrans.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/IPCC-RFtrans.csv) | IPCC AR5 radiattive forcing time series\--transformed values
| [NAmodpol.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/NAmodpol.csv) | North American modern pollen data  
| [gcdv3.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/gcdv3.csv) | Global Charcoal Database v3
| [MM-ltmdiff-NEurAsia.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/MM-ltmdiff-NEurAsia.csv) | Northern Eurasia PMIP3 MH area averages
| [EugeneClim.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/EugeneClim.csv) | Eugene climate data
| [EugeneClim-short.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/EugeneClim-short.csv) | Eugene climate data, "Short" .csv file
| [EugeneClim-short-alt-tvars.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/EugeneClim-short-alt-tvars.csv) | Eugene climate data, alternative layout tvars
| [EugeneClim-short-alt-pvars.csv](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/EugeneClim-short-alt-pvars.csv) | Eugene climate data, alternative layout pvars


Download .csv data sets to a working directory, and read into R using, for example

`sumcr <- read.csv("sumcr.csv"),` or 
`sumcr <- read.csv(file.choose())`

----

## Shapefiles ##

| Description | basename | components |
| --- | --- | --- | --- | 
|=================================== |============|=======================
| Oregon counties and census data | orcounty | [[.dbf]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/orcounty.dbf)   [[.prj]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/orcounty.prj)  [[.shp]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/orcounty.shp) [[.shx]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/orcounty.shx)
| Oregon county outlines only | orotl | [[.dbf]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/orotl.dbf) [[.prj]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/orotl.prj) [[.shp]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/orotl.shp) [[.shx]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/orotl.shx)
| Oregon climate stations | orstations | [[.dbf]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/orstations.dbf) [[.prj]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/orstations.prj) [[.shp]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/orstations.shp) [[.shx]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/orstations.shx)
| Midwest study region | midwotl |[[.dbf]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/midwotl.dbf) [[.prj]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/midwotl.prj) [[.shp]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/midwotl.shp) [[.shx]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/midwotl.shx)
| Scandinavian communes | scand | [[.dbf]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/scand.dbf) [[.prj]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/scand.prj) [[.shp]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/scand.shp) [[.shx]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/scand.shx)
| Western U.S. state outlines | wus | [[.dbf]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/wus.dbf) [[.prj]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/wus.prj) [[.shp]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/wus.shp) [[.shx]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/wus.shx)
| Oregon cirque basins | cirques | [[.dbf]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/cirques.dbf) [[.prj]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/cirques.prj) [[.shp]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/cirques.shp) [[.shx]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/cirques.shx)
| Yellowstone area state border | ynpstate | [[.dbf]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/ynpstate.dbf) [[.prj]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/ynpstate.prj) [[.shp]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/ynpstate.shp) [[.shx]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/ynpstate.shx)
| Yellowsone area rivers | ynprivers | [[.dbf]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/ynprivers.dbf) [[.prj]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/ynprivers.prj) [[.shp]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/ynprivers.shp) [[.shx]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/ynprivers.shx)
| Yellowstone area lakes | ynplk | [[.dbf]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/ynplk.dbf) [[.prj]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/ynplk.prj) [[.shp]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/ynplk.shp) [[.shx]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/ynplk.shx)
| World country outlines | world | [[.dbf]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/world.dbf) [[.prj]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/world.prj) [[.shp]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/world.shp) [[.shx]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/world.shx)  
| *Picea mariana* | picemari | [[.dbf]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/picemari.dbf) [[.prj]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/picemari.prj) [[.shp]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/picemari.shp) [[.shx]](https://pjbartlein.github.io/GeogDataAnalysis/data/shp/picemari.shx)                                           

Download shapefile components to a working directory, and see map-drawing scripts.

----

## Workspaces

GEOG 4/595 data       [[geog495.RData]](https://pjbartlein.github.io/GeogDataAnalysis/data/Rdata/geog495.RData)

Download `.Rdata` files to a working directory, and use `load()` or Load workspace menu (e.g.):

`load("E:/DataVis/working/geog495.RData/")`

(Here is a link to an older workspace that includes `sp` objects used in previous versions of this web page: [[geog495sp.RData]](https://pjbartlein.github.io/GeogDataAnalysis/data/Rdata/geog495sp.RData))

----

## Raster Data Sets / netCDF files ##

| Data sets | Description |
|---|---|
| ===================|==================================================================================|
| [cru10min30\_tmp.nc](https://pjbartlein.github.io/GeogDataAnalysis/data/raster/cru10min30_tmp.nc) | CRU CL 2.0 1961-1990 Monthly Averages (0.5-deg subset)
| [cru10min30\_bio.nc](https://pjbartlein.github.io/GeogDataAnalysis/data/raster/cru10min30_bio.nc) | bioclimatic variables calculated using the CRU CL 2.0 data
| [SSTexample.nc](https://pjbartlein.github.io/GeogDataAnalysis/data/raster/SSTexample.nc) | SST example (raster package)
| [air.mon.anom.nc](https://pjbartlein.github.io/GeogDataAnalysis/data/raster/air.mon.anom.nc) | HADCRUT3 Combined Air Temperature/SST Anomaly Variance Adjusted
| [GFEDv3.1\_ltm.nc](https://pjbartlein.github.io/GeogDataAnalysis/data/raster/GFEDv3.1_ltm.nc) | Global Fire Emissions Database version 3.1 (GFEDv3.1)
| [sage\_veg30.nc](https://pjbartlein.github.io/GeogDataAnalysis/data/raster/sage_veg30.nc) | Ramankutty and Foley Potential Vegetation Type (Univ. Wisc. SAGE)
| [treecov.nc](https://pjbartlein.github.io/GeogDataAnalysis/data/raster/treecov.nc) | UMD Tree Cover Data resampled to 0.5-degrees
| [tcdc.eatm.mon.mean.nc](https://pjbartlein.github.io/GeogDataAnalysis/data/raster/tcdc.eatm.mon.mean.nc) | Clouds \-- Monthly NOAA-CIRES 20th Century Reanalysis V2

Check global attributes for data-set sources.

Right-click on dataset name, and download to an appropriate folder.

------------------------------------------------------------------------

Note that the data sets on this web page are instructional in nature, intended for illustrating various aspects of data analysis and visualization.  It would be a bad idea to use them as research-grade data sets.

 
