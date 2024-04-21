shinyUI(fluidPage(
  theme = shinytheme("spacelab"),
  useShinyjs(),
  extendShinyjs(text = snakeJS, functions = c("plotFrame")),
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
            tags$script(src="script.js")
  ),
  
  #UI elements
  titlePanel("Shiny Snake: Experimenting with Snake AIs"),
  htmlOutput("bannerQuote"),
  htmlOutput("descriptionManualMode"),
  hr(),
  sidebarLayout(
    sidebarPanel(echarts4rOutput("plot"),
                 h3("Pick a mode:"),
                 actionButton("actionMode", "Play the game yourself"),
                 hr(),
                 htmlOutput("instructionsManual"),
                 radioButtons("radioAI", h3("Choose an AI:"),
                              choices = list("AI 1 (heuristic)" = 1, 
                                             "AI 2 (random)" = 2,
                                             "AI 3 (a bad Neural Network)" = 3,
                                             "AI 4 (pathing)" = 4),
                              selected = 4), 
                 width = 5),
    mainPanel(
      column(12, align="center",
             textOutput("score"),
             custom_canvas(id = "snakeCanvas", width="500", height="500", style="border:5px solid rgb(0, 0, 0);"),
             custom_slider(id = "FPSRange", min = 1, max = 30, value = 15, text = "Frames Per Second")
      ),
      width = 7)),
  hr(),
  htmlOutput("descriptionAIMode")
))