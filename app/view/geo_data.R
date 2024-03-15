box::use(leaflet[...],
         shiny[...],
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
         tidyr[pivot_longer],
         ../mod/utils[trata_string, week_to_number, number_to_week]
)

dias_da_semana <- c("Segunda-feira", "Terça-feira", "Sábado", "Domingo")
lista_locais <- utils::read.csv("data/locais.csv")
regioes_masp <- utils::read.csv("data/regioes_masp.csv")
colnames(regioes_masp) = c("Local", "10h", "11h", "12h", "13h", "16h", "17h", "18h", "19h", "dia_da_semana")
regioes_masp <- regioes_masp |>
  tidyr::pivot_longer(cols = c("10h", "11h", "12h", "13h", "16h", "17h", "18h", "19h"),
                      names_to = "hora", values_to = "n_pessoas")
regioes_masp <- dplyr::left_join(regioes_masp, lista_locais)

regioes_masp <- regioes_masp |>
  dplyr::mutate(Latitude = as.double(gsub(",", ".", Latitude)),
                Longitude = as.double(gsub(",", ".", Longitude)),
                radius = sqrt(n_pessoas))

# dplyr::mutate(regioes_masp,
#               x = lista_locais[lista_locais["local"] == local][2],
#               y = lista_locais[lista_locais["local"] == local][3])
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
              width = "100%"
            ),
            selectInput(
              inputId = ns("hora"),
              label = h5("Hora", class = "font-weight-bold"),
              choices = c("10h", "11h", "12h", "13h", "16h", "17h", "18h", "19h"),
              width = "100%"
            )
          )
        ),
        div(
          leafletOutput(ns("regioes_plot"), height = "95%"),
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

    output$regioes_plot <- renderLeaflet({
      req(input$dia_semana)
      req(input$hora)

      filtered_points <- regioes_masp |>
        dplyr::filter(dia_da_semana == week_to_number(input$dia_semana)) |>
        dplyr::filter(hora == input$hora) |>
        dplyr::group_by(Local, dia_da_semana, hora) |>
        summarise(total_radius = sum(radius))

      leaflet(filtered_points) |>
        addTiles() |>
        addCircleMarkers(lng=~Longitude, lat=~Latitude, radius = ~total_radius,
                   clusterOptions = markerClusterOptions(zoomToBoundsOnClick = T),
                   # popup = ~paste(
                   #   paste('<b>', 'Local:', '</b>', Local),
                   #   paste('<b>', 'Dia da semana:', '</b>', number_to_week(dia_da_semana)),
                   #   paste('<b>',  'Hora:', '</b>', hora),
                   #   paste('<b>',  'Número de pessoas:', '</b>', n_pessoas),
                   #   sprintf("<a href=https://www.google.com/maps/search/?api=1&query=%f,%f>
                   #         <img src='google_maps_icon_2020.png' alt='Minha Figura'> </a>", Latitude, Longitude),
                   #   sep = '<br/>'),
                   popupOptions = popupOptions(closeButton = FALSE)) #|>
      #addMeasure(localization = "pt_BR", primaryLengthUnit = "kilometers")
    })
  })
}