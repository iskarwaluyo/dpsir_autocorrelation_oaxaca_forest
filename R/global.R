# CARGAR LIBRERIAS UTILIZADAS DE R
library(data.table)
library(curl)
library(devtools)
library(rio)
library(shiny)
library(shinythemes)
library(DT)
library(leaflet)
library(rgdal)
library(sf)
library(plyr)
library(DBI)
library(dplyr)
library(sf)
library(corrplot)
library(car)
library(ggplot2)
library(curl)
library(geojsonio)
library(reshape2)
library(ggcorrplot)
library(colorspace)
library(revealjs)
library(ggpmisc)
library(magrittr)
library(OneR)
library(jcolors)
library(rgeoda)

load(url("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/Rdata/datos.RData"))
load(url("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/Rdata/carto.RData"))
load(url("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/Rdata/autocorrelaciones.RData"))

# DATA WRANGLING

#mun_mapa_maderable$VPM_2016 <- as.numeric(mun_mapa_maderable$VPM_2016)

mun_mapa_maderable$VPM_2016 <- as.numeric(mun_mapa_maderable$VPM_2016)
mun_mapa_maderable@data[is.na(mun_mapa_maderable@data)] <- 0
mun_mapa_agricola@data[is.na(mun_mapa_agricola@data)] <- 0
mun_mapa_ganadera@data[is.na(mun_mapa_ganadera@data)] <- 0
mun_mapa_pob@data[is.na(mun_mapa_pob@data)] <- 0
#mun_mapa_psa$sum[is.na(mun_mapa_psa$sum)] <- 0
mun_mapa_vegprimaria$PCT_PRIMARIA[is.na(mun_mapa_vegprimaria$PCT_PRIMARIA)] <- 0
mun_mapa_vegsecundaria$PCT_SECUNDARIA[is.na(mun_mapa_vegsecundaria$PCT_SECUNDARIA)] <- 0

mun_mapa_maderable$APM_2016 <- as.numeric(mun_mapa_maderable$APM_2016)
mun_mapa_maderable$APNM_2016 <- as.numeric(mun_mapa_maderable$APNM_2016)


# PRESSURE - CALUCLAR % DE COBERTURA CON ACTIVIDAD AGRICOLA
mun_mapa_agricola$SSCPCT_2016 <- 100*(mun_mapa_agricola$SSC_2016/(as.numeric(mun_mapa_agricola$AREA)))

# DRIVERS
# VALUE OF FORESTRY, AGRICULTURE AND LIVESTOCK PRODUCTION

bins_vpm <- c(0, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, Inf)
pal_vpm <- colorBin(palette = colorRamp(c("#f7ffec", "#d2fa97", "#f3facb", "#fff488", "#ff383f"), interpolate="spline"), domain = mun_mapa_maderable$VPM_2016, bins = bins_vpm)

bins_vpnm <- c(0, 2, 10, 50, 250, Inf)
pal_vpnm <- colorBin(palette = colorRamp(c("#f7ffec", "#d2fa97", "#f3facb", "#fff488", "#ff383f"), interpolate="spline"), domain = mun_mapa_maderable$VPNM_2016, bins = bins_vpnm)

bins_vpc <- c(0, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000, 256000, 512000, 1024000, Inf)
pal_vpc <- colorBin(palette = colorRamp(c("#f7ffec", "#d2fa97", "#f3facb", "#fff488", "#ff383f"), interpolate="spline"), domain = mun_mapa_agricola$VPC_2016, bins = bins_vpc)

bins_vpt <- c(0, 100, 500, 2500, 12500, 62500, 312500, Inf)
pal_vpt <- colorBin(palette = colorRamp(c("#f7ffec", "#d2fa97", "#f3facb", "#fff488", "#ff383f"), interpolate="spline"), domain = mun_mapa_ganadera$VPT_2016, bins = bins_vpt)

bins_pob <- c(50, 250, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000, 256000, Inf)
pal_pob <- colorBin(palette = colorRamp(c("#f7ffec", "#d2fa97", "#f3facb", "#fff488", "#ff383f"), interpolate="spline"), domain = mun_mapa_pob$POB_2015, bins = bins_pob)

# PRESSURE
# PERCENTAGE OF SURFACE AREA USED FOR AGRICULTURE AND LIVESTOCK

bins_pct <- c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
pal_pct <- colorBin(palette = "Oranges", bins = bins_pct)

# STATE
# LAND USE COVERAGE

bins_primveg <- bins_pct
pal_primveg <- colorBin(palette= "Greens", domain = mun_mapa_vegprimaria$PCT_PRIMARIA, bins = bins_primveg)

# IMPACT
# APROVECHAMIENTO MADERABLE Y NO MADERABLE

bins_apm <- c(0, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000, Inf)
pal_apm <- colorBin(palette= "Blues", domain = mun_mapa_maderable$APM_2016, bins = bins_apm)

bins_apnm <- c(0, 500, 1000, 2000, Inf)
pal_apnm <- colorBin(palette= "Blues", domain = mun_mapa_maderable$APM_2016, bins = bins_apnm)

