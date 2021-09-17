m2 <- leaflet(mun_mapa) %>%
  addMapPane("A", zIndex = 490) %>% #
  addMapPane("B", zIndex = 480) %>% # 
  addMapPane("C", zIndex = 470) %>% # 
  addMapPane("D", zIndex = 460) %>% # 
  
  addTiles() %>%
  addTiles(group = "Open Street Map") %>%
  addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
  addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") %>%
  addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = .2,
              fillColor = ~pal(as.numeric(NOMGEO)),
              label = ~paste0(NOMGEO, ": ", formatC(NOMGEO, big.mark = ","))) 

m2 <- m2 %>%  addPolygons(data = mun_mapa_vegprimaria, stroke = FALSE, smoothFactor = 0.3,
                          options = pathOptions(pane = "A"),
                          fillOpacity = .7,
                          fillColor = ~pal_primveg(AREA_2),
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
                          group = "VEGETACIÓN PRIMARIA",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"),
                          popup = ~pop_state_primaria)

m2 <- m2 %>%  addPolygons(data = mun_mapa_vegprimaria, stroke = FALSE, smoothFactor = 0.3,
                          options = pathOptions(pane = "A"),
                          fillOpacity = .7,
                          fillColor = ~pal_psa(PCT_PRIMARIA),
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
                          group = "VEGETACIÓN PRIMARIA",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"),
                          popup = ~pop_state_primaria)

m2 <- m2 %>%  addPolygons(data = mun_mapa_vegsecundaria, stroke = FALSE, smoothFactor = 0.3,
                          options = pathOptions(pane = "B"),
                          fillOpacity = .7,
                          fillColor = ~pal_psa(PCT_SECUNDARIA),
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
                          group = "VEGETACIÓN SECUNDARIA",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"),
                          popup = ~pop_state_primaria)

# CONTROL DE CAPAS
m2 <- m2 %>% addLayersControl(
  baseGroups = c("Open Street Map", "Toner", "Toner Lite"),
  overlayGroups = c("VEGETACIÓN PRIMARIA", "VEGETACIÓN SECUNDARIA"),
  options = layersControlOptions(collapsed = FALSE)
)

m2
