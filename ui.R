library(shiny)
library(keys)

hotkeys <- c("a", "w", "s", "d", "left", "up", "down", "right")


shinyUI(fluidPage(
  
  #CSS
  tags$head(tags$style("#score{color: black;
                                 font-size: 20px;
                                 font-weight: bold;
                                 }")),
  
  #UI elements
  column(8, align="center",
         textOutput("score"),
         plotOutput("plot1",
                    width = "600px",
                    height = "600px")
  ),
  
  useKeys(),
  keysInput("keys", hotkeys)
  
))