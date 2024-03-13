box::use(
  shiny[...],
  bs4Dash[...],
  echarts4r[e_theme_register],
  waiter[...],
  fresh[use_theme, use_googlefont,create_theme,bs4dash_sidebar_light, adminlte_color]
)

box::use(
  ./mod/theme[
    diobs_theme,
    font1,
    font2,
    font3,
    main_font,
    secondary_font,
    monospace_font,
    primary
  ],
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
ui <- dashboardPage(
  dark = NULL,
  help = NULL,
  fullscreen = TRUE,
  scrollToTop = TRUE,
  header = dashboardHeader(
    title = dashboardBrand(
      title = "Insper",
      color = "primary",
      href = "https://arqfuturo.com.br/post/laboratorio-arq.futuro-de-cidades-do-insper/",
      image = "logo.png",
      opacity = 1.0
    ),
    tagList(
      div(class = "bg-primary w-100 d-flex justify-content-center",
          a(
            class = "logo_header",
            href = "https://arqfuturo.com.br/post/laboratorio-arq.futuro-de-cidades-do-insper/",
            target = "_blank",
            img(class = "img-fluid logo_header",
                src = "header.png")
          )
      )
    )
  ),
  sidebar = dashboardSidebar(
    fixed = TRUE,
    skin = "light",
    status = "primary",
    id = "sidebar",
    collapsed = TRUE,
    sidebarMenu(
      id = "current_tab",
      flat = FALSE,
      compact = FALSE,
      childIndent = TRUE,
      menuItem(
        "Início",
        tabName = "inicio",
        icon = icon("home")
      ),
      menuItem(
        "Sobre",
        tabName = "sobre",
        icon = icon("circle-info")
      ),
      # menuItem(
      #   "Sociabilidade",
      #   tabName = "sociabilidade",
      #   icon = icon("people-arrows")
      # ),
      # menuItem(
      #   "Equidade",
      #   tabName = "equidade",
      #   icon = icon("people-arrows")
      # ),
      # menuItem(
      #   "Atividades",
      #   tabName = "atividades",
      #   icon = icon("earth-americas")
      # ),
      # menuItem(
      #   "Acessibilidade",
      #   tabName = "acessibilidade",
      #   icon = icon("universal-access")
      # ),
      # menuItem(
      #   "Habitabilidade",
      #   tabName = "habitabilidade",
      #   icon = icon("person-shelter")
      # ),
      # menuItem(
      #   "Contexto urbano",
      #   tabName = "contexto_urbano",
      #   icon = icon("person-shelter")
      # ),
      # menuItem(
      #   "Acesso à Cultura",
      #   tabName = "acesso_cultura",
      #   icon = icon("universal-access")
      # ),
      # menuItem(
      #   "GeoData",
      #   tabName = "geo_data",
      #   icon = icon("map-location-dot")
      # ),
      # menuItem(
      #   "Piloto",
      #   tabName = "piloto",
      #   icon = icon("chair")
      # ),
      menuItem(
        "Equipe de pesquisa",
        tabName = "equipe_pesquisa",
        icon = icon("people-group")
      )
    )
  ),
  body = dashboardBody(
    use_googlefont(font1),
    use_googlefont(font2),
    use_googlefont(font3),
    use_theme(diobs_theme),
    e_theme_register(
      paste(readLines("www/atlas_capital_humano.json"), collapse = ""),
      "diobs"),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    tabItems(
      tabItem(
        tabName = "inicio",
        inicio$ui("inicio")
      ),
      tabItem(
        tabName = "sobre",
        sobre$ui("sobre")
      ),
      # tabItem(
      #   tabName = "sociabilidade",
      #   sociabilidade$ui("sociabilidade")
      # ),
      # tabItem(
      #   tabName = "equidade",
      #   equidade$ui("equidade")
      # ),
      # tabItem(
      #   tabName = "atividades",
      #   atividades$ui("atividades")
      # ),
      # tabItem(
      #   tabName = "acessibilidade",
      #   acessibilidade$ui("acessibilidade")
      # ),
      # tabItem(
      #   tabName = "habitabilidade",
      #   habitabilidade$ui("habitabilidade")
      # ),
      # tabItem(
      #   tabName = "contexto_urbano",
      #   contexto_urbano$ui("contexto_urbano")
      # ),
      # tabItem(
      #   tabName = "acesso_cultura",
      #   acesso_cultura$ui("acesso_cultura")
      # ),
      # tabItem(
      #   tabName = "geo_data",
      #   geo_data$ui("geo_data")
      # ),
      # tabItem(
      #   tabName = "piloto",
      #   piloto$ui("piloto")
      # ),
      tabItem(
        tabName = "equipe_pesquisa",
        equipe_pesquisa$ui("equipe_pesquisa")
      )
    )
  ),
  footer = dashboardFooter(
    left = tagList(
      # Versão mobile
      div(
        class = "bg-primary w-100 d-flex justify-content-center align-items-center p-0",
        style="background-color: #D1464B; height: 5vw; color: white;",
        p(
          "@Insper.",
          format(Sys.Date(), "%Y, "),
          "Laboratório Arq. Futuro de Cidades - Núcleo de Arquitetura e Cidade"
        )
      )
    )
    #,
    # right = tagList(
    #   tags$ul(
    #     id = "footer-logo",
    #     tags$li(
    #       a(
    #         href = "https://arqfuturo.com.br/post/laboratorio-arq.futuro-de-cidades-do-insper/",
    #         target = "_blank",
    #         alt = "",
    #         img(
    #           src = "img/logo-diobs-dark.svg",
    #           height = "30"
    #         )
    #       )
    #     ),
    #   )
    # )
  )
  # title = "Observatório de Resíduos de Fortaleza"
)