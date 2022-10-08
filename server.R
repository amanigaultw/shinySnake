library(shiny)

#load helper functions
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
fileSources = paste0("R/", list.files(path = "R/", pattern = "*.R"))
sapply(fileSources, source, .GlobalEnv)

shinyServer(function(input, output) {
  
  #start
  params <- setStartParams()
  
  #handle key inputs
  observeEvent(input$keys, {
    params <- isolate(setmoveDir(params, keyToDir(input$keys)))
  })
  
  #update
  observe({
      invalidateLater(250)
      output$plot1 <- renderPlot({
        plotFrame(isolate(update(params)))
      }) 
  })

})
