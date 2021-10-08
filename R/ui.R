bootstrapPage(theme = shinytheme("flatly"),
              navbarPage("DPSIR OAXACA",
                         
                  navbarMenu("DPSIR Maps",
                         tabPanel("Drivers",
                                  basicPage("Driver Maps",
                                            tags$style(type = "text/css", "html, body {width:100%;height:100%}",
                                                       ".leaflet .legend {
                                                       line-height: 10px;
                                                       font-size: 10px;
                                                       }",
                                                       
                                                       ".leaflet .legend i{
                                                       width: 10px;
                                                       height: 10px;
                                                       }"),
                                            leafletOutput("mapa_drivers", width = "100%", height = "100%"),
                                          
                                            absolutePanel(top = 10, right = 10,
                                                          checkboxInput("leyenda", "Mostrar leyenda", TRUE),
                                                          absolutePanel(id = "logo_tia_cony", class = "card", bottom = 20, left = 60, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                                        tags$a(href='https://www.conacyt.gob.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_conacyt_solo.png',height='40',width='40'))),
                                                          absolutePanel(id = "logo_geo", class = "card", bottom = 20, left = 120, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                                        tags$a(href='https://www.centrogeo.org.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_centrogeo_solo.png',height='40',width='40'))),
                                            )
                                  )
                         ),
                         
                         tabPanel("Pressure",
                                  basicPage("Pressure Maps",
                                            tags$style(type = "text/css", "html, body {width:100%;height:100%}",
                                                       ".leaflet .legend {
                                                       line-height: 10px;
                                                       font-size: 10px;
                                                       }",
                                                       
                                                       ".leaflet .legend i{
                                                       width: 10px;
                                                       height: 10px;
                                                       }"),
                                            leafletOutput("mapa_pressure", width = "100%", height = 800),
                                            
                                            absolutePanel(top = 10, right = 10,
                                                          checkboxInput("leyenda", "Mostrar leyenda", TRUE),
                                                          absolutePanel(id = "logo_tia_cony", class = "card", bottom = 20, left = 60, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                                        tags$a(href='https://www.conacyt.gob.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_conacyt_solo.png',height='40',width='40'))),
                                                          absolutePanel(id = "logo_geo", class = "card", bottom = 20, left = 120, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                                        tags$a(href='https://www.centrogeo.org.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_centrogeo_solo.png',height='40',width='40'))),
                                            )
                                  )
                         ),
                         
                         tabPanel("State",
                                  basicPage("State Maps",
                                            tags$style(type = "text/css", "html, body {width:100%;height:100%}",
                                                       ".leaflet .legend {
                                                       line-height: 10px;
                                                       font-size: 10px;
                                                       }",
                                                       
                                                       ".leaflet .legend i{
                                                       width: 10px;
                                                       height: 10px;
                                                       }"),
                                            leafletOutput("mapa_state", width = "100%", height = 800),
                                            
                                            absolutePanel(top = 10, right = 10,
                                                          checkboxInput("leyenda", "Mostrar leyenda", TRUE),
                                                          absolutePanel(id = "logo_tia_cony", class = "card", bottom = 20, left = 60, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                                        tags$a(href='https://www.conacyt.gob.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_conacyt_solo.png',height='40',width='40'))),
                                                          absolutePanel(id = "logo_geo", class = "card", bottom = 20, left = 120, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                                        tags$a(href='https://www.centrogeo.org.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_centrogeo_solo.png',height='40',width='40'))),
                                            )
                                  )
                         ),
                         
                         tabPanel("Impact",
                                  basicPage("Impact Maps",
                                            tags$style(type = "text/css", "html, body {width:100%;height:100%}",
                                                       ".leaflet .legend {
                                                       line-height: 10px;
                                                       font-size: 10px;
                                                       }",
                                                       
                                                       ".leaflet .legend i{
                                                       width: 10px;
                                                       height: 10px;
                                                       }"),
                                            leafletOutput("mapa_impact", width = "100%", height = 800),
                                            
                                            absolutePanel(top = 10, right = 10,
                                                          checkboxInput("leyenda", "Mostrar leyenda", TRUE),
                                                          absolutePanel(id = "logo_tia_cony", class = "card", bottom = 20, left = 60, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                                        tags$a(href='https://www.conacyt.gob.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_conacyt_solo.png',height='40',width='40'))),
                                                          absolutePanel(id = "logo_geo", class = "card", bottom = 20, left = 120, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                                        tags$a(href='https://www.centrogeo.org.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_centrogeo_solo.png',height='40',width='40'))),
                                            )
                                  )
                         ),
                         
                         tabPanel("Response",
                                  basicPage("Response Map",
                                            tags$style(type = "text/css", "html, body {width:100%;height:100%}",
                                                       ".leaflet .legend {
                                                       line-height: 10px;
                                                       font-size: 10px;
                                                       }",
                                                       
                                                       ".leaflet .legend i{
                                                       width: 10px;
                                                       height: 10px;
                                                       }"),
                                            leafletOutput("mapa_response", width = "100%", height = 800),
                                            
                                            absolutePanel(top = 10, right = 10,
                                                          checkboxInput("leyenda", "Mostrar leyenda", TRUE),
                                                          absolutePanel(id = "logo_tia_cony", class = "card", bottom = 20, left = 60, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                                        tags$a(href='https://www.conacyt.gob.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_conacyt_solo.png',height='40',width='40'))),
                                                          absolutePanel(id = "logo_geo", class = "card", bottom = 20, left = 120, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                                        tags$a(href='https://www.centrogeo.org.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_centrogeo_solo.png',height='40',width='40'))),
                                            )
                                  )
                         )
              ),
                         
                         
                         navbarMenu("Datos DPSIR",
                                    tabPanel("INDICADORES 1",
                                             h2("MADERABLE"),
                                             fluidRow(
                                               column(4,
                                                      selectInput("NOMBRE",
                                                                  "Municipio:",
                                                                  c("Todos",
                                                                    unique(as.character(datos_maderable$NOMBRE))))
                                               )
                                             ),
                                             DT::dataTableOutput("tabla1")
                                    ),
                                    
                                    tabPanel("INDICADORES 2",
                                             h2("AGRÍCOLA"),
                                             fluidRow(
                                               column(4,
                                                      selectInput("NOMBRE",
                                                                  "Cultivo:",
                                                                  c("Todos",
                                                                    unique(as.character(datos_agricola$NOMBRE))))
                                               )
                                             ),
                                             DT::dataTableOutput("tabla2")
                                    ),
                                    
                                    tabPanel("INDICADORES 3",
                                             h2("GANADERA"),
                                             fluidRow(
                                               fluidRow(
                                                 column(4,
                                                        selectInput("NOMBRE",
                                                                    "Cultivo:",
                                                                    c("Todos",
                                                                      unique(as.character(datos_ganadera$NOMBRE))))
                                                 )
                                             ),
                                             DT::dataTableOutput("tabla3")
                                    ),
                                    
                                    navbarMenu("Variables manifiestas",
                                               tabPanel("INDICADORES 1",
                                                        h2("MADERABLE"),
                                                        fluidRow(
                                                          column(4,
                                                                 selectInput("NOMBRE",
                                                                             "Municipio:",
                                                                             c("Todos",
                                                                               unique(as.character(datos_maderable$NOMBRE))))
                                                          )
                                                        ),
                                                        DT::dataTableOutput("tabla1")
                                               ),
                                               
                                               tabPanel("INDICADORES 2",
                                                        h2("AGRÍCOLA"),
                                                        fluidRow(
                                                          column(4,
                                                                 selectInput("NOMBRE",
                                                                             "Cultivo:",
                                                                             c("Todos",
                                                                               unique(as.character(datos_agricola$NOMBRE))))
                                                          )
                                                        ),
                                                        DT::dataTableOutput("tabla2")
                                               ),
                                               
                                               tabPanel("INDICADORES 3",
                                                        h2("GANADERA"),
                                                        fluidRow(
                                                          fluidRow(
                                                            column(4,
                                                                   selectInput("NOMBRE",
                                                                               "Cultivo:",
                                                                               c("Todos",
                                                                                 unique(as.character(datos_ganadera$NOMBRE))))
                                                            )
                                                          ),
                                                          DT::dataTableOutput("tabla3")
                                                        ),
                                    

                         
                         navbarMenu("Proyecto",
                                    tabPanel("Resumen",
                                             includeHTML("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/html/resumen.html")
                                    ),

                                    tabPanel("Acerca de este sitio",
                                             includeHTML("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/html/acerca_de.html"))
                         )
                         
              )
              
)
)
)
)
)