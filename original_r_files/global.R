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


load(url("https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/data/Rdata/carto.RData"))
load(url("https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/data/Rdata/concentrados.RData"))
load(url("https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/data/Rdata/comparados.RData"))
load(url("https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/data/Rdata/correlaciones.RData"))
load(url("https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/data/Rdata/datos.RData"))
load(url("https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/data/Rdata/autocorrelaciones.RData"))
load(url("https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/data/Rdata/cambios.RData"))

bins_terrenos_tot <- c(0, 10, 20, 50, 100, 150, 200, Inf)
bins_series <- c(1, 2, 3, 4, 5, 6, 7)
bins_cambios <- c(1:42)
bins_pct <- c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
bins_autocorr <- c(0,1,2,3,4)

# PALETA DE COLORES

pal <- colorFactor(c("white", "red", "blue", "green", "grey"), 0:4)
palb <- colorFactor( palette="Spectral", 1:7)

pal_0 <- colorBin( palette="viridis", domain = ac_mapa_mc$TERRENOS, bins = bins_terrenos_tot)
  
pal_0a <- colorBin( palette="Set1", domain = autocorr$LISA_CL, bins = bins_autocorr)
pal_0b <- colorBin( palette="Set1", domain = autocorr$LISA_CLdef, bins = bins_autocorr)
pal_0c <- colorBin( palette="Set1", domain = autocorr$LISA_CLdeg, bins = bins_autocorr)

pal_1 <- colorBin( palette="magma", domain = as.numeric(as.character(ac_mapa@data$TERRENOS)), bins = bins_terrenos_tot)
pal_2 <- colorNumeric( palette= "YlGn", domain=ac_mapa@data$PCT_FORESTAL, na.color="transparent")
pal_3 <- colorNumeric( palette="YlOrBr", domain=ac_mapa@data$PCT_AGRICOLA, na.color="transparent")
pal_4 <- colorNumeric( palette="YlOrRd", domain=ac_mapa@data$PCT_PECUARIO, na.color="transparent")
pal_5 <- colorFactor( palette="Spectral", domain = serie_3@data$Clase)
pal_6 <- colorFactor( palette="Spectral", domain = serie_6@data$Clase)
pal_7 <- colorBin( palette="YlOrRd", domain = as.numeric(as.character(cambios_usv_ac@data$X._PVP)), bins = bins_pct) 
pal_8 <- colorFactor( palette="Spectral", domain = cambios_usv@data$tipo_cambi)
pal_9 <- colorBin( palette="YlOrRd", domain = as.numeric(as.character(autocorr_ac@data$P_AT_AT_S)), bins = bins_pct) 

# k-means only works with numerical variables,
# so don't give the user the option to select
# a categorical variable
vars <- colnames(matriz_correlacion)

# POP UPS

pop_terrenos <- paste0("<b><br/> Área de control: </b>", ac_mapa_mc$CONTROL,
                       "<b><br/> Terrenos totales: </b>", ac_mapa_mc$TERRENOS,
                       "<b><br/> Superficie total: </b>", ac_mapa_mc$SUP_TOTAL, " ha",
                       "<b><br/> Tamaño promedio de terreno agrícola: </b>", as.character(round(as.numeric(ac_mapa_mc$TERRENO_PROMEDIO_16), 2)), " ha",
                       "<b><br/> Terrenos agrícolas: </b>", as.character(round(as.numeric(ac_mapa_mc$NUM_TERR_16), 2)), " Terrenos",
                       "<b><br/> Terrenos pecuarios: </b>", as.character(round(as.numeric(ac_mapa_mc$P_TOTAL), 2)), " Terrenos",
                       "<b><br/> Terrenos forestales: </b>", as.character(round(as.numeric(ac_mapa_mc$F_TOTAL), 2)), " Terrenos")

pop_agricola <- paste0("<b><br/> Terrenos totales: </b>", as.character(ac_mapa_mc$TERRENOS),
                       "<b><br/> Superficie total: </b>", as.character(ac_mapa_mc$SUP_TOTAL), "ha",
                       "<b><br/> Terrenos agrícolas: </b>", as.character(round(as.numeric(ac_mapa_mc$PCT_AGRICOLA), 2)), "%",
                       "<b><br/> Superficie sembrada 2007: </b>", as.character(round(as.numeric(ac_mapa_mc$`SUPERFICIE_SEMBRADA_%_07`), 2)), "%",
                       "<b><br/> Superficie sembrada 2016: </b>", as.character(round(as.numeric(ac_mapa_mc$`SUPERFICIE_SEBRADA_%_16`), 2), "%"))

pop_forestal <- paste0("<b><br/> Terrenos totales: </b>", as.character(ac_mapa_mc$TERRENOS),
                       "<b><br/> Superficie total: </b>", as.character(ac_mapa_mc$SUP_TOTAL), "ha",
                       "<b><br/> Terrenos forestales: </b>", as.character(round(as.numeric(ac_mapa_mc$PCT_FORESTAL), 2)), "%")

pop_pecuario <- paste0("<b><br/> Terrenos totales: </b>", as.character(ac_mapa_mc$TERRENOS),
                       "<b><br/> Superficie total: </b>", as.character(ac_mapa_mc$SUP_TOTAL), "ha",
                       "<b><br/> Terrenos pecuarios: </b>", as.character(round(as.numeric(ac_mapa_mc$PCT_PECUARIO), 2)), "%")

pop_cambios <- paste0("<b><br/> Área de control: </b>", ac_mapa_mc$CONTROL,
                      "<b><br/> Vegetación conservada: </b>", round(cambios_usv_ac$X._CV, 2), " %",
                      "<b><br/> Ganancia de vegetación primaria: </b>", round(cambios_usv_ac$X._GVP, 2), " %",
                      "<b><br/> Ganancia de vegetación secundaria: </b>", round(cambios_usv_ac$X._GVS, 2), " %",
                      "<b><br/> Actividad antrópica sin cambio: </b>", round(cambios_usv_ac$X._AASC, 2), " %",
                      "<b><br/> Ganancia de actividad agrícola: </b>", round(cambios_usv_ac$X._AAP, 2), " %",
                      "<b><br/> Pérdida de vegetación primaria: </b>", round(cambios_usv_ac$X._PVP, 2), " %",
                      "<b><br/> Pérdida de vegetación secundaria: </b>", round(cambios_usv_ac$X._PVS, 2), " %",
                      "<b><br/> Urbanización: </b>", cambios_usv_ac$X._Urb, " %")

pop_autocorr <- paste0("<b><br/> Área de control: </b>", ac_mapa_mc$CONTROL,
                      "<b><br/> Altas/Altas pérdidas de vegetación: </b>", round(autocorr_ac$P_AT_AT_S, 2), " %",
                      "<b><br/> Altas/Bajas pérdidas de vegetación: </b>", round(autocorr_ac$P_AT_BJ_S, 2), " %",
                      "<b><br/> Bajas/Bajas pérdidas de vegetación: </b>", round(autocorr_ac$P_BJ_BJ_S, 2), " %",
                      "<b><br/> Bajas/Altas pérdidas de vegetación: </b>", round(autocorr_ac$P_BJ_AT_S, 2), " %")
