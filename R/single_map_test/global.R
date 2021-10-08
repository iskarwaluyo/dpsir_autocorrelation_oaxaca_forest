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

load(url("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/Rdata/datos.RData"))
load(url("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/Rdata/carto.RData"))
load(url("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/Rdata/autocorrelaciones.RData"))

bins_vpm <- c(0, 2, 10, 50, 250, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000, Inf)
bins_vpnm <- c(0, 2, 10, 50, 250, 500, 1000, 2000, 4000, Inf)
bins_vpc <- c(0, 500, 2500, 12500, 62500, 312500, Inf)
bins_vpt <- c(0, 100, 500, 2500, 12500, 62500, 312500, Inf)
bins_pct <- c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
bins_autocorr <- c(0,1,2,3,4)

# PALETA DE COLORES

pal <- colorFactor(c("white", "red", "blue", "green", "grey"), 0:4)
palb <- colorFactor( palette="Spectral", 1:7)

pal_maderable <- colorBin( palette="viridis", domaster = mun_mapa_maderable$VPM_2016, bins = bins_vpm)
pal_no_maderable <- colorBin( palette="viridis", domaster = mun_mapa_maderable$VPNM_2016, bins = bins_vpnm)
pal_agricola <- colorBin( palette="viridis", domaster = mun_mapa_agricola$VPC_2016, bins = bins_vpc)
pal_ganadera <- colorBin( palette="viridis", domaster = mun_mapa_ganadera$VPT_2016, bins = bins_vpt)

pal_prod_maderable <- colorBin(palette="magma", domaster = mun_mapa_maderable$APM_2016, bins = bins_vpm)
pal_prod_no_maderable <- colorBin(palette="magama", domaster = mun_mapa_maderable$APNM_2016, bins = bins_vpnm)

#pal_0a <- colorBin( palette="Set1", domaster = autocorr$LISA_CL, bins = bins_autocorr)
#pal_0b <- colorBin( palette="Set1", domaster = autocorr$LISA_CLdef, bins = bins_autocorr)
#pal_0c <- colorBin( palette="Set1", domaster = autocorr$LISA_CLdeg, bins = bins_autocorr)

#pal_1 <- colorBin( palette="magma", domaster = as.numeric(as.character(mun_mapa_ma@data$X2016)), bins = bins_superficie)
#pal_2 <- colorNumeric( palette= "YlGn", domaster=mun_mapa@data$PCT_FORESTAL, na.color="transparent")
#pal_3 <- colorNumeric( palette="YlOrBr", domaster=mun_mapa@data$PCT_AGRICOLA, na.color="transparent")
#pal_4 <- colorNumeric( palette="YlOrRd", domaster=mun_mapa@data$PCT_PECUARIO, na.color="transparent")

# k-means only works with numerical variables,
# so don't give the user the option to select
# a categorical variable
#vars <- colnames(matriz_correlacion)

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

# POP-UPS PRESSURE

pop_pressure_agricola <- paste0("<b><br/> MUNICIPIO: </b>", mun_mapa$NOMGEO,
                                "<b><br/> SUPERFICIE: </b>", mun_mapa$AREA,
                                "<b><br/> SUPERFICIE SEMBRADA: </b>", mun_mapa_agricola$SSC_2016)

# POP-UPS STATE

pop_state_agricola <- paste0("<b><br/> MUNICIPIO: </b>", mun_mapa$NOMGEO,
                             "<b><br/> SUPERFICIE: </b>", mun_mapa$AREA,
                             "<b><br/> SUPERFICIE SEMBRADA: </b>", mun_mapa_agricola$SSC_2016)

# POP-UPS IMPACT


pop_impact_maderable <- paste0("<b><br/> MUNICIPIO: </b>", mun_mapa$NOMGEO,
                               "<b><br/> SUPERFICIE: </b>", mun_mapa$AREA,
                               "<b><br/> VALOR DE PRODUCCIÓN MADERABLE: </b>", mun_mapa_maderable$VPM_2016)

pop_impact_no_maderable <- paste0("<b><br/> MUNICIPIO: </b>", mun_mapa$NOMGEO,
                                  "<b><br/> SUPERFICIE: </b>", mun_mapa$AREA,
                                  "<b><br/> VALOR DE PRODUCCIÓN NO-MADERABLE: </b>", mun_mapa_maderable$VPNM_2016)
