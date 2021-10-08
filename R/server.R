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
  
  # GENERAR MAPA
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
                  fillColor = ~pal(as.numeric(CVE_MUN)),
                  label = ~paste0(NOMGEO, ": ", formatC(NOMGEO, big.mark = ","))) 
    
    m0 <- m0 %>%  addPolygons(data = mun_mapa_maderable, stroke = FALSE, smoothFactor = 0.3,
                              options = pathOptions(pane = "A"),
                              fillOpacity = 1,
                              fillColor = ~pal_vpm(as.numeric(VPM_2016)),
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
    
    m0 <- m0 %>%  addPolygons(data = mun_mapa_maderable, stroke = FALSE, smoothFactor = 0.3,
                              options = pathOptions(pane = "B"),
                              fillOpacity = 1,
                              fillColor = ~pal_vpnm(as.numeric(VPNM_2016)),
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
    
    m0 <- m0 %>%  addPolygons(data = mun_mapa_agricola, stroke = FALSE, smoothFactor = 0.3,
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
                              group = "AGRÍCOLA",
                              labelOptions = labelOptions(
                                style = list("font-weight" = "normal", padding = "3px 8px"),
                                textsize = "15px",
                                direction = "auto"),
                              popup = ~pop_driver_agricola)
    
    m0 <- m0 %>%  addPolygons(data = mun_mapa_ganadera, stroke = FALSE, smoothFactor = 0.3,
                              options = pathOptions(pane = "D"),
                              fillOpacity = 1,
                              fillColor = ~pal_vpt(as.numeric(VPT_2016)),
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
    
    m0 <- m0 %>%  addPolygons(data = mun_mapa_pob, stroke = FALSE, smoothFactor = 0.3,
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
    
  # LOS PROXIES PERMITEN ENCENDER Y APAGAR ELEMENTOS EN R LEAFLET
  observe({
    proxy <- leafletProxy("mapa_drivers", data = mun_mapa_maderable)
    proxy %>% clearControls()
    if (input$leyenda) {
      addLegend(m0, "topleft", group = "MADERABLE", pal = pal_vpm, values = mun_mapa_maderable$VPM_2016, opacity = 1.0, title = "Producción madreable <br/> (thousands of pesos)") %>%
      addLegend(m0, "topleft", group = "NO MADERABLE", pal = pal_vpnm, values = mun_mapa_maderable$VPNM_2016, opacity = 1.0, title = "Producción no-madreable <br/> (thousands of pesos)") %>%
      addLegend(m0, "topleft", group = "AGRÍCOLA", pal = pal_vpc, values = mun_mapa_agricola$VPC_2016, opacity = 1.0, title = "Production of main crop <br/> (thousands of pesos)") %>%
      addLegend(m0, "topleft", group = "GANADERA", pal = pal_vpt, values = mun_mapa_ganadera$VPT_2016, opacity = 1.0, title = "Livestock value (pesos)") %>%
      addLegend(m0, "topleft", group = "POBLACIÓN", pal = pal_pob, values = mun_mapa_pob$POB_2015, opacity = 1.0, title = "Population (persons)")
      
    }
  })
  
  observe({
    proxy <- leafletProxy("mapa_pressure", data = mun_mapa_agricola)
    proxy %>% clearControls()
    if (input$leyenda) {
      proxy %>% 
        addLegend(m1, "topleft", group = "SUPERFICIE SEMBRADA", pal = pal_pct, values = 100*(mun_mapa_agricola$SSC_2016/(as.numeric(mun_mapa_agricola$AREA))), opacity = 1.0, title = "Area with agricultural activity <br/> (%)")
    }
  })  
  
  observe({
    proxy <- leafletProxy("mapa_state", data = mun_mapa_ganadera)
    proxy %>% clearControls()
    if (input$leyenda) {
      proxy %>% 
        addLegend("topleft", group = "GANADERA", pal = pal_ganadera, values = ~as.numeric(VPT_2016), opacity = 1.0)
    }
  })
  
  observe({
    proxy <- leafletProxy("mapa_impact", data = mun_mapa_maderable)
    proxy %>% clearControls()
    if (input$leyenda) {
      proxy %>% 
        addLegend(m3, "topleft", group = "APROVECHAMIENTO MADERABLE", pal = pal_vpm, values = mun_mapa_maderable$APM_2016, opacity = 1.0, title = "Timber forest production <br/> (cubic meters)")
        addLegend(m3, "topleft", group = "APROVECHAMIENTO NO MADERABLE", pal = pal_vpnm, values = mun_mapa_maderable$APNM_2016, opacity = 1.0, title = "Non timber forest production <br/> (tons)")
    }
  })

  observe({
    proxy <- leafletProxy("mapa_response", data = mun_mapa_psa)
    proxy %>% clearControls()
    if (input$leyenda) {
      proxy %>% 
        addLegend(m4, "topleft", group = "PAGOS PSA", pal = pal_psa, values = mun_mapa_maderable$VPM_2016, opacity = 1.0, title = "Payments for ecosystem services <br/> (thousands of pesos)")
    }
  })
  
}