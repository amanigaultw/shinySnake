library(shiny)
library(keys)

hotkeys <- c("a", "w", "s", "d", "left", "up", "down", "right")


shinyUI(fluidPage(
  
  #CSS
  tags$head(tags$style("#score{color: black;
                                 font-size: 30px;
                                 font-weight: bold;
                                 }")),
  
  #UI elements
  column(8, align="center",
         textOutput("score"),
         plotOutput("plot1",
                    width = "500px",
                    height = "500px"),
         textOutput("Instructions")
  ),
  
  #hidden inputs
  useKeys(),
  keysInput("keys", hotkeys)
  
))