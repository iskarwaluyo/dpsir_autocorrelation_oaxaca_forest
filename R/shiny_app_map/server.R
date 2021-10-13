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
  
  # GENERAR MAPA DRIVERS
  output$mapa_drivers <- renderLeaflet({
    
    m0 <- leaflet(mun_mapa) %>%
      addMapPane("AA", zIndex = 500) %>% #
      addMapPane("A", zIndex = 490) %>% #
      addMapPane("B", zIndex = 480) %>% # 
      addMapPane("C", zIndex = 470) %>% # 
      addMapPane("D", zIndex = 460) %>% # 
      addMapPane("E", zIndex = 450) %>% # 
      addMapPane("F", zIndex = 440) %>% # 
      addMapPane("G", zIndex = 430) %>% # 
      
      addTiles() %>%
      addTiles(group = "Open Street Map") %>%
      addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
      addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") 

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
                              popup = paste("Región: ", mun_mapa_regiones$REGION, "<br>")
    )
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
                              options = pathOptions(pane = "A"),
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
                              options = pathOptions(pane = "B"),
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
    
    m0 <- m0 %>%  addPolygons(data = mun_mapa_ganadera, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "C"),
                              fillOpacity = .7,
                              fillColor = ~pal_vpc(VPT_2016),
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
                              options = pathOptions(pane = "C"),
                              fillOpacity = .7,
                              fillColor = ~pal_vpc(POB_2015),
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
    
    m0 <- m0 %>%  addPolygons(data = maderable_autocor, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "C"),
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
                              options = pathOptions(pane = "E"),
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
                              group = "AUTOCORRELACIÓN GANADERA",
                              labelOptions = labelOptions(
                                style = list("font-weight" = "normal", padding = "3px 8px"),
                                textsize = "15px",
                                direction = "auto"),
                              popup = ~pop_poblacion_autocor)
    
    m0 <- m0 %>%  addPolygons(data = pob_autocor, stroke = TRUE, smoothFactor = 0.3,
                              options = pathOptions(pane = "G"),
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
      overlayGroups = c("REGIONES", "MADERABLE", "NO MADERABLE", "AGRÍCOLA", "GANADERA", "POBLACIÓN", 
                        "AUTOCORRELACIÓN MADERABLE", "AUTOCORRELACIÓN NO MADERABLE", "AUTOCORRELACIÓN AGRÍCOLA",
                        "AUTOCORRELACIÓN GANADERA", "AUTOCORRELACIÓN POBLACIÓN"),
      options = layersControlOptions(collapsed = TRUE)
    )
    
    m0 <- m0 %>% hideGroup("MADERABLE")
    m0 <- m0 %>% hideGroup("NO MADERABLE")
    m0 <- m0 %>% hideGroup("AGRÍCOLA")
    m0 <- m0 %>% hideGroup("GANADERA")
    m0 <- m0 %>% hideGroup("POBLACIÓN")
    m0 <- m0 %>% hideGroup("REGIONES")
    m0 <- m0 %>% hideGroup("AUTOCORRELACIÓN MADERABLE")
    m0 <- m0 %>% hideGroup("AUTOCORRELACIÓN NO MADERABLE")
    m0 <- m0 %>% hideGroup("AUTOCORRELACIÓN AGRÍCOLA")
    m0 <- m0 %>% hideGroup("AUTOCORRELACIÓN GANADERA")
    m0 <- m0 %>% hideGroup("AUTOCORRELACIÓN POBLACIÓN")
    
  })
  
  
  # GENERAR MAPA PRESSURE
  
  output$mapa_pressure <- renderLeaflet({
    
    m1 <- leaflet(mun_mapa) %>%
      addMapPane("AA", zIndex = 500) %>% #
      addMapPane("A", zIndex = 490) %>% #
      addMapPane("B", zIndex = 480) %>% # 
      
      addTiles() %>%
      addTiles(group = "Open Street Map") %>%
      addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
      addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") 
    
    m1 <- m1 %>%  addPolygons(data = mun_mapa_regiones, stroke = TRUE, smoothFactor = 0.3,
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
                              popup = paste("Región: ", mun_mapa_regiones$REGION, "<br>")
    )
    
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
      overlayGroups = c("REGIONES", "SUPERFICIE SEMBRADA", "AUTOCORRELACIÓN SUPERFICIE SEMBRADA"),
      options = layersControlOptions(collapsed = TRUE)
    )
    
    m1 <- m1 %>% hideGroup("SUPERFICE SEMBRADA")
    m1 <- m1 %>% hideGroup("AUTOCORRELACIÓN SUPERFICE SEMBRADA")
    
  })
  
  # GENERAR MAPA STATE
  
  output$mapa_state <- renderLeaflet({
    
    m2 <- leaflet(mun_mapa) %>%
      addMapPane("AA", zIndex = 500) %>% #
      addMapPane("A", zIndex = 490) %>% #
      addMapPane("B", zIndex = 480) %>% # 
      addMapPane("C", zIndex = 470) %>% # 
      addMapPane("D", zIndex = 460) %>% # 
      
      addTiles() %>%
      addTiles(group = "Open Street Map") %>%
      addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
      addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite")
    
    m2 <- m2 %>%  addPolygons(data = mun_mapa_regiones, stroke = TRUE, smoothFactor = 0.3,
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
                              popup = paste("Región: ", mun_mapa_regiones$REGION, "<br>")
    )
    
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
      overlayGroups = c("REGIONES", "VEGETACIÓN PRIMARIA", "VEGETACIÓN SECUNDARIA", "AUTCORR VEGETACION PRIMARIA", "AUTCORR VEGETACION SECUNDARIA"),
      options = layersControlOptions(collapsed = FALSE)
    )
    
    m2 <- m2 %>% hideGroup("VEGETACIÓN PRIMARIA")
    m2 <- m2 %>% hideGroup("AUTOCORR VEGETACION PRIMARIA")
    m2 <- m2 %>% hideGroup("VEGETACIÓN SECUNDARIA")
    m2 <- m2 %>% hideGroup("AUTOCORR VEGETACION SECUNDARIA")
    
  })
  
  # GENERAR MAPA IMPACT
  
  output$mapa_impact <- renderLeaflet({
    
    m3 <- leaflet(mun_mapa) %>%
      addMapPane("AA", zIndex = 500) %>% #
      addMapPane("A", zIndex = 490) %>% #
      addMapPane("B", zIndex = 480) %>% # 
      addMapPane("C", zIndex = 470) %>% # 
      addMapPane("D", zIndex = 460) %>% # 
      addMapPane("E", zIndex = 460) %>% # 
      addMapPane("F", zIndex = 460) %>% # 
      
      addTiles() %>%
      addTiles(group = "Open Street Map") %>%
      addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
      addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") 
    
    m3 <- m3 %>%  addPolygons(data = mun_mapa_regiones, stroke = TRUE, smoothFactor = 0.3,
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
                              popup = paste("Región: ", mun_mapa_regiones$REGION, "<br>")
    )
    
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
    
    
    # CONTROL DE CAPAS
    m3 <- m3 %>% addLayersControl(
      baseGroups = c("Open Street Map", "Toner", "Toner Lite"),
      overlayGroups = c("REGIOINES", "APROVECHAMIENTO MADERABLE", "APROVECHAMIENTO NO MADERABLE",
                        "AUTOCORRELACIÓN APROVECHAMIENTO MADERABLE", "AUTOCORRELACIÓN APROVECHAMIENTO NO MADERABLE"),
      options = layersControlOptions(collapsed = TRUE)
    )
    
    m3 <- m3 %>% hideGroup("APROVECHAMIENTO MADERABLE")
    m3 <- m3 %>% hideGroup("APROVECHAMIENTO NO MADERABLE")
    m3 <- m3 %>% hideGroup("AUTOCORRELACIÓN APROVECHAMIENTO MADERABLE")
    m3 <- m3 %>% hideGroup("AUTOCORRELACIÓN APROVECHAMIENTO NO MADERABLE")

    
  })
  
  # GENERAR MAPA RESPONSE
  
  output$mapa_response <- renderLeaflet({
    
    m4 <- leaflet(mun_mapa) %>%
      addMapPane("AA", zIndex = 500) %>% #
      addMapPane("A", zIndex = 490) %>% #
      addMapPane("B", zIndex = 480) %>% # 
      addMapPane("C", zIndex = 470) %>% # 
      addMapPane("D", zIndex = 460) %>% # 
      
      addTiles() %>%
      addTiles(group = "Open Street Map") %>%
      addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
      addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite") 
    
    m4 <- m4 %>%  addPolygons(data = mun_mapa_regiones, stroke = TRUE, smoothFactor = 0.3,
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
                              popup = paste("Región: ", mun_mapa_regiones$REGION, "<br>")
    )
    
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
      overlayGroups = c("REGIONES", "PAGOS PSA", "AUTOCORRELACIÓN PSA"),
      options = layersControlOptions(collapsed = TRUE)
    )
    
    m4 <- m4 %>% hideGroup("PAGOS PSA")
    m4 <- m4 %>% hideGroup("AUTOCORRELACIÓN PSA")
    
  })
  
  
  # LOS PROXIES PERMITEN ENCENDER Y APAGAR ELEMENTOS EN R LEAFLET
  observe({
    proxy <- leafletProxy("mapa_drivers", data = mun_mapa_maderable)
    proxy %>% clearControls()
    if (input$leyenda_driver) {
      proxy %>% 
        addLegend("topleft", group = "MADERABLE", pal = pal_vpm, values = ~VPM_2016, opacity = 1.0, title = "Producción maderable") %>%
        addLegend("topleft", group = "NO MADERABLE", pal = pal_vpnm, values = ~VPNM_2016, opacity = 1.0, title = "Producción no maderable") %>%
        addLegend("topleft", group = "AGRÍCOLA", pal = pal_vpc, values = mun_mapa_agricola$VPC_2016, opacity = 1.0, title = "Producción agrícola") %>%
        addLegend("topleft", group = "GANADERA", pal = pal_vpt, values =mun_mapa_ganadera$VPT_2016, opacity = 1.0, title = "Producción ganadera") %>%  
        addLegend("topleft", group = "POBLACIÓN", pal = pal_pob, values =  mun_mapa_pob$POB_2015, opacity = 1.0, title = "Población")
    }
  })
  
  observe({
    proxy <- leafletProxy("mapa_pressure", data = mun_mapa_agricola)
    proxy %>% clearControls()
    if (input$leyenda_pressure) {
      proxy %>% 
        addLegend("topleft", group = "SUPERFICIE SEMBRADA", pal = pal_pct, values = ~SSCPCT_2016, opacity = 1.0, title = "Superfice ocupada con actividad agrícola (%)") %>%
        addLegend("topleft", group = "AUTOCORRELACIÓN SUPERFICIE SEMBRADA", pal = pal_autocorr, values = c(0:4), opacity = 1.0, title = "Autocorrelación (LISA)") 
    }
  })
  
  observe({
    proxy <- leafletProxy("mapa_state", data = mun_mapa_vegprimaria)
    proxy %>% clearControls()
    if (input$leyenda_state) {
      proxy %>% 
        addLegend("topleft", group = "VEGETACIÓN PRIMARIA", pal = pal_primveg, values = c(0:100), opacity = 1.0, title = "Superfice con vegetación primaria (%)") %>%
        addLegend("topleft", group = "VEGETACIÓN SECUNDARIA", pal = pal_primveg, values = c(0:100), opacity = 1.0, title = "Superfice con vegetación secundaria (%)") %>% 
        addLegend("topleft", group = "AUTOCORR VEGETACIÓN PRIMARIA", pal = pal_autocorr, values = c(0:4), opacity = 1.0, title = "Autocorrelación (LISA)") %>%
        addLegend("topleft", group = "AUTOCORR VEGETACIÓN SECUNDARIA", pal = pal_autocorr, values = c(0:4), opacity = 1.0, title = "Autocorrelación (LISA)")
    }
  })

  observe({
    proxy <- leafletProxy("mapa_impact", data = mun_mapa_maderable)
    proxy %>% clearControls()
    if (input$leyenda_impact) {
      proxy %>% 
        addLegend("topleft", group = "APROVECHAMIENTO MADERABLE", pal = pal_apm, values = ~APM_2016, opacity = 1.0, title = "Producción maderable (metros cúbicos)") %>%
        addLegend("topleft", group = "APROVECHAMIENTO NO MADERABLE", pal = pal_apnm, values = ~APNM_2016, opacity = 1.0, title = "Producción no maderable (toneladas)") %>% 
        addLegend("topleft", group = "AUTOCORRELACIÓN APROVECHAMIENTO MADERABLE", pal = pal_autocorr, values = c(0:4), opacity = 1.0, title = "Autocorrelación (LISA)") %>%
        addLegend("topleft", group = "AUTOCORRELACIÓN APROVECHAMIENTO NO MADERABLE", pal = pal_autocorr, values = c(0:4), opacity = 1.0, title = "Autocorrelación (LISA)")
    }
  })
  
  observe({
    proxy <- leafletProxy("mapa_response", data = mun_mapa_psa)
    proxy %>% clearControls()
    if (input$leyenda_response) {
      proxy %>% 
        addLegend("topleft", group = "PAGOS PSA", pal = pal_psa, values = ~PCT_PSA, opacity = 1.0, title = "Área sujeta a PSA (%)") %>%
        addLegend("topleft", group = "AUTOCORRELACIÓN PSA", pal = pal_autocorr, values = c(0:4), opacity = 1.0, title = "Autocorrelación (LISA)")
    }
  })
  
}