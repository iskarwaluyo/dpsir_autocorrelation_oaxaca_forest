library(rio)
library(sf)
library(rmapshaper)
library(plyr)
library(rgdal)

# LECTURA DE DATOS ALMACENADOS EN GITHUB

# LECTURA DE GEOJSON COMO UN SP (SPATIAL POLYGON DATA FRAME)
mun_mapa <- readOGR("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/geojson/oax_mun.geojson")
mun_mapa_psa <- readOGR("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/geojson/oax_psa.geojson")
mun_mapa_regiones <- readOGR("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/geojson/oax_regiones.geojson")
mun_mapa_usv <- readOGR("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/geojson/oax_usv_mun.geojson")

psa_autocor <- readOGR("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/geojson/mun_auto_psa.geojson")
agricola_autocor <- readOGR("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/geojson/mun_auto_agricola.geojson")
ganadera_autocor <- readOGR("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/geojson/mun_auto_ganadera.geojson")
pob_autocor <- readOGR("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/geojson/mun_auto_pob.geojson")
maderable_autocor <- readOGR("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/geojson/mun_auto_maderable.geojson")
vegprim_autocor <- readOGR("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/geojson/mun_auto_vegpri.geojson")
vegsecu_autocor <- readOGR("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/geojson/mun_auto_vegsec.geojson")



# LECTURA DE GEOJSON COMO UN SF (SIMPLE FEATURES)
mun_mapa_sf <- st_read("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/geojson/oax_mun.geojson")


# LECTURA DE INDICADORES DE LA PRODUCCIÓN MADERABLE Y NO MADERABLE DE GITHUB
# FUENTE: ACTUALIZACIÓN DEL MARCO SENSAL AGROPECUARIO 2016

apm <- import("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/csv/maderable/apm.csv")
apnm <- import("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/csv/maderable/apnm.csv")
pm <- import("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/csv/maderable/pm.csv")
pnm <- import("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/csv/maderable/pnm.csv")
vpm <- import("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/csv/maderable/vpm.csv")
vpnm <- import("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/csv/maderable/vpnm.csv")

# DATA WRANGLING

# CONVERTIR TODOS LOS ENCABEZADOS A MAYUSCULAS
colnames(apm) <- toupper(colnames(apm)) 
colnames(apnm) <- toupper(colnames(apnm))
colnames(pm) <- toupper(colnames(pm))
colnames(pnm) <- toupper(colnames(pnm))
colnames(vpm) <- toupper(colnames(vpm))
colnames(vpnm) <- toupper(colnames(vpnm))

datos_maderable <- cbind(apm, apnm, pm, pnm, vpm, vpnm)

datos_maderable <- datos_maderable[,-2]

mun_mapa <- ms_simplify(mun_mapa, keep = 0.05)
mun_mapa_regiones <- ms_simplify(mun_mapa_regiones, keep = 0.05)


mun_mapa_maderable <- merge(mun_mapa, datos_maderable, by = "CVEGEO", all.x = TRUE, all.y = TRUE)

# LECTURA DE INDICADORES DE LA PRODUCCIÓN AGRICOLA DE GITHUB
# FUENTE: ACTUALIZACIÓN DEL MARCO SENSAL AGROPECUARIO 2016

scc <- import("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/csv/agricola/scc.csv")
ssc <- import("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/csv/agricola/ssc.csv")
vpc <- import("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/csv/agricola/vpc.csv")
sct <- import("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/csv/agricola/sct.csv")
ssr <- import("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/csv/agricola/ssr.csv")
sst <- import("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/csv/agricola/sst.csv")

# CONVERTIR TODOS LOS ENCABEZADOS A MAYUSCULAS
colnames(scc) <- toupper(colnames(scc)) 
colnames(ssc) <- toupper(colnames(ssc))
colnames(vpc) <- toupper(colnames(vpc))
colnames(ssr) <- toupper(colnames(ssr))
colnames(sst) <- toupper(colnames(sst))

datos_agricola <- cbind(scc, ssc, vpc, ssr, sst)

datos_agricola <- datos_agricola[,-2]

mun_mapa_agricola <- merge(mun_mapa, datos_agricola, by = "CVEGEO", all.x = TRUE, all.y = TRUE)

# LECTURA DE INDICADORES DE LA PRODUCCIÓN GANADERA DE GITHUB
# FUENTE: ACTUALIZACIÓN DEL MARCO SENSAL AGROPECUARIO 2016

pt <- import("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/csv/ganadera/pt.csv")
vpt <- import("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/csv/ganadera/vpt.csv")

# CONVERTIR TODOS LOS ENCABEZADOS A MAYUSCULAS
colnames(pt) <- toupper(colnames(pt)) 
colnames(vpt) <- toupper(colnames(vpt))

datos_ganadera <- cbind(pt, vpt)

