# Spatial analysis of forest socio-ecological systemin Oaxaca, Mexico based on the DPSIRframework

## About

R code used to create maps based on DPSIR framework and their spatial autocorrelation.

## How to run locally

Not all files are useable at this point. The workable files are in R/independent_maps folder. In order to deploy the maps follow these instructions:

1. Download repository from Github
2. Open R/indepedennt_maps
3. Run the file named "global.R". This file will load all saved .RData necessary to run the maps
4. Run each of the maps individualy

## Interactive map

The maps were deployed in Shiny Apps and available in: https://iskarwaluyo.shinyapps.io/OAXACA_DPSIR/

## Future developments

1. Automating overlays. Overlay analysis is done visually by users. A future development aims at automating overlay analysis of layers.
2. Output maps. Maps will be exported into shapefiles and available for download. Test versions of shapefiles are available in the data/raw_data/shape_ouput/ directory
