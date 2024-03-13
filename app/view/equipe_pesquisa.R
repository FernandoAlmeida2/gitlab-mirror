box::use(
  shiny[...]
)

#' @export
ui <- function(id) {  
  ns <- NS(id)
  
  tagList(
    fluidPage(
      fluidRow(
        class = "image-container d-flex justify-content-center align-items-center p-0 m-0", # Adicionada a classe image-container e outras classes de utilidade do Bootstrap
        div(
          class = "my-5", # Classe text-center para centralizar a imagem e mb-3 para dar uma margem abaixo da imagem
          img(class = "img-fluid", src="equipe.png", style = "width: 65vw")
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