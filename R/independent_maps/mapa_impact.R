m3 <- leaflet(ac_mapa) %>%
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

m3 <- m3 %>%  addPolygons(data = ac_mapa_maderable, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "A"),
                          fillOpacity = 1,
                          fillColor = ~pal_apm(as.numeric(APM_2016)),
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
                          group = "APROVECHAMIENTO MADERABLE",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"),
                          popup = ~pop_impact_maderable)

m3 <- m3 %>%  addPolygons(data = ac_mapa_maderable, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "B"),
                          fillOpacity = 1,
                          fillColor = ~pal_apnm(as.numeric(APNM_2016)),
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
                          group = "APROVECHAMIENTO NO MADERABLE",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"),
                          popup = ~pop_impact_maderable)

m3 <- m3 %>%  addPolygons(data = ac_mapa_agricola, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "C"),
                          fillOpacity = 1,
                          fillColor = ~pal_vpc(as.numeric(VPC_2016)),
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
                          group = "VOLUMEN AGRÍCOLA",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"),
                          popup = ~pop_impact_agricola)


m3 <- m3 %>%  addPolygons(data = ac_mapa_ganadera, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "D"),
                          fillOpacity = 1,
                          fillColor = ~pal_vpt(as.numeric(PT_2016)),
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
                          group = "VOLUMEN GANADERÍA",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"),
                          popup = ~pop_impact_ganadera)

# CONTROL DE CAPAS
m3 <- m3 %>% addLayersControl(
  baseGroups = c("Open Street Map", "Toner", "Toner Lite"),
  overlayGroups = c("APROVECHAMIENTO MADERABLE", "APROVECHAMIENTO NO MADERABLE", "VOLUMEN AGRÍCOLA", "VOLUMEN GANADERÍA"),
  options = layersControlOptions(collapsed = FALSE)
)

m3  

addLegend(m3, "topleft", group = "APROVECHAMIENTO MADERABLE", pal = pal_apm, values = ac_mapa_maderable$APM_2016, opacity = 1.0, title = "Timber forest production <br/> (cubic meters)")
addLegend(m3, "topleft", group = "APROVECHAMIENTO NO MADERABLE", pal = pal_apnm, values = ac_mapa_maderable$APNM_2016, opacity = 1.0, title = "Non timber forest production <br/> (tons)")
addLegend(m3, "topleft", group = "VOLUMEN AGRÍCOLA", pal = pal_vpc, values = as.numeric(ac_mapa_agricola$VPC_2016), opacity = 1.0, title = "Non timber forest production <br/> (tons)")
addLegend(m3, "topleft", group = "VOLUMEN GANADERÍA", pal = pal_vpc, values = as.numeric(ac_mapa_agricola$VPC_2016), opacity = 1.0, title = "Non timber forest production <br/> (tons)")

