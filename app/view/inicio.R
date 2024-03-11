box::use(
  shiny[...],
 readxl[read_xlsx],lubridate,nycflights13,dplyr[mutate,arrange],readr[parse_number,locale]
)

#' @export
ui <- function(id) {  
  ns <- NS(id)
  
  tagList(
    fluidPage(
      fluidRow(
        class = "image-container bg-light d-flex justify-content-center align-items-center", # Adicionada a classe image-container e outras classes de utilidade do Bootstrap
        div(
          #class = "text-center mb-5 mt-3", # Classe text-center para centralizar a imagem e mb-3 para dar uma margem abaixo da imagem
          img(class = "img-fluid logo_maisfort", src="home.png")
        )
      )
    )    
  )
  
}







#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

    })    
}


