function(input, output, session) {
  
  # GENERAR TABLAS PARA VISUALIZAR DATOS
  # VISUALIZACIÓN DE DATOS 1
  
  output$tabla1 = DT::renderDataTable({
    data <- concentrado07
    DT::datatable(
      extensions = 'Buttons',
      options = list(
        dom = 'Bfrtip',
        buttons = c('csv')
      ),
      {
        if (input$CULTI_ESPE != "Todos") {
          data <- data[data$CULTI_ESPE == input$CULTI_ESPE,]
        }
        if (input$NOM_MUN_07 != "Todos") {
          data <- data[data$NOM_MUN_07 == input$NOM_MUN_07,]
        }
        if (input$CVE_CONCAT_07 != "Todos") {
          data <- data[data$CVE_CONCAT_07 == input$CVE_CONCAT_07,]
        }
        data
      }
    )
  })
  
  # VISUALIZACIÓN DE DATOS 2
  output$tabla2 = DT::renderDataTable({
    data <- concentrado16
    DT::datatable(
      extensions = 'Buttons',
      options = list(
        dom = 'Bfrtip',
        buttons = c('csv')
      ),
      {
        if (input$CULTI_ESPE != "Todos") {
          data <- data[data$CULTI_ESPE == input$CULTI_ESPE,]
        }
        if (input$NOM_MUN_16 != "Todos") {
          data <- data[data$NOM_MUN_16 == input$NOM_MUN_16,]
        }
        if (input$CVE_CONCAT_16 != "Todos") {
          data <- data[data$CVE_CONCAT_16 == input$CVE_CONCAT_16,]
        }
        data
      }
    )
  })
  
  # VISUALIZACIÓN DE DATOS 3
  output$tabla3 = DT::renderDataTable({
    data <- comparado_sum_esp
    DT::datatable(
      extensions = 'Buttons',
      options = list(
        dom = 'Bfrtip',
        buttons = c('csv')
      ),
      {
        if (input$CONCAT_ESPE != "Todos") {
          data <- data[data$CONCAT_ESPE == input$CONCAT_ESPE,]
        }
        data
      }
    )
  })
  
  # VISUALIZACIÓN DE DATOS 3
  output$tabla4 = DT::renderDataTable({
    data <- df_correlacion
    DT::datatable(
      extensions = 'Buttons',
      options = list(
        dom = 'Bfrtip',
        buttons = c('csv')
      ),
      {
        if (input$CVE_CONCAT != "Todos") {
          data <- data[data$CVE_CONCAT == input$CVE_CONCAT,]
        }
        if (input$NOM_MUN != "Todos") {
          data <- data[data$NOM_MUN == input$NOM_MUN,]
        }
        data
      }
    )
  })
  
  # VISUALIZACIÓN DE DATOS 3
  
  output$tabla5 <- DT::renderDataTable(
    DT::datatable(df_correlacion_pearson, options = list(paging = FALSE))
  )
  
  # VISUALIZAR CORRELACIONES
  # Combine the selected variables into a new data frame
  selectedData1 <<- reactive({
    matriz_correlacion[, c(input$xcol)]
  })
  
  selectedData2 <<- reactive({
    matriz_correlacion[, c(input$ycol)]
  })
  
  selectedData3 <<- reactive({
    matriz_correlacion[, c(input$tamano)]
  })
  
  clusters <- reactive({
    kmeans(selectedData(), input$tamano) # NO SE USA
  })
  
  output$plot1 <- renderPlot({
    data <- matriz_correlacion
    ggplot(data, aes(x=selectedData1(), y=selectedData2(), size = selectedData3())) +
      geom_point(alpha=0.7) +
      geom_smooth(method=lm, se=FALSE, linetype="dashed",
                  color="darkred")
  })
  
  # GENERAR GRÁFICAS
  output$grafica1 <- renderPlot({
    scatterplot(matriz_correlacion$`TONELADAS POR HA 2007`, matriz_correlacion$`TONELADAS PRODUCIDAS 2007`)
  })
  
  # GENERAR MAPA
  output$mapa <- renderLeaflet({
    
    m <-leaflet(ac_mapa_mc) %>%
      addMapPane("A", zIndex = 490) %>% #
      addMapPane("B", zIndex = 480) %>% # 
      addMapPane("C", zIndex = 470) %>% # 
      addMapPane("D", zIndex = 460) %>% # 
      addMapPane("E", zIndex = 450) %>% #
      addMapPane("F", zIndex = 440) %>% # 
      addMapPane("G", zIndex = 430) %>% # 
      addMapPane("H", zIndex = 420) %>% # 
      addMapPane("I", zIndex = 410) %>% # 
      addMapPane("J", zIndex = 410) %>% # 
      
      addTiles(group = "Open Street Map") %>%
      addProviderTiles(providers$Stamen.Toner, group = "Toner") %>%
      addProviderTiles(providers$Stamen.TonerLite, group = "Toner Lite")
    
    m <- m %>%  addPolygons(data = ac_mapa_mc, stroke = FALSE, smoothFactor = 0.3,
                            options = pathOptions(pane = "A"),
                            fillOpacity = .7,
                            fillColor = ~pal_1(as.numeric(TERRENOS)),
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
                            group = "Terrenos totales",
                            labelOptions = labelOptions(
                              style = list("font-weight" = "normal", padding = "3px 8px"),
                              textsize = "15px",
                              direction = "auto"),
                            popup = ~pop_terrenos)

    # AGREGAR CAPA DE DATOS DE PRODUCCIÓN
    m <- m %>%  addPolygons(data = ac_mapa_mc, stroke = TRUE, smoothFactor = 0.3, 
                            options = pathOptions(pane = "B"),
                            fillOpacity = .7,
                            fillColor = ~pal_2(PCT_FORESTAL),
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
                            group = "Actividad forestal",
                            labelOptions = labelOptions(
                              style = list("font-weight" = "normal", padding = "3px 8px"),
                              textsize = "15px",
                              direction = "auto"),
                            popup = ~pop_forestal)
    
    m <- m %>%  addPolygons(data = ac_mapa_mc, stroke = TRUE, smoothFactor = 0.3,
                            options = pathOptions(pane = "C"),
                            fillOpacity = .7,
                            fillColor = ~pal_3(PCT_AGRICOLA),
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
                            group = "Actividad agricola",
                            labelOptions = labelOptions(
                              style = list("font-weight" = "normal", padding = "3px 8px"),
                              textsize = "15px",
                              direction = "auto"),
                            popup = ~pop_agricola)

    m <- m %>%  addPolygons(data = ac_mapa_mc, stroke = TRUE, smoothFactor = 0.3, 
                            options = pathOptions(pane = "D"),
                            fillOpacity = .7,
                            fillColor = ~pal_4(PCT_PECUARIO),
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
                            group = "Actividad pecuaria",
                            labelOptions = labelOptions(
                              style = list("font-weight" = "normal", padding = "3px 8px"),
                              textsize = "15px",
                              direction = "auto"),
                            popup = ~pop_pecuario)
    
    m <- m %>%  addPolygons(data = cambios_usv_ac, stroke = TRUE, smoothFactor = 0.3, 
                            options = pathOptions(pane = "D"),
                            fillOpacity = .7,
                            fillColor = ~pal_7(X._PVP),
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
                            group = "Cambios por área de control",
                            labelOptions = labelOptions(
                              style = list("font-weight" = "normal", padding = "3px 8px"),
                              textsize = "15px",
                              direction = "auto"),
                            popup = ~pop_cambios)
    
    m <- m %>%  addPolygons(data = autocorr_ac, stroke = TRUE, smoothFactor = 0.3, 
                            options = pathOptions(pane = "D"),
                            fillOpacity = .7,
                            fillColor = ~pal_9(P_AT_BJ_S),
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
                            group = "Autocorrelación por área de control",
                            labelOptions = labelOptions(
                              style = list("font-weight" = "normal", padding = "3px 8px"),
                              textsize = "15px",
                              direction = "auto"),
                            popup = ~pop_autocorr)

    
    # CAPAS DE AUTOCORRELACIÓN
    m <- m %>%  addPolygons(data = autocorr, stroke = TRUE, smoothFactor = 0.3, fillOpacity = 1,
                            options = pathOptions(pane = "E"),
                            fillColor = ~pal(LISA_CL),
                            weight = 1,
                            opacity = 0.1,
                            dashArray = "1",
                            group = "Autocorrelación pérdida")
    
    m <- m %>%  addPolygons(data = autocorr, stroke = TRUE, smoothFactor = 0.3, fillOpacity = 1,
                            options = pathOptions(pane = "F"),
                            fillColor = ~pal(LISA_CLdeg),
                            weight = 1,
                            opacity = 0.1,
                            dashArray = "1",
                            group = "Autocorrelación degradación")
    
    m <- m %>%  addPolygons(data = autocorr, stroke = TRUE, smoothFactor = 0.3, fillOpacity = 1,
                            options = pathOptions(pane = "G"),
                            fillColor = ~pal(LISA_CLdef),
                            weight = 1,
                            opacity = 0.1,
                            dashArray = "1",
                            group = "Autocorrelación deforestación")
    
    # CAPAS DE SERIES
    m <- m %>%  addPolygons(data = serie_3, stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1,
                            options = pathOptions(pane = "H"),
                            fillColor = ~pal_5(Clase),
                            group = "Serie 3")
    
    m <- m %>%  addPolygons(data = serie_6, stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1,
                            options = pathOptions(pane = "I"),
                            fillColor = ~pal_6(Clase),
                            group = "Serie 6")
    
    # CAPA DE CAMBIOS DE USO DE SUELO
    m <- m %>%  addPolygons(data = cambios_usv, stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1,
                            options = pathOptions(pane = "J"),
                            fillColor = ~pal_8(tipo_cambi),
                            group = "Cambios USV")
    
    # CONTROL DE CAPAS
    m <- m %>% addLayersControl(
      baseGroups = c("Open Street Map", "Toner", "Toner Lite"),
      overlayGroups = c("Terrenos totales", "Actividad forestal", "Actividad agricola","Actividad pecuaria",  "Cambios por área de control", "Autocorrelación por área de control", "Autocorrelación pérdida", "Autocorrelación degradación", "Autocorrelación deforestación", "Serie 3", "Serie 6", "Cambios USV"),
      options = layersControlOptions(collapsed = FALSE)
    )
    
    m
    
  })
   
  # LOS PROXIES PERMITEN ENCENDER Y APAGAR ELEMENTOS EN R LEAFLET
  observe({
    proxy <- leafletProxy("mapa", data = ac_mapa_mc)
    proxy %>% clearControls()
    if (input$leyenda) {
      proxy %>% 
        addLegend("topleft", group = "Terrenos totales", pal = pal_0, values = ~TERRENOS, opacity = 1.0) %>%
        addLegend("topleft", group = "Actividad forestal", pal = pal_2, values = ~PCT_FORESTAL, opacity = 1.0) %>%
        addLegend("topleft", group = "Actividad agricola", pal = pal_3, values = ~PCT_AGRICOLA, opacity = 1.0) %>%
        addLegend("topleft", group = "Actividad pecuaria", pal = pal_4, values = ~PCT_PECUARIO, opacity = 1.0) 
    }
  })
  
  observe({
    proxy <- leafletProxy("mapa", data = autocorr)
    proxy %>% clearControls()
    if (input$leyenda) {
      proxy %>% 
        addLegend("topleft", group = "Autocorrelación pérdida", pal = pal, values = ~as.numeric(LISA_CL), opacity = 1.0) %>%
        addLegend("topleft", group = "Autocorrelación degradación", pal = pal, values = ~as.numeric(LISA_CLdeg), opacity = 1.0) %>%
        addLegend("topleft", group = "Autocorrelación deforestación", pal = pal, values = ~as.numeric(LISA_CLdef), opacity = 1.0)
    }
  })  
  
  observe({
    proxy <- leafletProxy("mapa", data = cambios_usv)
    proxy %>% clearControls()
    if (input$leyenda) {
      proxy %>% 
        addLegend("topleft", group = "Cambios USV", pal = pal_8, values = ~tipo_cambi, opacity = 1.0)
    }
  })
  
  observe({
    proxy <- leafletProxy("mapa", data = serie_3)
    proxy %>% clearControls()
    if (input$leyenda) {
      proxy %>% 
        addLegend("topleft", group = "Serie 3", pal = pal_5, values = ~Clase, opacity = 1.0)
    }
  })
  
  observe({
    proxy <- leafletProxy("mapa", data = serie_6)
    proxy %>% clearControls()
    if (input$leyenda) {
      proxy %>% 
        addLegend("topleft", group = "Serie 6", pal = pal_6, values = ~Clase, opacity = 1.0)
    }
  })
  

}