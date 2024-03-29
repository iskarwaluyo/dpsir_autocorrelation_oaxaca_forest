# Spatial analysis of forest socio-ecological system in Oaxaca, Mexico based on the DPSIRframework

## Abstract

The Driver-Pressure-State-Impact-Response (DPSIR) framework can be used to analyze interactions between society and the environment, including for forest socio-ecological systems, such as ones in Oaxaca, Mexico. In this paper, the DPSIR framework was operationalized through indicators obtained from Inegi, Semarnat and Conafor: the economic value of agricultural activities and population were considered Drivers (D), surfaces used for agricultural activities were considered Pressure(P), current land use and vegetation coverage was used to describe State (S), timber and non-timber production was considered Impacts (I) and payments for ecosystem services (PES) were considered Response (R). Values per municipality of each of the indicators allowed estimating the spatial autocorrelation (Moran´s I) between indicator groups. Results suggest that municipalities with agricultural and livestock activity are mostly located in municipalities that border Veracruz and in certain parts of the Costa. Municipalities with more timber production are located in the Sierra Norte (Ixtlan de Juarez, Santa Catarina Ixtepeji, San Pablo Macuiltianguis). In Oaxaca, there are no trade-offs between forestry and agricultural and livestock activities. Results are indicative of the effects of PES that promote forest conservation in Sierra Norte and patterns of agriculture and livestock near borders which may be indicative of trade activities.

R was used to create maps based on DPSIR framework and their spatial autocorrelation.

## Deployment

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

## Built with

## Future developments

1. Memory use optimization. Currently the web map often crashes due to memory overload for a free Shiny Apps account. We are trying to find ways to reduce memory usage.

2. Automating overlays. Overlay analysis is done visually by users. A future development aims at automating overlay analysis of layers.

3. Output maps. Maps will be exported into shapefiles and available for download. Test versions of shapefiles are available in the data/raw_data/shape_ouput/ directory

## Author

Iskar J. Waluyo Moreno [waluyo\@usc.edu](mailto:waluyo@usc.edu){.email}

## License

This project is licensed under the [CC0 1.0 Universal](LICENSE.md) Creative Commons License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

Processed data provided by José García. Results published in: https://link.springer.com/chapter/10.1007/978-3-030-98096-2_5
