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

#ac_mapa_maderable$VPM_2016 <- as.numeric(ac_mapa_maderable$VPM_2016)

ac_mapa_maderable$VPM_2016 <- as.numeric(ac_mapa_maderable$VPM_2016)
ac_mapa_maderable@data[is.na(ac_mapa_maderable@data)] <- 0
ac_mapa_agricola@data[is.na(ac_mapa_agricola@data)] <- 0
ac_mapa_ganadera@data[is.na(ac_mapa_ganadera@data)] <- 0
ac_mapa_pob@data[is.na(ac_mapa_pob@data)] <- 0
ac_mapa_psa$sum[is.na(ac_mapa_psa$sum)] <- 0

ac_mapa_maderable$APM_2016 <- as.numeric(ac_mapa_maderable$APM_2016)
ac_mapa_maderable$APNM_2016 <- as.numeric(ac_mapa_maderable$APNM_2016)


# PRESSURE - CALUCLAR % DE COBERTURA CON ACTIVIDAD AGRICOLA
ac_mapa_agricola$SSCPCT_2016 <- 100*(ac_mapa_agricola$SSC_2016/(as.numeric(ac_mapa_agricola$AREA)))

# DRIVERS
# VALUE OF FORESTRY, AGRICULTURE AND LIVESTOCK PRODUCTION

bins_vpm <- c(0, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, Inf)
pal_vpm <- colorBin(palette = colorRamp(c("#f7ffec", "#d2fa97", "#f3facb", "#fff488", "#ff383f"), interpolate="spline"), domain = ac_mapa_maderable$VPM_2016, bins = bins_vpm)

bins_vpnm <- c(0, 2, 10, 50, 250, Inf)
pal_vpnm <- colorBin(palette = colorRamp(c("#f7ffec", "#d2fa97", "#f3facb", "#fff488", "#ff383f"), interpolate="spline"), domain = ac_mapa_maderable$VPNM_2016, bins = bins_vpnm)

bins_vpc <- c(0, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000, 256000, 512000, 1024000, Inf)
pal_vpc <- colorBin(palette = colorRamp(c("#f7ffec", "#d2fa97", "#f3facb", "#fff488", "#ff383f"), interpolate="spline"), domain = ac_mapa_agricola$VPC_2016, bins = bins_vpc)

bins_vpt <- c(0, 100, 500, 2500, 12500, 62500, 312500, Inf)
pal_vpt <- colorBin(palette = colorRamp(c("#f7ffec", "#d2fa97", "#f3facb", "#fff488", "#ff383f"), interpolate="spline"), domain = ac_mapa_ganadera$VPT_2016, bins = bins_vpt)

bins_pob <- c(50, 250, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000, 256000, Inf)
pal_pob <- colorBin(palette = colorRamp(c("#f7ffec", "#d2fa97", "#f3facb", "#fff488", "#ff383f"), interpolate="spline"), domain = ac_mapa_pob$POB_2015, bins = bins_pob)

# PRESSURE
# PERCENTAGE OF SURFACE AREA USED FOR AGRICULTURE AND LIVESTOCK

bins_pct <- c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
pal_pct <- colorBin(palette = "Oranges", bins = bins_pct)

# STATE
# LAND USE COVERAGE

# IMPACT
# APROVECHAMIENTO MADERABLE Y NO MADERABLE

bins_apm <- c(0, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000, Inf)
pal_apm <- colorBin(palette= "Blues", domain = ac_mapa_maderable$APM_2016, bins = bins_apm)

bins_apnm <- c(0, 500, 1000, 2000, Inf)
pal_apnm <- colorBin(palette= "Blues", domain = ac_mapa_maderable$APM_2016, bins = bis_apnm)

# RESPONSE

bins_psa <- c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
pal_psa <- colorBin(palette = "Greens", domain = ac_mapa_psa$PCT_PSA, bins = bins_psa)

# AUTOCORRELACION

pal_autocorr <- colorFactor(c("#e4e4e4", "#ff2500", "#0432ff", "#a6aaff", "#ffa8a6"), 0:4)

# PALETA DE COLORES

pal_reg <- colorFactor("Set1", ac_mapa_regiones$REGION)

pal2 <- colorNumeric(
  palette = "Blues",
  domain = countries$gdp_md_est)

pal <- colorFactor(c("#e4e4e4", "#ff2500", "#0432ff", "#a6aaff", "#ffa8a6"), 0:4)
palb <- colorFactor( palette="Spectral", 1:7)


#pal_0b <- colorBin( palette="Set1", domain = autocorr$LISA_CLdef, bins = bins_autocorr)
#pal_0c <- colorBin( palette="heat", domain = autocorr$LISA_CLdeg, bins = bins_autocorr)

#pal_1 <- colorBin( palette="magma", domain = as.numeric(as.character(ac_mapa_ma@data$X2016)), bins = bins_superficie)
#pal_2 <- colorNumeric( palette= "YlGn", domain=ac_mapa@data$PCT_FORESTAL, na.color="transparent")
#pal_3 <- colorNumeric( palette="YlOrBr", domain=ac_mapa@data$PCT_AGRICOLA, na.color="transparent")
#pal_4 <- colorNumeric( palette="YlOrRd", domain=ac_mapa@data$PCT_PECUARIO, na.color="transparent")

