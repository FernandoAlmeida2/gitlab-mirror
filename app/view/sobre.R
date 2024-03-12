box::use(
  shiny[...]
)
box::use(
  bs4Dash[...]
)


#' @export
ui <- function(id) {  
  ns <- NS(id)
  tagList(
    fluidPage(
      tabBox(
        # title = p(
        #   class="text-uppercase font-weight-bold",
        #   "Residuômetro ",
        #   span(sprintf("(Ano Base: %04d)", lubridate::year(Sys.Date())), class = "font-italic small")
        # ),
        elevation = 2,
        id = "aba_sobre",
        width = 12,
        collapsible = FALSE,
        closable = FALSE,
        type = "tabs",
        status = "primary",
        solidHeader = TRUE,
        selected = "O que é?",
        tabPanel(
          "O que é?",
          tagList(
            div(
              class = "w-75 pl-2 pt-2 pb-5 mb-5",
              h4(span("Placemaking", class = "font-italic"), " MASP"),
              h5("\u0022O MASP, museu diverso, inclusivo e plural, tem a missão de estabelecer, 
              de maneira crítica e criativa, diálogos entre passado e presente, culturas e territórios, a 
              partir das artes visuais. Para tanto, deve ampliar, preservar, pesquisar e difundir seu acervo, 
              bem como promover o encontro entre públicos e arte por meio de experiências\u0022.", class = "text-info"),
              h5("Missão do Museu de Arte de São Paulo", class = "text-info"),
              h5("A aprendizagem baseada em projetos se trata de uma metodologia transdisciplinar e colaborativa 
                que estimula o envolvimento dos alunos em desafios e tarefas com o intuito de elaborar um 
                produto ou projeto que aponte uma solução para um problema da realidade concreta da cidade."),
              h5(span("Placemaking", class = "font-italic"), "MASP é um",
                span("projeto de pesquisa aplicada do Insper", class = "font-weight-bold"), " para o desenho de 
                estratégias urbanas baseadas na análise de dados e evidências da vida pública no entorno do MASP 
                com o objetivo de tornar o espaço do Vão Livre num lugar inclusivo, ativo, acessível e habitável."),
              h5("A pesquisa busca compreender os condicionantes das relações estabelecidas entre os ", 
                span("espaços livres do MASP e seu entorno", class = "font-weight-bold"),
                  "o que permitem fornecer dados para uma estratégia de intervenção e gestão do ",
                span("Vão Livre", class = "font-weight-bold"))
            )
          )
        ),
        tabPanel(
          tags$span("Valores fundamentais", class = "font-italic"),
          tagList(
            div(
              class = "d-flex justify-content-center",
              img(class = "img-fluid logo_sobre", src="logo_sobre.png")
            ),
            div(
              class = "w-75 pl-2 pt-2 pb-5 mb-5",
              h5("SOCIABILIDADE", class = "font-italic"),
              h5("Inclusão e engajamento"),
              h5("O Placemaking valoriza a participação ativa das comunidades locais no processo de concepção e 
                 revitalização de espaços. Isso envolve a coleta de ideias, feedback e contribuições dos 
                 residentes para garantir que os espaços atendam às suas necessidades e interesses.", br(),
                 "Para isso, a pesquisa analisa quem, quando, como e onde as pessoas usam os espaços livres."),
              h5("ATIVIDADES", class = "font-italic"),
              h5("Utilização criativa do espaço"),
              h5("Busca-se uma abordagem holística na concepção dos espaços, encorajando a utilização 
                 multifuncional e flexível, adaptável às diferentes atividades e demandas ao longo do tempo."),
              h5("ACESSIBILIDADE", class = "font-italic"),
              h5("Acessibilidade e conectividade"),
              h5("A acessibilidade é um aspecto-chave do Placemaking, garantindo que os lugares sejam 
                 facilmente acessíveis para todos, independentemente de idade, habilidade ou condição 
                 socioeconômica. Além disso, a conectividade com outras áreas da cidade é promovida para 
                 integrar os lugares à sua vizinhança."),
              h5("HABITABILIDADE", class = "font-italic"),
              h5("Identidade e cultura local"),
              h5("Valoriza a identidade única de cada lugar, promovendo a expressão da cultura local e 
                 preservando a história e as características distintivas da comunidade.")
            )
          )
        ),
        tabPanel(
          tags$span("A pergunta da pesquisa", class = "font-italic"),
          tagList(
            div(
              class = "w-75 pl-2 pt-2 pb-5 mb-5",
              h5("A pergunta da pesquisa:", class = "font-weight-bold mb-4"),
              h5("Quais são os condicionantes (físicos, espaciais, sociais, culturais, econômicos e jurídicos)
                 das relações estabelecidas entre os espaços livres do MASP e seu entorno que permitem fornecer
                 os dados qualitativos e quantitativos para uma estratégia de intervenção e gestão do Vão Livre?",
                 class = "text-info mb-4"),
              h5("O conceito e método do Placemaking e sua contribuição à atuação do Masp:", class = "font-weight-bold mb-4"),
              h5("Entender e capitalizar o potencial de atração de pessoas e implantação de atividades e 
                 organizar subsídios para a conceituação de ações para tornar o Vão Livre um lugar na 
                 cidade dedicado à vivência da arte, compreendendo:"),
              p("- os vínculos entre pessoas e o espaço,", class = "ml-3"),
              p("- o potencial de conexão da vida cotidiana ao Museu e à arte;",  class = "ml-3"),
              p("- realizar levantamento de dados e evidências a partir de observações e análises 
                    (diversidade de pessoas, quantos passam pelo local, quantos olham, quem permanece, 
                    por quanto tempo, o que fazem, o que acontece)", class = "ml-3"),
              p("- integrar um projeto de usos, inclusão, acessibilidade e habitabilidade.", class = "ml-3 mb-4"),
              h5("O conceito e método do Placemaking e sua contribuição ao ensino no Insper:", class = "font-weight-bold mb-4"),
              h5("A aprendizagem baseada em projetos se trata de uma metodologia transdisciplinar e colaborativa 
                 que estimula o envolvimento dos alunos em desafios e tarefas com o intuito de elaborar um 
                 produto ou projeto que aponte uma solução para um problema da realidade concreta da cidade.")
            )
          )
        ),
        tabPanel(
          tags$span("Filosofia", class = "font-italic"),
          tagList(
            div(
              class = "w-75 pl-2 pt-2 pb-5 mb-5",
              h5("Placemaking é simultaneamente ", span("filosofia e método", class = "font-weight-bold"),
                "concreto para a revitalização de espaços públicos. Ele se concentra em observar, escutar e 
                 questionar as pessoas que residem, trabalham e se divertem em determinadas áreas, visando 
                 compreender suas necessidades e aspirações para o espaço e para a comunidade como um todo.",
                 class = "font-italic"),
            ),
            div(
              #class = "d-flex justify-content-center",
              img(class = "img-fluid info_filosofia", src="info_filosofia.png")
            )
          )
        ),
        tabPanel(
          tags$span("Project for public spaces",  class = "font-italic"),
          tagList(
            div(
              class = "w-75 pl-2 pt-2 pb-5 mb-5",
              h5("Placemaking", class = "font-italic"),
              h5("\u0022Placemaking inspira as pessoas a reimaginar e reinventar coletivamente os espaços 
                 públicos como o coração de cada comunidade. Fortalecendo a ligação entre as pessoas e os 
                 lugares que partilham, placemaking refere-se a um processo colaborativo através do qual 
                 podemos moldar o nosso espaço público, a fim de maximizar o valor partilhado. 
                 Mais do que apenas promover um melhor design urbano, o placemaking facilita padrões criativos 
                 de utilização, prestando especial atenção às identidades físicas, culturais e sociais que 
                 definem um lugar e apoiam a sua evolução contínua.\u0022.", class = "text-info"),
              h5("Project for public spaces", class = "text-info"),
              h5(span("Placemaking", class = "font-italic"), "é o",
                 span("processo", class = "font-weight-bold"), " de transformação de um espaço em um lugar 
                 vibrante e acolhedor para a comunidade que dele participa, introduzindo uma série de elementos 
                 inspirados pela testagem e observação, definidos pelas parcerias construídas, que façam com que 
                 as pessoas se sintam acolhidas, confortáveis e pertencentes."),
              h5("A", span("criação de lugares", class = "font-weight-bold"), " supera sua concepção física, 
                 envolvendo parâmetros como sociabilidade, usos, atividades, acessos, conexões, conforto e 
                 imagem, de modo a criar vínculos entre pessoas e o que, então, será entendido como lugar."),
              h5("O objetivo é a", span("transformação de espaços públicos", class = "font-weight-bold"),
                 " buscando criar oportunidades para estreitar as conexões entre as pessoas e esses locais."),
              h5("Princípios:"),
              h5("1  ",span("Lugares", class = "text-primary font-weight-bold"), " não projetos"),
              h5("2  Tenha uma ",span("visão", class = "text-primary font-weight-bold")),
              h5("3  Você pode ", span("enxergar muito", class = "font-weight-bold"), "apenas",
                 span("observando", class = "text-primary font-weight-bold")),
              h5("4  A",span("comunidade", class = "text-primary font-weight-bold"), " é quem sabe"),
              h5("5  A", span("forma", class = "text-primary font-weight-bold"), " dá suporte à ",
                 span("função", class = "text-primary font-weight-bold")),
              h5("6  Triângulação (",span("agregar", class = "text-primary font-weight-bold"), " pessoas)"),
              h5("7  ", span("Experimentação:", class = "text-primary font-weight-bold"), " leve, rápido e barato)"),
              h5("8  ", span("Parceiros", class = "text-primary font-weight-bold")),
              h5("9  ", span("Nunca", class = "text-primary font-weight-bold"), span(" acaba", class = "text-primary")),
              h5("Estruturado a partir da",
                 span("participação cidadã e a coleta de dados", class = "font-weight-bold"),
                 "  e evidências, Placemaking é um método de estudo e desenho para a integração de ações 
                 norteadas em quatro dimensões: "),
              h5("- Sociabilidade e equidade"),
              h5("- Atividades e usos"),
              h5("- Acessibilidade e segurança"),
              h5("- Conforto e habitabilidade")
            )
          )
        ),
        tabPanel(
          tags$span("Metodologia", class = "font-italic"),
          tagList(
            div(
              class = "w-75 pl-2 pt-2 pb-5 mb-5",
              h5("Metodologia - ", span("Placemaking", class = "font-italic"), " DATA"),
              h5(span("Placemaking", class = "font-italic"), " DATA é a ferramenta de visualização
              interativa para a análise de dados qualitativos e quantitativos sobre a vida pública da cidade."),
              h5("SOCIABILIDADE", class = "font-weight-bold my-3"),
              h5("Um lugar para as pessoas e criado pelas pessoas; a diversidade e equidade no uso é fundamental.",
                 br(), "Dados analisados:", br(), "- Número de pessoas observadas por hora e por região",
                 br(), "- Número médio de pessoas observadas em cada espaço de análise",
                 br(), "- Número médio de pessoas observadas por hora e dia da semana",
                 br(), "- Número médio de pessoas observadas em cada subespaço"),
              h5("ATIVIDADES", class = "font-weight-bold my-3"),
              h5("As atividades são os ingredientes básicos dos lugares: são as razões pelas quais as pessoas 
                 os visitam, ficam e retornam. São também o que torna um lugar especial ou único."),
              h5("ACESSIBILIDADE", class = "font-weight-bold my-3"),
              h5("A qualidade de acesso ao espaço depende das condições físicas e visuais e o grau de 
                 integração com o entorno.  "),
              h5("HABITABILIDADE", class = "font-weight-bold my-3"),
              h5("Identidade e cultura local"),
              h5("A qualidade de habitar integra os elementos físicos e o ambiente que incidem nas percepções 
                 sobre segurança, limpeza e disponibilidade de lugares para sentar.")
            )
          )
        )
      )
    )  
  )
}

aba_sobre <- function(ns, x) {
  # tagList(
  #   fluidRow(
  #     valueBox(
  #       value = h5(textOutput(ns(sprintf("residometro_%s_total", x))), style="color: #255B54; font-weight: 700;"),
  #       subtitle = p("Total", style="color: #255B54;"),
  #       color = "success",
  #       icon = icon("trash"),
  #       width = 2
  #     ),
  #     valueBox(
  #       value = h5(textOutput(ns(sprintf("residometro_%s_total_coleta_domiciliar", x))), style="font-weight: 700;"),
  #       subtitle = p("Coleta Domiciliar"),
  #       color = "primary",
  #       icon = icon("trash"),
  #       width = 3
  #     ),
  #     valueBox(
  #       value = h5(textOutput(ns(sprintf("residometro_%s_total_especial_urbana", x))), style="font-weight: 700;"),
  #       subtitle = p("Coleta Especial Urbana"),
  #       color = "primary",
  #       icon = icon("trash"),
  #       width = 3
  #     ),
  #     valueBox(
  #       value = h5(textOutput(ns(sprintf("residometro_%s_total_podacao", x))), style="font-weight: 700;"),
  #       subtitle = p("Poda"),
  #       color = "primary",
  #       icon = icon("trash"),
  #       width = 2
  #     ),
  #     valueBox(
  #       value = h5(textOutput(ns(sprintf("residometro_%s_total_entulho", x))), style="font-weight: 700;"),
  #       subtitle = p("Entulho"),
  #       color = "primary",
  #       icon = icon("trash"),
  #       width = 2
  #     )
  #     # valueBox(
  #     #   value = h5(textOutput(ns(sprintf("residometro_%s_total_coleta_seletiva", x))), style="font-weight: 700;"),
  #     #   subtitle = p("Coleta Seletiva"),
  #     #   color = "primary",
  #     #   icon = icon("trash"),
  #     #   width = 2
  #     # )
  #   ),
  #   div(
  #     class = "filter-box w-50",
  #     uiOutput(ns(paste0("input_residometro_", x)))
  #   ),
  #   fluidRow(
  #     box(
  #       title =  div(
  #         "Peso líquido por regional (t) - ",
  #         span(textOutput(ns(paste0("title_regional_", x)), inline = TRUE), class = "font-italic small")
  #       ),
  #       elevation = 4,
  #       closable = FALSE,
  #       width = 12,
  #       solidHeader = TRUE,
  #       status = "primary",
  #       collapsible = FALSE,
  #       shinycssloaders::withSpinner(
  #         type = 8,
  #         color = "#0e2e45",
  #         echarts4rOutput(ns(sprintf("residometro_%s_regional", x)))
  #       )
  #     ),
  #     box(
  #       title = div(
  #         "Peso líquido por território (t) - ",
  #         span(textOutput(ns(paste0("title_territorio_", x)), inline = TRUE), class = "font-italic small")
  #       ),
  #       elevation = 4,
  #       closable = FALSE,
  #       width = 12,
  #       solidHeader = TRUE,
  #       status = "primary",
  #       collapsible = FALSE,
  #       shinycssloaders::withSpinner(
  #         type = 8,
  #         color = "#0e2e45",
  #         echarts4rOutput(ns(sprintf("residometro_%s_territorio", x)))
  #       )
  #     )
  #   ),
  #   if (x == "anual") {
  #     fluidRow(
  #       box(
  #         title = "Peso líquido total em toneladas (série histórica)",
  #         elevation = 4,
  #         closable = FALSE,
  #         width = 12,
  #         solidHeader = TRUE,
  #         status = "primary",
  #         collapsible = FALSE,
  #         shinycssloaders::withSpinner(
  #           type = 8,
  #           color = "#0e2e45",
  #           echarts4rOutput(ns("residometro_anual_heatmap"))
  #         )          
  #         
  #       )        
  #     )
  #   }
  # )
}






#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {

    })    
}


