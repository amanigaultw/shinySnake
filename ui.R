library(shiny)
library(keys)

hotkeys <- c("a", "w", "s", "d", "left", "up", "down", "right",
             "m")


shinyUI(fluidPage(
  
  #key inputs
  useKeys(),
  keysInput("keys", hotkeys),
  
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