# RESPONSE

bins_psa <- c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
pal_psa <- colorBin(palette = "Purples", domain = mun_mapa_psa$PCT_PSA, bins = bins_psa)

# AUTOCORRELACION

pal_autocorr <- colorFactor(c("#e4e4e4", "#ff2500", "#0432ff", "#a6aaff", "#ffa8a6"), 0:4)

# PALETA DE COLORES

pal_reg <- colorFactor("Set1", mun_mapa_regiones$REGION)

pal <- colorFactor(c("#e4e4e4", "#ff2500", "#0432ff", "#a6aaff", "#ffa8a6"), 0:4)
palb <- colorFactor( palette="Spectral", 1:7)

# POP-UPS MADERABLE
pop_driver_maderable <- paste0("<b><br/> MUNICIPIO: </b>", mun_mapa$NOMGEO,
                               "<b><br/> SUPERFICIE: </b>", mun_mapa$AREA,
                               "<b><br/> VALOR DE PRODUCCIÓN MADERABLE: </b>", mun_mapa_maderable$VPM_2016)

pop_driver_no_maderable <- paste0("<b><br/> MUNICIPIO: </b>", mun_mapa$NOMGEO,
                                  "<b><br/> SUPERFICIE: </b>", mun_mapa$AREA,
                                  "<b><br/> VALOR DE PRODUCCIÓN MADERABLE: </b>", mun_mapa_maderable$VPNM_2016)

pop_driver_agricola <- paste0("<b><br/> MUNICIPIO: </b>", mun_mapa$NOMGEO,
                              "<b><br/> SUPERFICIE: </b>", mun_mapa$AREA,
                              "<b><br/> VALOR DE PRODUCCIÓN DE CULTIVO PRINCIPAL: </b>", mun_mapa_agricola$VPC_2016)

pop_driver_ganadera <- paste0("<b><br/> MUNICIPIO: </b>", mun_mapa$NOMGEO,
                              "<b><br/> SUPERFICIE: </b>", mun_mapa$AREA,
                              "<b><br/> VALOR DE PRODUCCIÓN DE GANADERA: </b>", mun_mapa_ganadera$VPT_2016,
                              "<b><br/> VOLUMEN DE PRODUCCIÓN GANADERA: </b>", mun_mapa_ganadera$PT_2016)

pop_driver_poblacion <- paste0("<b><br/> MUNICIPIO: </b>", mun_mapa$NOMGEO,
                              "<b><br/> SUPERFICIE: </b>", mun_mapa$AREA,
                              "<b><br/> POBLACIÓN: </b>", mun_mapa_pob$POB_2015)

# POP-UPS PRESSURE

pop_pressure_agricola <- paste0("<b><br/> MUNICIPIO: </b>", mun_mapa$NOMGEO,
                                "<b><br/> SUPERFICIE: </b>", mun_mapa$AREA,
                                "<b><br/> SUPERFICIE SEMBRADA: </b>", mun_mapa_agricola$SSC_2016)


# POP-UPS STATE

pop_state_primaria <- paste0("<b><br/> MUNICIPIO: </b>", mun_mapa$NOMGEO,
                             "<b><br/> SUPERFICIE: </b>", mun_mapa$AREA,
                             "<b><br/> SUPERFICIE CON VEGETACIÓN PRIMARIA (HA): </b>", mun_mapa_vegprimaria$AREA_2)

# POP-UPS IMPACT


pop_impact_maderable <- paste0("<b><br/> MUNICIPIO: </b>", mun_mapa$NOMGEO,
                               "<b><br/> SUPERFICIE: </b>", mun_mapa$AREA,
                               "<b><br/> VALOR DE PRODUCCIÓN MADERABLE: </b>", mun_mapa_maderable$VPM_2016)

pop_impact_no_maderable <- paste0("<b><br/> MUNICIPIO: </b>", mun_mapa$NOMGEO,
                                  "<b><br/> SUPERFICIE: </b>", mun_mapa$AREA,
                                  "<b><br/> VALOR DE PRODUCCIÓN NO-MADERABLE: </b>", mun_mapa_maderable$VPNM_2016)

pop_impact_agricola <- paste0("<b><br/> MUNICIPIO: </b>", mun_mapa$NOMGEO,
                                  "<b><br/> SUPERFICIE: </b>", mun_mapa$AREA,
                                  "<b><br/> VALOR DE PRODUCCIÓN AGRÍCOLA: </b>", mun_mapa_agricola$VPC_2016)

pop_impact_ganadera <- paste0("<b><br/> MUNICIPIO: </b>", mun_mapa$NOMGEO,
                                 "<b><br/> SUPERFICIE: </b>", mun_mapa$AREA,
                                 "<b><br/> VALOR DE PRODUCCIÓN GANADERA: </b>", mun_mapa_ganadera$VPT_2016)

# POP-UPS RESPONSE

pop_response <- paste0("<b><br/> MUNICIPIO: </b>", mun_mapa$NOMGEO,
                       "<b><br/> SUPERFICIE: </b>", mun_mapa$AREA,
                       "<b><br/> SUPERFICE ELEGIBLE PARA PSA: </b>", mun_mapa_psa$sum)

