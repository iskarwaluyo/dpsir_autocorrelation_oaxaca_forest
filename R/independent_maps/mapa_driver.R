m0 <- leaflet(mun_mapa) %>%
  addMapPane("AA", zIndex = 500) %>% #
  addMapPane("A", zIndex = 490) %>% #
  addMapPane("B", zIndex = 480) %>% # 
  addMapPane("C", zIndex = 470) %>% # 
  addMapPane("D", zIndex = 460) %>% # 
  addMapPane("E", zIndex = 450) %>% # 
  
  
  addTiles() %>%
  addTiles(group = "Open Street Map") %>%
  addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
  addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") %>%
  addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = .2,
              fillColor = ~pal(as.numeric(CVE_MUN)),
              label = ~paste0(NOMGEO, ": ", formatC(NOMGEO, big.mark = ","))) 


m0 <- m0 %>%  addPolygons(data = mun_mapa_regiones, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "AA"),
                          fillOpacity = .6,
                          fillColor = "transparent",
                          opacity = .5,
                          weight = 5,
                          color = ~pal_reg(REGION),
                          dashArray = "2",
                          highlight = highlightOptions(
                            weight = 1,
                            color = "#4D4D4D",
                            fillOpacity = 0.1,
                            dashArray = "2",
                            bringToFront = TRUE),
                          group = "REGIONES",
                          
                          addLabelOnlyMarkers(data = centers,
                                              lng = ~x, lat = ~y, label = ~region,
                                              labelOptions = labelOptions(noHide = TRUE, direction = 'top', textOnly = TRUE)) %>%
                          
                          
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"))

m0 <- m0 %>%  addPolygons(data = mun_mapa_maderable, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "A"),
                          fillOpacity = 1,
                          fillColor = ~pal_vpm(VPM_2016),
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
                          group = "MADERABLE",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"),
                          popup = ~pop_driver_maderable)

m0 <- m0 %>%  addPolygons(data = mun_mapa_maderable, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "B"),
                          fillOpacity = 1,
                          fillColor = ~pal_vpnm(VPNM_2016),
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
                          group = "NO MADERABLE",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"),
                          popup = ~pop_driver_no_maderable)

m0 <- m0 %>%  addPolygons(data = mun_mapa_agricola, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "C"),
                          fillOpacity = 1,
                          fillColor = ~pal_vpc(VPC_2016),
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
                          group = "AGRÍCOLA",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"),
                          popup = ~pop_driver_agricola)

m0 <- m0 %>%  addPolygons(data = mun_mapa_ganadera, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "D"),
                          fillOpacity = 1,
                          fillColor = ~pal_vpt(VPT_2016),
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
                          group = "GANADERA",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"),
                          popup = ~pop_driver_ganadera)

m0 <- m0 %>%  addPolygons(data = mun_mapa_pob, stroke = TRUE, smoothFactor = 0.3,
                          options = pathOptions(pane = "E"),
                          fillOpacity = 1,
                          fillColor = ~pal_pob(POB_2015),
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
                          group = "POBLACIÓN",
                          labelOptions = labelOptions(
                            style = list("font-weight" = "normal", padding = "3px 8px"),
                            textsize = "15px",
                            direction = "auto"),
                          popup = ~pop_driver_poblacion)

# CONTROL DE CAPAS
m0 <- m0 %>% addLayersControl(
  baseGroups = c("Open Street Map", "Toner", "Toner Lite"),
  overlayGroups = c("MADERABLE", "NO MADERABLE", "AGRÍCOLA", "GANADERA", "POBLACIÓN", "REGIONES"),
  options = layersControlOptions(collapsed = FALSE)
)

m0

addLegend(m0, "topleft", group = "MADERABLE", pal = pal_vpm, values = mun_mapa_maderable$VPM_2016, opacity = 1.0, title = "Timber forest production <br/> (thousands of pesos)")
addLegend(m0, "topleft", group = "NO MADERABLE", pal = pal_vpnm, values = mun_mapa_maderable$VPNM_2016, opacity = 1.0, title = "Non timber forest production <br/> (thousands of pesos)")
addLegend(m0, "topleft", group = "AGRÍCOLA", pal = pal_vpc, values = mun_mapa_agricola$VPC_2016, opacity = 1.0, title = "Production of main crop <br/> (thousands of pesos)")
addLegend(m0, "topleft", group = "GANADERA", pal = pal_vpt, values = mun_mapa_ganadera$VPT_2016, opacity = 1.0, title = "Livestock value (pesos)")
addLegend(m0, "topleft", group = "POBLACIÓN", pal = pal_pob, values = mun_mapa_pob$POB_2015, opacity = 1.0, title = "Population (persons)")

observe({
  proxy <- leafletProxy("mapa", data = mun_mapa_maderable)
  proxy %>% clearControls()
  if (input$leyenda) {
    proxy %>% 
      addLegend(m0, "topleft", group = "MADERABLE", pal = pal_vpm, values = mun_mapa_maderable$VPM_2016, opacity = 1.0, title = "Producción madreable") %>%
      addLegend(m0, "topleft", group = "NO MADERABLE", pal = pal_vpnm, values = mun_mapa_maderable$VPNM_2016, opacity = 1.0, title = "Producción no-madreable")

  }
})

