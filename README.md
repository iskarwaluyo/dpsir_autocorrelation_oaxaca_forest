# Spatial analysis of forest socio-ecological systemin Oaxaca, Mexico based on the DPSIRframework

## About

R code used to create maps based on DPSIR framework and their spatial autocorrelation.

## Running maps locally

### Running each map individually locally

1. Download repository from Github
2. Open R/indepedent_maps
3. Run the file named "global.R" with RStudio This file will load all saved .RData necessary to run the maps
4. Run each of the maps individualy

### Running the interactive map locally

1. Download repository from Github
2. Open R/shiny_app_map/
3. Run any of the following files: "ui.R, "server.R" or "global.R" with RStudio. This will run Shiny Apps locally and deploy a local version of the interactie map. 

NOTE: All data is loaded from Github so internet connection is needed even when running maps locally.

## Interactive map

The maps were deployed in Shiny Apps and available in: https://iskarwaluyo.shinyapps.io/OAXACA_DPSIR/

NOTE: App runs at limits for a free account and may not always load. 

## Future developments

1. Memory use optimization. Currently the web map often crashes due to memory overload for a free Shiny Apps account. We are trying to find ways to reduce memory usage.

2. Automating overlays. Overlay analysis is done visually by users. A future development aims at automating overlay analysis of layers.

3. Output maps. Maps will be exported into shapefiles and available for download. Test versions of shapefiles are available in the data/raw_data/shape_ouput/ directory
