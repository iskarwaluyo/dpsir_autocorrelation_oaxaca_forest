m5 <- leaflet(mun_mapa) %>%
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

m5 <- m5 %>%  addPolygons(data = mun_mapa_autocorr, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "A"),
                          fillOpacity = 1,
                          fillColor = ~pal(VPM_LISA_CL),
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
                          group = "PROD MADERABLE",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"))

m5 <- m5 %>%  addPolygons(data = mun_mapa_autocorr, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "B"),
                          fillOpacity = 1,
                          fillColor = ~pal(VPNM_LISA_CL),
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
                          group = "PROD NO MADERABLE",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"))

m5 <- m5 %>%  addPolygons(data = mun_mapa_autocorr, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "C"),
                          fillOpacity = 1,
                          fillColor = ~pal(VPC_LISA_CL),
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
                          group = "PROD AGRÍCOLA",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"))

m5 <- m5 %>%  addPolygons(data = mun_mapa_autocorr, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "D"),
                          fillOpacity = 1,
                          fillColor = ~pal(VPT_LISA_CL),
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
                          group = "PROD GANADERA",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"))


# CONTROL DE CAPAS
m5 <- m5 %>% addLayersControl(
  baseGroups = c("Open Street Map", "Toner", "Toner Lite"),
  overlayGroups = c("PROD MADERABLE","PROD NO MADERABLE", "PROD AGRÍCOLA", "PROD GANADERA"),
  options = layersControlOptions(collapsed = FALSE)
)

m5

addLegend(m5, "topleft", group = "PROD MADERABLE", pal = pal, values = mun_mapa_autocorr$VPM_LISA_CL, opacity = 1.0, title = "Timber forest production <br/> Autocorrelation")
addLegend(m5, "topleft", group = "PROD NO MADERABLE", pal = pal, values = mun_mapa_autocorr$VPNM_LISA_CL, opacity = 1.0, title = "Non timber forest production <br/> Autocorrelation")
addLegend(m5, "topleft", group = "PROD AGRÍCOLA", pal = pal, values = mun_mapa_autocorr$VPC_LISA_CL, opacity = 1.0, title = "Non timber forest production <br/> Autocorrelation")
addLegend(m5, "topleft", group = "PROD GANADERA", pal = pal, values = mun_mapa_autocorr$VPT_LISA_CL, opacity = 1.0, title = "Non timber forest production <br/> Autocorrelation")