# POP-UPS AUTOCORR

pop_psa_autocor <- paste0("<b><br/> MUNICIPIO: </b>", psa_autocor$NOMGEO,
                       "<b><br/> SUPERFICIE CON PSA: </b>", psa_autocor$PCT_PSA,
                       "<b><br/> AUTOCORRELACIÓN PSA: </b>", psa_autocor$CL_PCTPSA)

pop_maderable_autocor <- paste0("<b><br/> MUNICIPIO: </b>", maderable_autocor$NOMGEO,
                          "<b><br/> VALOR PRODUCCIÓN MADERABLE: </b>", mun_mapa_maderable$VPM_2016,
                          "<b><br/> AUTOCORRELACIÓN VALOR PRODUCCIÓN MADERABLE: </b>", maderable_autocor$CL_VPM)

pop_maderable_autocor <- paste0("<b><br/> MUNICIPIO: </b>", maderable_autocor$NOMGEO,
                                "<b><br/> VALOR PRODUCCIÓN NO MADERABLE: </b>", mun_mapa_maderable$VPNM_2016,
                                "<b><br/> AUTOCORRELACIÓN VALOR PRODUCCIÓN NO MADERABLE: </b>", maderable_autocor$CL_VPNM)

pop_agricultura_autocor <- paste0("<b><br/> MUNICIPIO: </b>", agricola_autocor$NOMGEO,
                                "<b><br/> VALOR PRODUCCIÓN AGRÍCOLA: </b>", agricola_autocor$VPC_2016,
                                "<b><br/> AUTOCORRELACIÓN VALOR PRODUCCIÓN AGRÍCOLA: </b>", agricola_autocor$CL_VPV2016)


pop_ganaderia_autocor <- paste0("<b><br/> MUNICIPIO: </b>", agricola_autocor$NOMGEO,
                               "<b><br/> VALOR PRODUCCIÓN GANADERA: </b>", ganadera_autocor$VPT_2016,
                               "<b><br/> AUTOCORRELACIÓN VALOR PRODUCCIÓN GANADERA: </b>", ganadera_autocor$CL_VPT2016)

pop_poblacion_autocor <-  paste0("<b><br/> MUNICIPIO: </b>", agricola_autocor$NOMGEO,
                                 "<b><br/> VALOR PRODUCCIÓN GANADERA: </b>", pob_autocor$POB_2015,
                                 "<b><br/> AUTOCORRELACIÓN VALOR PRODUCCIÓN GANADERA: </b>", pob_autocor$CL_POB2015)

pop_superficiesembrada_autocor <- paste0("<b><br/> MUNICIPIO: </b>", agricola_autocor$NOMGEO,
                                         "<b><br/> SUPERFICIE SEMBRADA (%): </b>", agricola_autocor$SSCPCT_,
                                         "<b><br/> AUTOCORRELACIÓN DE LA SUPERFICIE SEMBRADA: </b>", agricola_autocor$CL_SSCPCT)

pop_aprovechamientomaderable_autocor <- paste0("<b><br/> MUNICIPIO: </b>", agricola_autocor$NOMGEO,
                                         "<b><br/> APROVECHAMIENTO MADERABLE (): </b>", mun_mapa_maderable$APM_2016,
                                         "<b><br/> AUTOCORRELACIÓN DEL APROVECHAMIENTO MADERABLE: </b>", maderable_autocor$CL_APM)

pop_aprovechamientonomaderable_autocor <- paste0("<b><br/> MUNICIPIO: </b>", agricola_autocor$NOMGEO,
                                                 "<b><br/> APROVECHAMIENTO NO MADERABLE (): </b>", mun_mapa_maderable$APNM_2016,
                                                 "<b><br/> AUTOCORRELACIÓN DEL APROVECHAMIENTO NO MADERABLE: </b>", maderable_autocor$CL_APNM)

pop_produccionagricola_autocor <- paste0("<b><br/> MUNICIPIO: </b>", agricola_autocor$NOMGEO,
                                                 "<b><br/> PRODUCCIÓN AGRÍCOLA (): </b>", agricola_autocor$VPC_2016,
                                                 "<b><br/> AUTOCORRELACIÓN DE LA PRODUCCIÓN AGRÍCOLA: </b>", agricola_autocor$CL_VPV2016)

pop_produccionganadera_autocor <- paste0("<b><br/> MUNICIPIO: </b>", agricola_autocor$NOMGEO,
                                                 "<b><br/> PRODUCCIÓN AGRÍCOLA (): </b>", ganadera_autocor$VPT_2016,
                                                 "<b><br/> AUTOCORRELACIÓN DE LA PRODUCCIÓN AGRÍCOLA: </b>", ganadera_autocor$CL_VPT2016)

# AUTOCORRELATION (GEODA) (SOLO JALA CON SF NO SP)

#w <- queen_weights(ac_mapa_agricola)
#lisa <- local_moran(w, ac_mapa_agricola['VPC_2016'])
