function(input, output, session) {
  
  # GENERAR TABLAS PARA VISUALIZAR DATOS
  # VISUALIZACIÓN DE DATOS 1
  
  output$tabla1 = DT::renderDataTable({
    data <- datos_maderable
    DT::datatable(
      extensions = 'Buttons',
      options = list(
        dom = 'Bfrtip',
        buttons = c('csv')
      ),
      {
        if (input$NOMBRE != "Todos") {
          data <- data[data$NOMBRE == input$NOMBRE,]
        }
        data
      }
    )
  })
  
  # VISUALIZACIÓN DE DATOS 2
  output$tabla2 = DT::renderDataTable({
    data <- datos_agricola
    DT::datatable(
      extensions = 'Buttons',
      options = list(
        dom = 'Bfrtip',
        buttons = c('csv')
      ),
      {
        if (input$NOMBRE != "Todos") {
          data <- data[data$NOMBRE == input$NOMBRE,]
        }
        data
      }
    )
  })
  
  # VISUALIZACIÓN DE DATOS 3
  output$tabla3 = DT::renderDataTable({
    data <- datos_ganadera
    DT::datatable(
      extensions = 'Buttons',
      options = list(
        dom = 'Bfrtip',
        buttons = c('csv')
      ),
      {
        if (input$NOMBRE != "Todos") {
          data <- data[data$NOMBRE == input$NOMBRE,]
        }
        data
      }
    )
  })
  
  # GENERAR MAPA 1
  output$mapa_drivers <- renderLeaflet({
    
    m0 <- leaflet(mun_mapa) %>%
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
                  label = ~paste0(NOMGEO, ": ", formatC(NOMGEO, big.mark = ","))) 
    
    
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
      overlayGroups = c("MADERABLE", "NO MADERABLE", "AGRÍCOLA", "GANADERA", "POBLACIÓN"),
      options = layersControlOptions(collapsed = FALSE)
    )
    
    
    m0


    
  })
  
  
  # GENERAR MAPA PRESSURE

  output$mapa_pressure <- renderLeaflet({
    
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
    
    m1 <- m1 %>%  addPolygons(data = mun_mapa_agricola, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "A"),
                              fillOpacity = .7,
                              fillColor = ~pal_pct(100*(as.numeric(SST_2016)/as.numeric(AREA))),
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
                              group = "SUPERFICIE TEMPORAL",
                              labelOptions = labelOptions(
                                style = list("font-weight" = "normal", padding = "3px 8px"),
                                textsize = "15px",
                                direction = "auto"),
                              popup = ~pop_pressure_agricola)
    
    m1 <- m1 %>%  addPolygons(data = mun_mapa_agricola, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "A"),
                              fillOpacity = .7,
                              fillColor = ~pal_pct(100*(as.numeric(SSR_2016)/as.numeric(AREA))),
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
                              group = "SUPERFICIE RIEGO",
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
      overlayGroups = c("SUPERFICIE SEMBRADA", "SUPERFICIE TEMPORAL", "SUPERFICIE RIEGO", "AUTOCORRELACIÓN SUPERFICIE SEMBRADA"),
      options = layersControlOptions(collapsed = FALSE)
    )
    
    m1
    
  })
  
  # GENERAR MAPA PRESSURE
  
  output$mapa_pressure <- renderLeaflet({
    
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
                              group = "VEGETACIÓN",
                              labelOptions = labelOptions(
                                style = list("font-weight" = "normal", padding = "3px 8px"),
                                textsize = "15px",
                                direction = "auto"),
                              popup = ~pop_state_primaria)
    
    m2 <- m2 %>%  addPolygons(data = mun_mapa_vegprimaria, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "A"),
                              fillOpacity = .7,
                              fillColor = ~pal_primveg(PCT_PRIMARIA),
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
    
    m2 <- m2 %>%  addPolygons(data = mun_mapa_vegsecundaria, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "B"),
                              fillOpacity = .7,
                              fillColor = ~pal_primveg(PCT_SECUNDARIA),
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
    
  })
  
  
  # LOS PROXIES PERMITEN ENCENDER Y APAGAR ELEMENTOS EN R LEAFLET

  
}