library(shiny)
library(shinythemes)
library(fontawesome)
library(gt)
library(curl)

pango_alias_key <- a("cov-lineages / pango-designation / pango_designation / alias_key.json", href = "https://github.com/cov-lineages/pango-designation/blob/master/pango_designation/alias_key.json")


# define UI ---------------------------------------------------------------

ui <- fluidPage(
  
  # set theme and define font to match gt table
  theme = shinythemes::shinytheme("paper"),
  tags$head(tags$style('body {font-family: Roboto;}')),
  
  # GitHub icon and link in the top-right corner
  fluidRow(
    column(12, 
           tags$div(align = "right", 
                    a(href = "https://github.com/sschmutz/pango-lineage-translator", 
                      h4(fontawesome::fa("github", fill = "#B9BABD"))
                    )
           )
    )
  ),
  
  # application title
  tags$div(align = "center", titlePanel(div(HTML("<em>Pango</em> Lineage Translator")))),
  
  # text input and action button
  fluidRow(
    column(12,
           tags$div(align = "center",
                    style = "padding-left:0px; padding-right:0px; padding-top:50px; padding-bottom:0px",
                    textInput(inputId = "lineage",
                              label = NULL,
                              value = "BQ.1.1",
                              width = "100px"))
    )
  ),
  fluidRow(
    column(12,
           tags$div(align = "center",
                    style = "padding-left:0px; padding-right:0px; padding-top:0px; padding-bottom:20px",
                    actionButton(inputId = "translate",
                                 label = "translate")))
  ),
  
  # gt table output
  fluidRow(
    column(12,
           tags$div(align = "center",
                    style = "padding-left:0px; padding-right:0px; padding-top:20px; padding-bottom:20px",
                    gt::gt_output(outputId = "table")))
  ),
  
  fluidRow(
    column(12,
           style = "padding-left:0px; padding-right:0px; padding-top:20px; padding-bottom:20px",
           tagList("Based on:", pango_alias_key), align = "center")
  )
)


# define server logic -----------------------------------------------------

server <- function(input, output) {
  
  # loading the functions within the R/ directory is not necessary
  # since Shiny 1.5.0
  # see https://shiny.rstudio.com/reference/shiny/1.6.0/loadSupport.html
  translation_table <- eventReactive(input$translate, {
    pango_lineage_full <- translate_lineage(input$lineage)
    pango_lineage_full_tibble <- divide_lineage(pango_lineage_full)
    create_pango_lineage_table(pango_lineage_full_tibble)
  })
  
  output$table <-
    gt::render_gt(
      expr = translation_table()
    )
}


# run the application -----------------------------------------------------

shinyApp(ui = ui, server = server)
