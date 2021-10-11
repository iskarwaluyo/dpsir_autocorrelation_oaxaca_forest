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
    
    m0 <- m0 %>%  addPolygons(data = mun_mapa_maderable, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "A"),
                              fillOpacity = .7,
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
                              fillOpacity = .7,
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
                              fillOpacity = .7,
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
    
    m0 <- m0 %>%  addPolygons(data = maderable_autocor, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "D"),
                              fillOpacity = 1,
                              fillColor = ~pal_autocorr(CL_VPM),
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
                              group = "AUTOCORRELACIÓN MADERABLE",
                              labelOptions = labelOptions(
                                style = list("font-weight" = "normal", padding = "3px 8px"),
                                textsize = "15px",
                                direction = "auto"),
                              popup = ~pop_maderable_autocor)
    
    m0 <- m0 %>%  addPolygons(data = maderable_autocor, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "D"),
                              fillOpacity = 1,
                              fillColor = ~pal_autocorr(CL_VPNM),
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
                              group = "AUTOCORRELACIÓN NO MADERABLE",
                              labelOptions = labelOptions(
                                style = list("font-weight" = "normal", padding = "3px 8px"),
                                textsize = "15px",
                                direction = "auto"),
                              popup = ~pop_maderable_autocor)
    
    m0 <- m0 %>%  addPolygons(data = agricola_autocor, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "D"),
                              fillOpacity = 1,
                              fillColor = ~pal_autocorr(CL_VPV2016),
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
                              group = "AUTOCORRELACIÓN AGRÍCOLA",
                              labelOptions = labelOptions(
                                style = list("font-weight" = "normal", padding = "3px 8px"),
                                textsize = "15px",
                                direction = "auto"),
                              popup = ~pop_agricultura_autocor)
    
    m0 <- m0 %>%  addPolygons(data = ganadera_autocor, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "D"),
                              fillOpacity = 1,
                              fillColor = ~pal_autocorr(CL_VPT2016),
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
                              group = "AUTOCORRELACIÓN POBLACIÓN",
                              labelOptions = labelOptions(
                                style = list("font-weight" = "normal", padding = "3px 8px"),
                                textsize = "15px",
                                direction = "auto"),
                              popup = ~pop_poblacion_autocor)
    
    m0 <- m0 %>%  addPolygons(data = pob_autocor, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "D"),
                              fillOpacity = 1,
                              fillColor = ~pal_autocorr(CL_POB2015),
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
                              group = "AUTOCORRELACIÓN POBLACIÓN",
                              labelOptions = labelOptions(
                                style = list("font-weight" = "normal", padding = "3px 8px"),
                                textsize = "15px",
                                direction = "auto"),
                              popup = ~pop_poblacion_autocor)

    # CONTROL DE CAPAS
    m0 <- m0 %>% addLayersControl(
      baseGroups = c("Open Street Map", "Toner", "Toner Lite"),
      overlayGroups = c("MADERABLE", "NO MADERABLE", "AGRÍCOLA", "GANADERA", "POBLACIÓN", "REGIONES",
                        "AUTOCORRELACIÓN MADERABLE", "AUTOCORRELACIÓN NO MADERABLE", "AUTOCORRELACIÓN AGRÍCOLA",
                        "AUTOCORRELACIÓN GANADERA", "AUTOCORRELACIÓN POBLACIÓN"),
      options = layersControlOptions(collapsed = FALSE)
    )
    
    m0
    
  })
  
  
  # GENERAR MAPA PRESSURE

  output$mapa_pressure <- renderLeaflet({
    
    m1 <- leaflet(mun_mapa) %>%
      addMapPane("A", zIndex = 490) %>% #
      addMapPane("B", zIndex = 480) %>% # 

      
      
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
                              options = pathOptions(pane = "B"),
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
    
  })
  
  # GENERAR MAPA PRESSURE
  
  output$mapa_state <- renderLeaflet({
    
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
    
    m2 <- m2 %>%  addPolygons(data = vegprim_autocor, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "C"),
                              fillOpacity = 1,
                              fillColor = ~pal_autocorr(CL_PRI),
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
                              group = "AUTCORR VEGETACION PRIMARIA",
                              labelOptions = labelOptions(
                                style = list("font-weight" = "normal", padding = "3px 8px"),
                                textsize = "15px",
                                direction = "auto"))
    
    m2 <- m2 %>%  addPolygons(data = vegsecu_autocor, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "D"),
                              fillOpacity = 1,
                              fillColor = ~pal_autocorr(CL_PCTSEC),
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
                              group = "AUTCORR VEGETACION SECUNDARIA",
                              labelOptions = labelOptions(
                                style = list("font-weight" = "normal", padding = "3px 8px"),
                                textsize = "15px",
                                direction = "auto"))
    
    # CONTROL DE CAPAS
    m2 <- m2 %>% addLayersControl(
      baseGroups = c("Open Street Map", "Toner", "Toner Lite"),
      overlayGroups = c("VEGETACIÓN PRIMARIA", "VEGETACIÓN SECUNDARIA", "AUTCORR VEGETACION PRIMARIA", "AUTCORR VEGETACION SECUNDARIA"),
      options = layersControlOptions(collapsed = FALSE)
    )
    
    m2
    
  })
  

  output$mapa_impact <- renderLeaflet({
    
    m3 <- leaflet(mun_mapa) %>%
      addMapPane("A", zIndex = 490) %>% #
      addMapPane("B", zIndex = 480) %>% # 
      addMapPane("C", zIndex = 470) %>% # 
      addMapPane("D", zIndex = 460) %>% # 
      addMapPane("E", zIndex = 460) %>% # 
      addMapPane("F", zIndex = 460) %>% # 
      
      addTiles() %>%
      addTiles(group = "Open Street Map") %>%
      addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
      addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") %>%
      addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = .2,
                  fillColor = ~pal(as.numeric(NOMGEO)),
                  label = ~paste0(NOMGEO, ": ", formatC(NOMGEO, big.mark = ","))) 
    
    m3 <- m3 %>%  addPolygons(data = mun_mapa_maderable, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "A"),
                              fillOpacity = 0.7,
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
    
    m3 <- m3 %>%  addPolygons(data = mun_mapa_maderable, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "B"),
                              fillOpacity = 0.7,
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
    
    m3 <- m3 %>%  addPolygons(data = mun_mapa_agricola, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "C"),
                              fillOpacity = 0.7,
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
    
    
    m3 <- m3 %>%  addPolygons(data = mun_mapa_ganadera, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "D"),
                              fillOpacity = 0.7,
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
    
    m3 <- m3 %>%  addPolygons(data = maderable_autocor, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "D"),
                              fillOpacity = 1,
                              fillColor = ~pal_autocorr(CL_APM),
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
                              group = "AUTOCORRELACIÓN APROVECHAMIENTO MADERABLE",
                              labelOptions = labelOptions(
                                style = list("font-weight" = "normal", padding = "3px 8px"),
                                textsize = "15px",
                                direction = "auto"),
                              popup = ~pop_aprovechamientomaderable_autocor)
    
    m3 <- m3 %>%  addPolygons(data = maderable_autocor, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "E"),
                              fillOpacity = 1,
                              fillColor = ~pal_autocorr(CL_APNM),
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
                              group = "AUTOCORRELACIÓN APROVECHAMIENTO NO MADERABLE",
                              labelOptions = labelOptions(
                                style = list("font-weight" = "normal", padding = "3px 8px"),
                                textsize = "15px",
                                direction = "auto"),
                              popup = ~pop_aprovechamientonomaderable_autocor)
    
    m3 <- m3 %>%  addPolygons(data = agricola_autocor, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "E"),
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
                              group = "AUTOCORRELACIÓN PRODUCCIÓN AGRÍCOLA",
                              labelOptions = labelOptions(
                                style = list("font-weight" = "normal", padding = "3px 8px"),
                                textsize = "15px",
                                direction = "auto"),
                              popup = ~pop_aprovechamientonomaderable_autocor)
    
    m3 <- m3 %>%  addPolygons(data = ganadera_autocor, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "F"),
                              fillOpacity = 1,
                              fillColor = ~pal_autocorr(CL_VPT2016),
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
                              group = "AUTOCORRELACIÓN PRODUCCIÓN GANADERA",
                              labelOptions = labelOptions(
                                style = list("font-weight" = "normal", padding = "3px 8px"),
                                textsize = "15px",
                                direction = "auto"),
                              popup = ~pop_produccionganadera_autocor)
    
    
    # CONTROL DE CAPAS
    m3 <- m3 %>% addLayersControl(
      baseGroups = c("Open Street Map", "Toner", "Toner Lite"),
      overlayGroups = c("APROVECHAMIENTO MADERABLE", "APROVECHAMIENTO NO MADERABLE", "VOLUMEN AGRÍCOLA", "VOLUMEN GANADERÍA",
                        "AUTOCORRELACIÓN APROVECHAMIENTO MADERABLE", "AUTOCORRELACIÓN APROVECHAMIENTO NO MADERABLE",
                        "AUTOCORRELACIÓN PRODUCCIÓN AGRÍCOLA", "AUTOCORRELACIÓN PRODUCCIÓN GANADERA"),
      options = layersControlOptions(collapsed = FALSE)
    )
    
    m3  
    
  })
  
  output$mapa_response <- renderLeaflet({
    
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
                              options = pathOptions(pane = "A"),
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
                              options = pathOptions(pane = "B"),
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
    
  })
    
    
  # LOS PROXIES PERMITEN ENCENDER Y APAGAR ELEMENTOS EN R LEAFLET

  
}