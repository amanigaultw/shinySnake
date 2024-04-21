shinyUI(fluidPage(
  theme = shinytheme("spacelab"),
  useShinyjs(),
  extendShinyjs(text = snakeJS, functions = c("plotFrame")),
  
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
             div(id = "canvas-container",
                 HTML('<canvas id="snakeCanvas" width="500" height="500" style="border:5px solid rgb(0, 0, 0);">Sorry, your browser does not support canvas.</canvas>')
             ),
             sliderInput("speed_slider", "Set Game Speed (frames per second)", min = 1, max = 60, value = 30),
      ),
      width = 7)),
  hr(),
  htmlOutput("descriptionAIMode")
))