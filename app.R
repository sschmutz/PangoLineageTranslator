library(shiny)
library(shinythemes)
library(fontawesome)
library(gt)
library(curl)

pango_alias_key <- a("cov-lineages / pango-designation / pango_designation / alias_key.json", href = "https://github.com/cov-lineages/pango-designation/blob/master/pango_designation/alias_key.json")

# set-up to allow pressing the enter key instead of the action button
# as described here:
# https://stackoverflow.com/questions/50705288/shiny-using-enter-key-with-action-button-on-login-screen
js <- '
$(document).keyup(function(event) {
  if ($("#lineage").is(":focus") && (event.keyCode == 13)) {
      $("#translate").click();
  }
});
'

# define UI ---------------------------------------------------------------

ui <- fluidPage(
  
  # required for the enter key press
  tags$script(HTML(js)),
  
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
  tags$div(align = "center", titlePanel(
    title = div(HTML("<em>Pango</em> Lineage Translator")),
    windowTitle = "Pango Lineage Translator")),
  
  # text input and action button
  fluidRow(
    column(12,
           tags$div(align = "center",
                    style = "padding-left:0px; padding-right:0px; padding-top:50px; padding-bottom:0px",
                    textInput(inputId = "lineage",
                              label = NULL,
                              value = "BQ.1.1",
                              placeholder = "Enter Lineage",
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
  
  options(shiny.sanitize.errors = FALSE)
  
  # loading the functions within the R/ directory is not necessary
  # since Shiny 1.5.0
  # see https://shiny.rstudio.com/reference/shiny/1.6.0/loadSupport.html
  
  translation_table <- reactive({
    req(input$translate)
    
    isolate({
      pango_lineage_full <- translate_lineage(input$lineage)
      pango_lineage_full_tibble <- divide_lineage(pango_lineage_full)
      color_vector <- VOC_color(pango_lineage_full)
      create_pango_lineage_table(pango_lineage_full_tibble, color_vector)
    })
  })
  
  output$table <-
    gt::render_gt(
      expr = translation_table()
    )
}


# run the application -----------------------------------------------------

shinyApp(ui = ui, server = server)
