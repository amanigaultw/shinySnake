library(shiny)
library(shinyjs)
library(shinythemes)

shinyUI(fluidPage(
  theme = shinytheme("spacelab"),
  useShinyjs(),
  
  #key inputs
  ## keydown
  tags$script('
    downKeyCount = 0;
    $(document).on("keydown", function (e) {
       Shiny.onInputChange("downKey", downKeyCount++);
       Shiny.onInputChange("downKeyId", e.code);
    });'
  ),
  ## keyup
  tags$script('
    upKeyCount = 0;
    $(document).on("keyup", function (e) {
       Shiny.onInputChange("upKey", upKeyCount++);
       Shiny.onInputChange("upKeyId", e.code);
    });'
  ),
  
  #CSS
  tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
  
  #UI elements
  titlePanel("Shiny Snake: Experimenting with Snake AIs"),
  htmlOutput("bannerQuote"),
  htmlOutput("descriptionManualMode"),
  hr(),
  sidebarLayout(
    sidebarPanel(h3("Pick a mode:"),
                 actionButton("actionMode", "Let an AI play the game"),
                 hr(),
                 htmlOutput("instructionsManual"),
                 radioButtons("radioAI", h3("Choose an AI:"),
                              choices = list("AI 1 (heuristic)" = 1, 
                                             "AI 2 (random)" = 2,
                                             "AI 3 (a bad Neural Network)" = 3,
                                             "AI 4 (pathing)" = 4),
                              selected = 4)),
    mainPanel(
      column(12, align="center",
             textOutput("score"),
             plotOutput("plot1",
                        width = "500px",
                        height = "500px")
             )
    )),
  hr()
))