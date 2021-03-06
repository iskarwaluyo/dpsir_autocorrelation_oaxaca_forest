m4 <- leaflet(mun_mapa) %>%
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


m4 <- m4 %>%  addPolygons(data = mun_mapa_psa, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "B"),
                          fillOpacity = .7,
                          fillColor = ~pal_psa(PCT_PSA),
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
                          group = "PAGOS PSA",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"),
                          popup = ~pop_response)

m4 <- m4 %>%  addPolygons(data = psa_autocor, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "A"),
                          fillOpacity = 1,
                          fillColor = ~pal_autocorr(CL_PCTPSA),
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
                          group = "AUTOCORRELACIÓN PSA",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"),
                          popup = ~pop_psa_autocor)

# CONTROL DE CAPAS
m4 <- m4 %>% addLayersControl(
  baseGroups = c("Open Street Map", "Toner", "Toner Lite"),
  overlayGroups = c("PAGOS PSA", "AUTOCORRELACIÓN PSA"),
  options = layersControlOptions(collapsed = FALSE)
)

m4

addLegend(m4, "topleft", group = "PAGOS PSA", pal = pal_psa, values = mun_mapa_psa$PCT_PSA, opacity = 1.0, title = "Total area with payments <br/> for ecosystem services (%)")
addLegend(m4, "topleft", group = "AUTOCORRELACIÓN PSA", pal = pal_autocorr, values = psa_autocor$CL_PCTPSA, opacity = 1.0, title = "Payments for ecosystem services <br/> Autocorrelation")