datos_ganadera <- datos_ganadera[,-2]

mun_mapa_ganadera <- merge(mun_mapa, datos_ganadera, by = "CVEGEO", all.x = TRUE, all.y = TRUE)

# LECTURA DE DATOS SOBRE LA POBLACIÓN

pob <- import("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/csv/pob.csv")

# CONVERTIR TODOS LOS ENCABEZADOS A MAYUSCULAS
colnames(pob) <- toupper(colnames(pob)) 

datos_pob <- cbind(pob)

mun_mapa_pob <- merge(mun_mapa, datos_pob, by = "CVEGEO", all.x = TRUE, all.y = TRUE)

# LECTURA DE DATOS SOBRE LOS PAGOS DE SERVICIOS AMBIENTALES
# FUENTE: CONAFOR (2018)

psa <- mun_mapa_psa@data

# CONVERTIR TODOS LOS ENCABEZADOS A MAYUSCULAS
colnames(psa) <- toupper(colnames(psa)) 

psa_x <- ddply(psa, .(CVE_MUN), summarise, SUMA_PSA = sum(SUP_MUN_ZE))

mun_mapa_psa <- merge(mun_mapa, psa_x, by.x = "CVEGEO", by.y = "CVE_MUN", all.x = TRUE, all.y = TRUE)
mun_mapa_psa@data[is.na(mun_mapa_psa@data)] <- 0

mun_mapa_psa$PCT_PSA <- 100*(mun_mapa_psa$SUMA_PSA/as.numeric(mun_mapa_psa$AREA))

# STATE


mun_mapa_vegprimaria <- mun_mapa_usv[grep('^BOSQUE|^SELVA|MANGLAR|TULAR', 
                                             mun_mapa_usv@data$DESCRIPCIO,),]

mun_mapa_vegsecundaria <- mun_mapa_usv[grep('^VEGETACIÓN|CHAPARRAL|SABANOIDE', 
                                              mun_mapa_usv@data$DESCRIPCIO,),]

sum_vegprimria <- ddply (mun_mapa_vegprimaria@data, "CVE_MUN", 
                           summarise, VEG_PRIM_SUM = sum(AREA_2))

sum_vegsecundaria <- ddply (mun_mapa_vegsecundaria@data, "CVE_MUN", 
                         summarise, VEG_SECA_SUM = sum(AREA_2))

mun_mapa_vegprimaria <- merge(mun_mapa, sum_vegprimria, by = "CVE_MUN", all.y=TRUE, all.x = TRUE)

mun_mapa_vegsecundaria <- merge(mun_mapa, sum_vegsecundaria, by = "CVE_MUN", all.y=TRUE, all.x = TRUE)

mun_mapa_vegprimaria$PCT_PRIMARIA <- 100*as.numeric(mun_mapa_vegprimaria$AREA)/mun_mapa_vegprimaria$VEG_PRIM_SUM

mun_mapa_vegsecundaria$PCT_SECUNDARIA <- 100*as.numeric(mun_mapa_vegsecundaria$AREA)/mun_mapa_vegsecundaria$VEG_SECA_SUM



# DATOS DE AUTOCORRELACIONES
# FUENTE: ELABORACIÓN PROPIA CON SOFTWARE GEODA

autocorr1 <- import("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/data/raw_data/csv/autocorr_2016.csv")

mun_mapa_autocorr <- merge(mun_mapa, autocorr1, by = "CVEGEO", all.x = TRUE, all.y = TRUE)


# CREAR ARCHIVOS TIPO RData PARA ALMACENAR LOS RESULTADOS DEL PROCESAMIENTO DE LOS DATOS
setwd("/media/iskar/archivos/MAPAS/mapasR/dpsir_autocorrelation_oaxaca_forest/data/Rdata/")

save(mun_mapa, mun_mapa_maderable, mun_mapa_agricola, mun_mapa_ganadera, mun_mapa_autocorr, 
     mun_mapa_pob, mun_mapa_psa, mun_mapa_regiones, psa_autocor, agricola_autocor, maderable_autocor,
     ganadera_autocor, pob_autocor, mun_mapa_vegprimaria, mun_mapa_vegsecundaria, 
     vegprim_autocor, vegsecu_autocor, file = "carto.RData")

save(m0, m1, m2, m3, m4, file = "thematic_maps.RData")

save(apm, apnm, pm, pnm, vpm, vpnm, scc, ssc, vpc, ssr, sst, pt, vpt, pob, psa, autocorr1, 
     datos_maderable, datos_ganadera, datos_agricola, datos_pob, file = "datos.RData")

save(autocorr1, file = "autocorrelaciones.RData")

# REGRESAR AL ENTORNO GENERAL LOCAL
setwd("/media/iskar/archivos/MAPAS/mapasR/dpsir_autocorrelation_oaxaca_forest")
