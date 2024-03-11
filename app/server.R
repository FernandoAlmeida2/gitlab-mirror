box::use(
  shiny[...],
  shinyjs,
  bs4Dash[...]
)

box::use(
  ./mod/notification[notify],
  ./view/inicio,
  ./view/sobre,
  ./view/sociabilidade,
  ./view/equidade,
  ./view/atividades,
  ./view/acessibilidade,
  ./view/habitabilidade,
  ./view/contexto_urbano,
  ./view/acesso_cultura,
  ./view/geo_data,
  ./view/piloto,
  ./view/equipe_pesquisa
)

#' @export
server <- function(input, output, session) {
  
  useAutoColor()

  query <- isolate(getQueryString())

  observeEvent(input$controlbar, {
    notify(title = if (input$controlbar) "Barra de controle aberta" else "Barra de controle fechada")    
  })

  observeEvent(input$controlbarToggle, {
    updateControlbar(id = "controlbar")
  })

  #########################
  ## Inicializa as views ##
  #########################
  # inicio$server("inicio")
  # sobre$server("sobre")
  # sociabilidade$server("sociabilidade")
  # equidade$server("equidade")
  # atividades$server("atividades")
  # acessibilidade$server("acessibilidade")
  # habitabilidade$server("habitabilidade")
  # contexto_urbano$server("contexto_urbano")
  # acesso_cultura$server("acesso_cultura")
  # geo_data$server("geo_data")
  # equipe_pesquisa$server("equipe_pesquisa")
}