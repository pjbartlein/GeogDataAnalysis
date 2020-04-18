# Introduction #

Raster, or gridded data sets (including x-y, or x-y-z data sets as special cases), arise frequently in practice, from such sources as

- weather and climate modeling
- remote sensing by satellite and aircraft
- GIS-managed data, which may be processed and exported on a grid.

Traditionally, such data are managed and analyzed in special-purpose software or environments, such as ENVI or ERDAS Imagine for remote-sensing data, ArcGIS, GRASS or IDRISI for general-purpose GIS-based data, or GrADS, IDL or NCL, for climate data, or with programs written in Fortran or C (or more recently, Python).  Typically, a user would do much of the basic data processing in the specialized environment or programming language, then export the data to R or another statistical package for data analysis and visualization, then move the data back into the specialized software for further processing.

Individual subdisciplines often have specialized formats for data storage, sometimes general or community-wide ones such as netCDF or GRIB for climate data, GeoTIFF or HDF for remote-sensing data (the latter especially for satellite data), or "proprietary" formats for specific software packages (i.e. ArcGIS).  These formats are sufficiently different from one another to make reading and writing them a less-than-automatic task.

R, and S+ before it, have included libraries/packages that support the dialog between, for example, R and the GRASS open-source GIS (i.e. spgrass6).  More recently, however, the raster package in R allows the execution of many of the typical analyses that a general GIS would provide, without the need for an interface – the analysis can be done directly (and entirely) in R.  

The `raster` package can read and write many of the standard formats for handling raster data, and also has the facility for doing so without loading the entire data set into memory; this facilitates the analysis of very large data sets.  In the examples described here, data stored as netCDF files, the principle mode in which large climate and Earth-system science data sets are stored, are used to illustrate the approach for reading and writing large data sets using the `ncdf4` package and reading and analyzing data using the `raster` package, but the same basic ideas apply to, for example, HDF files read using `readGDAL()` from the `rgdal` package.

# Examples #

Here are some examples from GEOG 4/595 (GIScience:  *R for Earth System Science*)

- [netCDF in R, introduction, reading, manipulating and writing files](http://geog.uoregon.edu/bartlein/courses/geog490/week04-netCDF.html)
- [the R raster and rasterVis packages](http://geog.uoregon.edu/bartlein/courses/geog490/week04-raster.html)
- [raster and netCDF import and export](http://geog.uoregon.edu/bartlein/courses/geog490/week04-ncdf4-vs-raster.html)
- [extensions of familiar multivariate methods (i.e. PCA) for dealing with hundreds or thousands of variables.](http://geog.uoregon.edu/bartlein/courses/geog490/week10-PCA_highdim.html)

.
