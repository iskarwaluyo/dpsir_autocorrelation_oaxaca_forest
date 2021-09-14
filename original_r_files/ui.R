bootstrapPage(theme = shinytheme("flatly"),
              navbarPage("MICAF",
                         
                         tabPanel("Mapa",
                                  basicPage("Mapa Interactivo de la Correlación entre la actividad Agropecuaria y el cambio de la superficie Forestal",
                                            tags$style(type = "text/css", "html, body {width:100%;height:100%}",
                                                       ".leaflet .legend {
                                                       line-height: 10px;
                                                       font-size: 10px;
                                                       }",
                                                       
                                                       ".leaflet .legend i{
                                                       width: 10px;
                                                       height: 10px;
                                                       }"),
                                            leafletOutput("mapa", width = "100%", height = 800),
                                          
                                            absolutePanel(top = 10, right = 10,
                                                          checkboxInput("leyenda", "Mostrar leyenda", TRUE),
                                                          absolutePanel(id = "logo_tia_cony", class = "card", bottom = 20, left = 60, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                                        tags$a(href='https://www.conacyt.gob.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_conacyt_solo.png',height='40',width='40'))),
                                                          absolutePanel(id = "logo_geo", class = "card", bottom = 20, left = 120, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                                        tags$a(href='https://www.centrogeo.org.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_centrogeo_solo.png',height='40',width='40'))),
                                            )
                                  )
                         ),
                         
                         navbarMenu("Datos",
                                    tabPanel("Producción agrícola 2007",
                                             h2("Visualización de datos agrícolas del 2007"),
                                             fluidRow(
                                               column(4,
                                                      selectInput("CULTI_ESPE",
                                                                  "Cultivo:",
                                                                  c("Todos",
                                                                    unique(as.character(concentrado07$CULTI_ESPE))))
                                               ),
                                               column(4,
                                                      selectInput("NOM_MUN_07",
                                                                  "Municipio:",
                                                                  c("Todos",
                                                                    unique(as.character(concentrado07$NOM_MUN_07))))
                                               ),
                                               column(4,
                                                      selectInput("CVE_CONCAT_07",
                                                                  "Clave concatenado/Área de Control:",
                                                                  c("Todos",
                                                                    unique(as.character(concentrado07$CVE_CONCAT_07))))
                                               )
                                             ),
                                             DT::dataTableOutput("tabla1"),
                                    ),
                                    
                                    tabPanel("Producción agrícola 2016",
                                             h2("Visualización de datos agrícolas del 2016"),
                                             fluidRow(
                                               column(4,
                                                      selectInput("CULTI_ESPE",
                                                                  "Cultivo:",
                                                                  c("Todos",
                                                                    unique(as.character(concentrado16$CULTI_ESPE))))
                                               ),
                                               column(4,
                                                      selectInput("NOM_MUN_16",
                                                                  "Municipio:",
                                                                  c("Todos",
                                                                    unique(as.character(concentrado16$NOM_MUN_16))))
                                               ),
                                               column(4,
                                                      selectInput("CVE_CONCAT_16",
                                                                  "Clave concatenado/Área de Control:",
                                                                  c("Todos",
                                                                    unique(as.character(concentrado16$CVE_CONCAT_16))))
                                               )
                                             ),
                                             DT::dataTableOutput("tabla2"),
                                    ),
                                    
                                    tabPanel("Comparativo por especie 2007 - 2016",
                                             h2("Cambios por especie por área de control"),
                                             fluidRow(
                                               column(4,
                                                      selectInput("CONCAT_ESPE",
                                                                  "Clave de área de control:",
                                                                  c("Todos",
                                                                    unique(as.character(sum_comparables_ac$CONCAT_ESPE))))
                                               )
                                             ),
                                             DT::dataTableOutput("tabla3"),
                                    ),
                                    
                                    tabPanel("Datos comparables 2007 - 2016",
                                             h2("Cambios por área de control"),
                                             ("NOTA: Datos completos solo para el Municipio Marqués de Comillas."),
                                             fluidRow(
                                               column(4,
                                                      selectInput("CVE_CONCAT",
                                                                  "Clave de área de control:",
                                                                  c("Todos",
                                                                    unique(as.character(df_correlacion$CVE_CONCAT))))
                                               ),
                                               column(4,
                                                      selectInput("NOM_MUN",
                                                                  "Municipio:",
                                                                  c("Todos",
                                                                    unique(as.character(df_correlacion$NOM_MUN))))
                                               )
                                             ),
                                             DT::dataTableOutput("tabla4"),
                                    ),
                                    
                                    tabPanel("Resultado de correlación de Pearson",
                                             h2("Correlación de Pearson"),
                                             DT::dataTableOutput("tabla5")                                             )
                         ),
                         
                         tabPanel("Correlación",
                                  pageWithSidebar(
                                    headerPanel('Visualización de la correlación de las variables.'),
                                    sidebarPanel(
                                      selectInput('xcol', 'Variable X', vars),
                                      selectInput('ycol', 'Variable Y', vars, selected = vars[[2]]),
                                      selectInput('tamano', 'Tamaño', vars, selected = vars[[3]]),
                                    ),
                                    mainPanel(
                                      plotOutput('plot1')
                                    )
                                  )                                    
                         ),
                         
                         navbarMenu("Proyecto",
                                    tabPanel("Resumen",
                                             includeHTML("https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/resumen.html")
                                    ),

                                    tabPanel("Acerca de este sitio",
                                             includeHTML("https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/acerca_de.html"))
                         )
                         
              )
              
)