library(shiny)
library(keys)

hotkeys <- c("a", "w", "s", "d", "left", "up", "down", "right")

shinyUI(fluidPage(
  
  column(8, align="center",
         plotOutput("plot1",
                    width = "400px",
                    height = "400px")
  ),
  
  useKeys(),
  keysInput("keys", hotkeys)
  
))