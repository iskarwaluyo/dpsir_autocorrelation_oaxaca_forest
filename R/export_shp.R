
setwd("/media/iskar/archivos/MAPAS/mapasR/dpsir_autocorrelation_oaxaca_forest/data/raw_data/shape_ouput/agricola/")
writeOGR(ac_mapa_agricola, dsn = '.', layer = 'mapa_agricola', driver = "ESRI Shapefile")

setwd("/media/iskar/archivos/MAPAS/mapasR/dpsir_autocorrelation_oaxaca_forest/data/raw_data/shape_ouput/ganadera/")
writeOGR(ac_mapa_ganadera, dsn = '.', layer = 'mapa_ganadera', driver = "ESRI Shapefile")

setwd("/media/iskar/archivos/MAPAS/mapasR/dpsir_autocorrelation_oaxaca_forest/data/raw_data/shape_ouput/maderable/")
writeOGR(ac_mapa_maderable, dsn = '.', layer = 'mapa_maderable', driver = "ESRI Shapefile")

setwd("/media/iskar/archivos/MAPAS/mapasR/dpsir_autocorrelation_oaxaca_forest/data/raw_data/shape_ouput/psa/")
writeOGR(ac_mapa_psa, dsn = '.', layer = 'mapa_psa', driver = "ESRI Shapefile")

setwd("/media/iskar/archivos/MAPAS/mapasR/dpsir_autocorrelation_oaxaca_forest/data/raw_data/shape_ouput/pob/")
writeOGR(ac_mapa_pob, dsn = '.', layer = 'mapa_pob', driver = "ESRI Shapefile")