# k-means only works with numerical variables,
# so don't give the user the option to select
# a categorical variable
#vars <- colnames(matriz_correlacion)

# POP-UPS MADERABLE
pop_driver_maderable <- paste0("<b><br/> MUNICIPIO: </b>", ac_mapa$NOMGEO,
                               "<b><br/> SUPERFICIE: </b>", ac_mapa$AREA,
                               "<b><br/> VALOR DE PRODUCCIÓN MADERABLE: </b>", ac_mapa_maderable$VPM_2016)

pop_driver_no_maderable <- paste0("<b><br/> MUNICIPIO: </b>", ac_mapa$NOMGEO,
                                  "<b><br/> SUPERFICIE: </b>", ac_mapa$AREA,
                                  "<b><br/> VALOR DE PRODUCCIÓN MADERABLE: </b>", ac_mapa_maderable$VPNM_2016)

pop_driver_agricola <- paste0("<b><br/> MUNICIPIO: </b>", ac_mapa$NOMGEO,
                              "<b><br/> SUPERFICIE: </b>", ac_mapa$AREA,
                              "<b><br/> VALOR DE PRODUCCIÓN DE CULTIVO PRINCIPAL: </b>", ac_mapa_agricola$VPC_2016)

pop_driver_ganadera <- paste0("<b><br/> MUNICIPIO: </b>", ac_mapa$NOMGEO,
                              "<b><br/> SUPERFICIE: </b>", ac_mapa$AREA,
                              "<b><br/> VALOR DE PRODUCCIÓN DE GANADERA: </b>", ac_mapa_ganadera$VPT_2016,
                              "<b><br/> VOLUMEN DE PRODUCCIÓN GANADERA: </b>", ac_mapa_ganadera$PT_2016)

pop_driver_poblacion <- paste0("<b><br/> MUNICIPIO: </b>", ac_mapa$NOMGEO,
                              "<b><br/> SUPERFICIE: </b>", ac_mapa$AREA,
                              "<b><br/> POBLACIÓN: </b>", ac_mapa_pob$POB_2015)

# POP-UPS PRESSURE

pop_pressure_agricola <- paste0("<b><br/> MUNICIPIO: </b>", ac_mapa$NOMGEO,
                                "<b><br/> SUPERFICIE: </b>", ac_mapa$AREA,
                                "<b><br/> SUPERFICIE SEMBRADA: </b>", ac_mapa_agricola$SSC_2016)

# POP-UPS STATE

pop_state_agricola <- paste0("<b><br/> MUNICIPIO: </b>", ac_mapa$NOMGEO,
                             "<b><br/> SUPERFICIE: </b>", ac_mapa$AREA,
                             "<b><br/> SUPERFICIE SEMBRADA: </b>", ac_mapa_agricola$SSC_2016)

# POP-UPS IMPACT


pop_impact_maderable <- paste0("<b><br/> MUNICIPIO: </b>", ac_mapa$NOMGEO,
                               "<b><br/> SUPERFICIE: </b>", ac_mapa$AREA,
                               "<b><br/> VALOR DE PRODUCCIÓN MADERABLE: </b>", ac_mapa_maderable$VPM_2016)

pop_impact_no_maderable <- paste0("<b><br/> MUNICIPIO: </b>", ac_mapa$NOMGEO,
                                  "<b><br/> SUPERFICIE: </b>", ac_mapa$AREA,
                                  "<b><br/> VALOR DE PRODUCCIÓN NO-MADERABLE: </b>", ac_mapa_maderable$VPNM_2016)

pop_impact_agricola <- paste0("<b><br/> MUNICIPIO: </b>", ac_mapa$NOMGEO,
                                  "<b><br/> SUPERFICIE: </b>", ac_mapa$AREA,
                                  "<b><br/> VALOR DE PRODUCCIÓN AGRÍCOLA: </b>", ac_mapa_agricola$VPC_2016)

pop_impact_ganadera <- paste0("<b><br/> MUNICIPIO: </b>", ac_mapa$NOMGEO,
                                 "<b><br/> SUPERFICIE: </b>", ac_mapa$AREA,
                                 "<b><br/> VALOR DE PRODUCCIÓN GANADERA: </b>", ac_mapa_ganadera$VPT_2016)

# POP-UPS RESPONSE

pop_response <- paste0("<b><br/> MUNICIPIO: </b>", ac_mapa$NOMGEO,
                       "<b><br/> SUPERFICIE: </b>", ac_mapa$AREA,
                       "<b><br/> SUPERFICE ELEGIBLE PARA PSA: </b>", ac_mapa_psa$sum)

# POP-UPS AUTOCORR

pop_psa_autocor <- paste0("<b><br/> MUNICIPIO: </b>", psa_autocor$NOMGEO,
                       "<b><br/> SUPERFICIE CON PSA: </b>", psa_autocor$PCT_PSA,
                       "<b><br/> AUTOCORRELACIÓN PSA: </b>", psa_autocor$CL_PCTPSA)

# AUTOCORRELATION (GEODA) (SOLO JALA CON SF NO SP)

w <- queen_weights(ac_mapa_agricola)
lisa <- local_moran(w, ac_mapa_agricola['VPC_2016'])
