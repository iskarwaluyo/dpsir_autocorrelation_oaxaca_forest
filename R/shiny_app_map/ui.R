bootstrapPage(theme = shinytheme("flatly"),
              tags$head(includeHTML("gtag.html")),
              
              navbarPage("DPSIR OAXACA", 
                         
                         navbarMenu("Mapas",
                         
                          tabPanel("Drivers",
                                  div(class="outer",
                                  tags$head(includeCSS("styles.css")),
                                  leafletOutput("mapa_drivers", width="100%", height="100%"),
                                            
                                  absolutePanel(top = 10, right = 10, checkboxInput("leyenda", "Mostrar leyenda", FALSE),
                                  absolutePanel(id = "logo_tia_cony", class = "card", bottom = 20, left = 60, width = "100%", 
                                                fixed=TRUE, draggable = FALSE, height = "auto", 
                                                tags$a(href='https://www.conacyt.gob.mx', 
                                                tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_conacyt_solo.png',height='40',width='40'))),
                                  absolutePanel(id = "logo_geo", class = "card", bottom = 20, left = 120, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                tags$a(href='https://www.centrogeo.org.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_centrogeo_solo.png',height='40',width='40'))),
                                  ))
                                  ),
                         
                         tabPanel("Pressure",
                                  div(class="outer",
                                      tags$head(includeCSS("styles.css")),
                                      leafletOutput("mapa_pressure", width="100%", height="100%"),
                                      
                                      absolutePanel(top = 10, right = 10, checkboxInput("leyenda", "Mostrar leyenda", FALSE),
                                                    absolutePanel(id = "logo_tia_cony", class = "card", bottom = 20, left = 60, width = "100%", 
                                                                  fixed=TRUE, draggable = FALSE, height = "auto", 
                                                                  tags$a(href='https://www.conacyt.gob.mx', 
                                                                         tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_conacyt_solo.png',height='40',width='40'))),
                                                    absolutePanel(id = "logo_geo", class = "card", bottom = 20, left = 120, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                                  tags$a(href='https://www.centrogeo.org.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_centrogeo_solo.png',height='40',width='40'))),
                                      ))
                         ),
                         
                         tabPanel("State",
                                  div(class="outer",
                                      tags$head(includeCSS("styles.css")),
                                      leafletOutput("mapa_state", width="100%", height="100%"),
                                      
                                      absolutePanel(top = 10, right = 10, checkboxInput("leyenda", "Mostrar leyenda", FALSE),
                                                    absolutePanel(id = "logo_tia_cony", class = "card", bottom = 20, left = 60, width = "100%", 
                                                                  fixed=TRUE, draggable = FALSE, height = "auto", 
                                                                  tags$a(href='https://www.conacyt.gob.mx', 
                                                                         tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_conacyt_solo.png',height='40',width='40'))),
                                                    absolutePanel(id = "logo_geo", class = "card", bottom = 20, left = 120, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                                  tags$a(href='https://www.centrogeo.org.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_centrogeo_solo.png',height='40',width='40'))),
                                      ))
                         ),
                         
                         tabPanel("Impact",
                                  div(class="outer",
                                      tags$head(includeCSS("styles.css")),
                                      leafletOutput("mapa_impact", width="100%", height="100%"),
                                      
                                      absolutePanel(top = 10, right = 10, checkboxInput("leyenda", "Mostrar leyenda", FALSE),
                                                    absolutePanel(id = "logo_tia_cony", class = "card", bottom = 20, left = 60, width = "100%", 
                                                                  fixed=TRUE, draggable = FALSE, height = "auto", 
                                                                  tags$a(href='https://www.conacyt.gob.mx', 
                                                                         tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_conacyt_solo.png',height='40',width='40'))),
                                                    absolutePanel(id = "logo_geo", class = "card", bottom = 20, left = 120, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                                  tags$a(href='https://www.centrogeo.org.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_centrogeo_solo.png',height='40',width='40'))),
                                      ))
                         ),
                         
                         tabPanel("Response",
                                  div(class="outer",
                                      tags$head(includeCSS("styles.css")),
                                      leafletOutput("mapa_response", width="100%", height="100%"),
                                      
                                      absolutePanel(top = 10, right = 10, checkboxInput("leyenda", "Mostrar leyenda", FALSE),
                                                    absolutePanel(id = "logo_tia_cony", class = "card", bottom = 20, left = 60, width = "100%", 
                                                                  fixed=TRUE, draggable = FALSE, height = "auto", 
                                                                  tags$a(href='https://www.conacyt.gob.mx', 
                                                                         tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_conacyt_solo.png',height='40',width='40'))),
                                                    absolutePanel(id = "logo_geo", class = "card", bottom = 20, left = 120, width = "100%", fixed=TRUE, draggable = FALSE, height = "auto",
                                                                  tags$a(href='https://www.centrogeo.org.mx', tags$img(src='https://raw.githubusercontent.com/iskarwaluyo/mapa_agricultura_masaforestal/master/html/logo_centrogeo_solo.png',height='40',width='40'))),
                                      ))
                         )
                         
                         
                         ),
                               
                            tabPanel("Resumen",
                                    includeHTML("https://raw.githubusercontent.com/iskarwaluyo/dpsir_autocorrelation_oaxaca_forest/master/html/resumen.html")
                                )
                         

              )
                        
)

