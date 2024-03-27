box::use(leaflet[...],
         shiny[...],
         bs4Dash[valueBox],
         dplyr[
           count,
           summarise,
           filter,
           group_by,
           mutate,
           rename,
           select
         ],
         tidyr[pivot_longer],
         ../mod/utils[trata_string, number_to_week]
)

dias_da_semana <- c("Segunda-feira", "Terça-feira", "Sábado", "Domingo")
lista_locais <- utils::read.csv("data/locais.csv")
lista_locais <- dplyr::mutate(lista_locais,
                              Latitude = as.double(gsub(",", ".", Latitude)),
                              Longitude = as.double(gsub(",", ".", Longitude)))

regioes_masp <- utils::read.csv("data/regioes_masp.csv")
colnames(regioes_masp) = c("Local", "10h", "11h", "12h", "13h", "16h", "17h", "18h", "19h", "dia_da_semana")
regioes_masp <- regioes_masp |>
  tidyr::pivot_longer(cols = c("10h", "11h", "12h", "13h", "16h", "17h", "18h", "19h"),
                      names_to = "hora", values_to = "n_pessoas") |>
  dplyr::mutate(dia_da_semana = number_to_week(dia_da_semana))


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
          # h4("Busca-se uma abordagem holística na concepção dos espaços, 
          #    encorajando a utilização multifuncional e flexível, 
          #    adaptável às diferentes atividades e demandas ao longo do tempo.")
          ),
      div(
        class = "coleta-container maps-service d-flex justify-content-between",
        div(
          class = "maps-filter text-primary d-flex align-items-center flex-column",
          # div(
          #   class = "position-relative w-100 logo-wave",
          #   img(class = "position-absolute z-index-1 top-0 left-0", src="geo_data.png",
          #       width="30%")
          # ),
          h4("Visão espacial: Regiões Masp"),
          div(
            class = "filter-box",
            selectInput(
              inputId = ns("dia_semana"),
              label = h5("Dia da semana", class = "font-weight-bold"),
              choices = dias_da_semana,
              selected = c("Segunda-feira"),
              multiple = TRUE,
              width = "70%",
            ),
            selectInput(
              inputId = ns("hora"),
              label = h5("Hora", class = "font-weight-bold"),
              choices = c("10h", "11h", "12h", "13h", "16h", "17h", "18h", "19h"),
              selected = c("10h"),
              multiple = TRUE,
              width = "70%"
            )
          )
        ),
        div(
          leafletOutput(ns("regioes_plot"), height = "95%"),
          class = "maps-plot plot"
        )
      ),
      fluidRow(
        valueBox(
          value = h5(textOutput(ns(sprintf("media_%s_calcada", "pessoas"))), style="color: #255B54; font-weight: 700;"),
          subtitle = p("Média na calçada", style="color: #255B54;"),
          color = "success",
          icon = icon("people-group"),
          width = 4
        ),
        valueBox(
          value = h5(textOutput(ns(sprintf("media_%s_vao", "pessoas"))), style="font-weight: 700;"),
          subtitle = p("Média no vão"),
          color = "maroon",
          icon = icon("people-group"),
          width = 4
        ),
        valueBox(
          value = h5(textOutput(ns(sprintf("media_%s_mirante", "pessoas"))), style="font-weight: 700; color: #000;"),
          subtitle = p("Média no Mirante", style="color: #000;"),
          color = "teal",
          icon = icon("people-group"),
          width = 4
        )
      ),
      
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
    
    divisor_media <- reactive({
      req(input$dia_semana)
      req(input$hora)
      
      length(input$dia_semana) * length(input$hora) # produto das inputs selecionadas
      
    })
    
    pontos_filtrados <- reactive({
      req(input$dia_semana)
      req(input$hora)
      
      regioes_masp |>
        dplyr::filter(dia_da_semana %in% input$dia_semana) |>
        dplyr::filter(hora %in% input$hora) |>
        dplyr::group_by(Local) |>
        dplyr::summarise(total_pessoas = sum(n_pessoas)) |>
        dplyr::left_join(lista_locais) |>
        dplyr::mutate(radius = 3 * sqrt(total_pessoas))
      
    })
    

    output$regioes_plot <- renderLeaflet({
     


      leaflet(pontos_filtrados()) |>
        addTiles() |>
        addCircleMarkers(lng=~Longitude, lat=~Latitude, radius = ~radius, stroke = FALSE,
                         fillOpacity = 0.6,
                   #clusterOptions = markerClusterOptions(zoomToBoundsOnClick = T),
                   popup = ~paste(
                     paste('<b>', 'Local:', '</b>', Local),
                     paste('<b>',  'Total de pessoas:', '</b>', total_pessoas),
                     sprintf("<a href=https://www.google.com/maps/search/?api=1&query=%f,%f>
                           <img src='google_maps_icon_2020.png' alt='Minha Figura'> </a>", Latitude, Longitude),
                     sep = '<br/>'),
                   popupOptions = popupOptions(closeButton = FALSE)) #|>
        #setView(lng = -46.6558819,15, lat = -23.561414, zoom = 50) # see also fitBounds
      #addMeasure(localization = "pt_BR", primaryLengthUnit = "kilometers")
    })
    
    output$media_pessoas_calcada <-  renderText({
      req(input$dia_semana)
      req(input$hora)
      pessoas_calcada <- pontos_filtrados() |>
        dplyr::filter(substr(Local, 1, 1) == "C")
      
      sprintf("%s pessoas", round(sum(pessoas_calcada[, "total_pessoas"]) / divisor_media(), 0))
    })
    
    output$media_pessoas_vao <-  renderText({
      
      pessoas_vao <- pontos_filtrados() |>
        dplyr::filter(substr(Local, 1, 1) == "V")
      
      sprintf("%s pessoas", round(sum(pessoas_vao[, "total_pessoas"]) / divisor_media(), 0))
    })
    output$media_pessoas_mirante <-  renderText({
      pessoas_mirante <- pontos_filtrados() |>
        dplyr::filter(substr(Local, 1, 1) == "M")
      
      sprintf("%s pessoas", round(sum(pessoas_mirante[, "total_pessoas"]) / divisor_media(), 0))
    })
    
    
  })
}