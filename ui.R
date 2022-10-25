library(shiny)

shinyUI(fluidPage(
  
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
  column(8, align="center",
         textOutput("score"),
         plotOutput("plot1",
                    width = "500px",
                    height = "500px"),
         htmlOutput("Instructions")
  )
  
))