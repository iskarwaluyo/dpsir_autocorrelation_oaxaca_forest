m1 <- leaflet(mun_mapa) %>%
  addMapPane("A", zIndex = 490) %>% #
  addMapPane("B", zIndex = 480) %>% # 
  addMapPane("C", zIndex = 470) %>% # 
  addMapPane("D", zIndex = 460) %>% # 
  
  addTiles() %>%
  addTiles(group = "Open Street Map") %>%
  addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
  addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") %>%
  addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = .2,
              fillColor = ~pal(as.numeric(CVE_MUN)),
              label = ~paste0(NOMGEO, ": ", formatC(NOMGEO, big.mark = ",")))

m1 <- m1 %>%  addPolygons(data = mun_mapa_agricola, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "A"),
                          fillOpacity = .7,
                          fillColor = ~pal_pct(SSCPCT_2016),
                          opacity = .3,
                          weight = 1,
                          color = "#4D4D4D",
                          dashArray = "2",
                          highlight = highlightOptions(
                            weight = 1,
                            color = "#4D4D4D",
                            fillOpacity = 0.1,
                            dashArray = "2",
                            bringToFront = TRUE),
                          group = "SUPERFICIE SEMBRADA",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"),
                          popup = ~pop_pressure_agricola)

m1 <- m1 %>%  addPolygons(data = agricola_autocor, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "D"),
                          fillOpacity = 1,
                          fillColor = ~pal_autocorr(CL_SSCPCT),
                          opacity = .3,
                          weight = 1,
                          color = "#4D4D4D",
                          dashArray = "2",
                          highlight = highlightOptions(
                            weight = 1,
                            color = "#4D4D4D",
                            fillOpacity = 0.1,
                            dashArray = "2",
                            bringToFront = TRUE),
                          group = "AUTOCORRELACIÓN SUPERFICIE SEMBRADA",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"),
                          popup = ~pop_superficiesembrada_autocor)

# CONTROL DE CAPAS
m1 <- m1 %>% addLayersControl(
  baseGroups = c("Open Street Map", "Toner", "Toner Lite"),
  overlayGroups = c("SUPERFICIE SEMBRADA", "AUTOCORRELACIÓN SUPERFICIE SEMBRADA"),
  options = layersControlOptions(collapsed = FALSE)
)

m1

addLegend(m1, "topleft", group = "SUPERFICIE SEMBRADA", pal = pal_pct, values = mun_mapa_agricola$SSCPCT_2016, opacity = 1.0, title = "Area with agricultural activity <br/> (%)")
addLegend(m1, "topleft", group = "AUTOCORRELACIÓN SUPERFICIE SEMBRADA", pal = pal_autocorr, values = c(0:4), opacity = 1.0, title = "Area with agricultural activity autocorrelation")

