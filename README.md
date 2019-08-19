AfricaUrbanPop
==============================

This repo contains the code and final data for *Variability in urban population distributions across Africa* published in [Enivronmental Research Letters](https://iopscience.iop.org/article/10.1088/1748-9326/ab2432). The gridded population data needed to produce the final urban settlement polygons in our paper is available from [PopGrid.org](https://www.popgrid.org/compare-data) and Esri Inc. We use:

- Global Human Settlment Layer Population (GHS-Pop), 2000 & 2015 (CRS is different than the other datasets--transform as needed)
- WorldPop 2015
- ESRI Inc. Gridded Population of the World 2016
- LandScan 2015

The code is currently written in Jupyter Notebooks (Steps 1-6) located in the Notebook directory. Some of functions have been ported to the SRC directory as .py files (more will be soon). 

The final urban population data used in our analysis (available as both shape and csv files) is in ERL_Data directory in the repo. Please the README.txt file included in that directory. Also included is the manually buffered Africa shape file we used to clip rasters.  

The code may be buggy, as I am in the processes of cleaning it. I will add file structure and data more explainers in the next few weeks. Please ping me with any questions.

Cascade 2019-08-18

