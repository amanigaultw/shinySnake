library(shiny)

#load helper functions
fileSources = paste0("R/", list.files(path = "R/", pattern = "*.R"))
sapply(fileSources, source, .GlobalEnv)

shinyServer(function(input, output) {
  
  #start
  params <- setStartParams()
  
  #handle key inputs
  observeEvent(input$keys, {
    params <- isolate(handleKeyInputs(params, input$keys))
  })
  
  #update game plot at fixed interval
  observe({
    invalidateLater(200)
    output$plot1 <- renderPlot({
      plotFrame(isolate(update(params)))
    }) 
  })
  
  #update score UI
  output$score <- renderText({paste("Score: ", params$score)})
  
  #set Instructions text output
  output$Instructions <- renderUI({
    if(params$autoMode == F){
      HTML("Controls: WASD/arrow keys") 
    }else{
      HTML("Press M to switch to manual mode")
    }
  })
  
})
