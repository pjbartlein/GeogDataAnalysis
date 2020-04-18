
# Introduction to the course #

## Data Analysis vs "Statistics" and their roles in geography ##

- Data analysis features continual iterations between the development of a conceptual model of reality (theory building or hypothesis generation) and the testing of that model (using formal or informal hypothesis testing).
- Classical statistics has been more oriented toward assessment (hypothesis testing) than toward discovery of relationships within data sets.
- Modern data analysis exploits recent developments in computing, and "scientific visualization," but still uses more traditional "statistical analysis" approaches when appropriate.
- Roles in geography:  "quantitative revolution", "GIS revolution", "Geographic Visualization".

**Statistics is not mathematics; data analysis is not statistics; but visualization *is* data analysis**

## Course Plan:  Visualization and Data Analysis Using "R" ##

- lecture web pages with embedded R examples
- exercises with other examples
- R "packages" for advanced analyses
- two take-home exams

# Nature of Geographical Data #

An implicit feature of most data sets that are examined by geographers is that individual "observations" have locational information attached to them.

Most statistical packages do not explicitly recognize those spatial attributes--i.e. they treat them as ordinary variables.

The principal exception is the software package we'll use here--**R**

The "[Data Cube](https://pjbartlein.github.io/GeogDataAnalysis/images/dcube0.gif)" -- attributes, locations, occasions. The cube is made up of individual cells or datums, that represent a single attribute or variable, measured at a particular place and time (after Rummel, 1970, and many others).

- [location x time slice](https://pjbartlein.github.io/GeogDataAnalysis/images/dcube1.gif) 
- [time x attribute slice](https://pjbartlein.github.io/GeogDataAnalysis/images/dcube2.gif)
- [attribute x location slice](https://pjbartlein.github.io/GeogDataAnalysis/images/dcube3.gif)

The Rectangular Data Set -- Two Examples

- Summit Cr. Geomorphic Data [[sumcr.csv]](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/sumcr.csv)
- Megacities [[cities.csv]](https://pjbartlein.github.io/GeogDataAnalysis/data/csv/cities.csv)

# R:  Software for data analysis and visualization #

**R** -- Back to the future?

- Command-line interface as opposed to point-and-click GUI
- Extensible to new analyses
- Based on the "S" language
- Open source  [http://www.r-project.org/ ](http://www.r-project.org/ )(home page)   
- many add-on "packages" [http://cran.us.r-project.org/](http://cran.us.r-project.org/) (software)

Many ways to use 
 
- directly from the command line -Rterm (hard-core)
- RGui interface, along with a text editor (recommended)
- other gui's (RStudio (recommended); Rcmdr package)
- Basic idea:  Use text editor and RGui/RStudio jointly to write and debug "scripts"

# Exercise 1:  Getting and Using R (and RStudio) #

- [[https://pjbartlein.github.io/GeogDataAnalysis/ex01.html]](https://pjbartlein.github.io/GeogDataAnalysis/ex01.html)

# Readings: #

Links to the readings can be found on the *Resources* tab.  

- Owen (*The R Guide*):  sections 1 and 2, scan section 3; 
- Kuhnert & Venebles (*An Introduction...*):  p. 13-20
- Cleveland (*Visualizing Data* (reserve, but currently not available in library): Ch. 1

Also, take a quick look at the folowing *Bookdown* eBooks

- *Geocomputation with R* (Lovelace, Nowosad, Muenchow)
- *Spatial Data Science* (Pebesma and Bivand)

 
