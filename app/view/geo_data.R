box::use(leaflet[...],
         stringr,
         tidyverse[...],
         geobr[...],
         shiny[...],
         echarts4r[...],
         purrr[...],
         bs4Dash,
         dplyr[
           count,
           summarise,
           filter,
           group_by,
           mutate,
           rename,
           select
         ],
         tidyr[drop_na],
         readxl[...], writexl[...],readr[...],
         shinyWidgets[...],
         ../mod/utils[trata_string]
)

for (i in setores_bugs) {
  setor_bug <- setores_shapes[setores_shapes$NOME %in% i,]
  setores_shapes[setores_shapes$NOME %in% i,]$geometry <- sf::st_convex_hull(setor_bug$geometry)
}

locais <- utils::read.csv("data/locais.csv")
regioes_masp <- utils::read.csv("data/regioes_masp.csv")
#bairros <- c("Todos", sort(unique(bairros_shapes$Nome)))

################################################
###interface e filtros de entrada
################################################
#' @export
ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    tags$head(includeCSS("www/custom.css")),
    tagList(
      div(class = "w-75 pl-2 pt-2 pb-5 mb-5",
          h4("GEODATA"),
          h4("GEODATA", span("Utilização criativa do espaço", class = "font-italic"), class = "text-info"),
          h4("Busca-se uma abordagem holística na concepção dos espaços, encorajando a utilização multifuncional e flexível, adaptável às diferentes atividades e demandas ao longo do tempo.")),
      div(
        class = "coleta-container maps-service d-flex justify-content-between",
        div(
          class = "maps-filter text-primary d-flex align-items-center flex-column",
          div(
            class = "position-relative w-100 logo-wave",
            img(class = "position-absolute z-index-1 top-0 left-0", src="geo_data.png",
                width="30%")
          ),
          h4("Encontre aqui as informações sobre os dias e turno da coleta domiciliar em seu bairro!",
             class="title-option text-start position-relative z-index-2 font-weight-bold"
          ),
          div(
            class = "filter-box",
            h5(class="subtitle-option", "Selecione o seu"),
            selectInput(
              inputId = ns("bairro"),
              label = h5("BAIRRO", class = "font-weight-bold"),
              choices = bairros,
              width = "100%"
            )
          )
        ),
        div(
          leafletOutput(ns("coleta_plot"), height = "95%"),
          class = "maps-plot plot"
        )
      )
    )
  )
}

################################################
###gráficos
################################################
#' @export
server <- function(id) {
  
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    #granja_portugal_I <- setores_shapes[setores_shapes$NOME == "203192 - SER V - GRANJA PORTUGAL I", ]
    
    polygonColors <- list(DIURNO = "#d87a00", NOTURNO = "#255B54", INTEGRAL = "#A50104")
    
    bairros_bug <- dplyr::filter(bairros_shapes, Nome %in% c("Alvaro Weyne",
                                                             "Bairro Ellery",
                                                             "Bom Jardim",
                                                             "Carlito Pamplona",
                                                             "Granja Lisboa",
                                                             "Granja Portugal",
                                                             "Jacarecanga",
                                                             "Monte Castelo",
                                                             "Presidente Kennedy",
                                                             "São Gerardo"))
    
    output$coleta_plot <- renderLeaflet({
      req(input$bairro)
      
      # setores_shapes <- dplyr::mutate(setores_shapes,
      #                                     geometry = sf::st_convex_hull(geometry))
      
      
      if(input$bairro == "Todos") {
        leaflet(data = setores_shapes) |>
          addTiles() |>
          addLegend(position = "topright", colors = polygonColors, labels = c("Diurno", "Noturno", "Integral"),
                    opacity = 1) |>
          #addPolygons(data = bairros_bug, weight = 5, color = "#00ffd8", opacity = 0.5) |>
          addPolygons(weight = 2, color = ~paste(polygonColors[Turno]), opacity = 1,
                      popup = ~paste(
                        paste('<b>', 'Nome:', '</b>', NOME),
                        paste('<b>', 'Dias de coleta:', '</b>', Freq_semanal),
                        paste('<b>',  'Turno:', '</b>', Turno),
                        sep = '<br/>')) 
      } else {
        
        sf::sf_use_s2(TRUE)
        
        bairro_choice_shape <- dplyr::filter(bairros_shapes, Nome == input$bairro)$geometry
        
        # shapeData <- dplyr::mutate(setores_shapes,
        #                                    intersection = sf::st_intersection(geometry, bairro_choice_shape))
        
        intersect_column <- lapply(setores_shapes$geometry, function(setor) {
          #return(sf::st_crosses(sf::st_boundary(bairro_choice_shape), sf::st_boundary(setor))[1] == 1)
          return(sf::st_intersects(bairro_choice_shape, setor)[1] == 1)
        })
        
        setores_shapes$is_intersect <- intersect_column
        intersect_setores <- dplyr::filter(setores_shapes, is_intersect == TRUE)
        
        intersect_setores <- dplyr::mutate(intersect_setores,
                                           geometry = sf::st_intersection(geometry, bairro_choice_shape))
        
        leaflet(data = intersect_setores) |>
          addTiles() |>
          addLegend(position = "topright", colors = polygonColors, labels = c("Diurno", "Noturno", "Integral"),
                    opacity = 1) |>
          addPolygons(weight = 2, color = ~paste(polygonColors[Turno]), opacity = 1,
                      popup = ~paste(
                        paste('<b>', 'Nome:', '</b>', NOME),
                        paste('<b>', 'Dias de coleta:', '</b>', Freq_semanal),
                        paste('<b>',  'Turno:', '</b>', Turno),
                        sep = '<br/>'))
        
      }
      
    })
    
  })
}