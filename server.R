library(shiny)

#load helper functions
fileSources = paste0("R/", list.files(path = "R/", pattern = "*.R"))
sapply(fileSources, source, .GlobalEnv)

############# PICK YOUR AI #############

# AI <- snakeAI0 # heuristic-based AI; always move towards the target
# AI <- snakeAI1 # random AI; move at random
# AI <- snakeAI2 # neural network AI trained using games played by snakeAI0 (not a very smart AI so far)
AI <- snakeAI3 # use a path algorithm

############# PICK YOUR AI #############

shinyServer(function(input, output) {
  
  #start
  params <- setStartParams()
  
  #handle key inputs
  keyRecords = reactiveValues()
  observeEvent(input$downKey, { 
    keyRecords[[input$downKeyId]] = TRUE 
    keys = reactiveValuesToList(keyRecords)
    lastKey = names(keys[unlist(keys)])[length(names(keys[unlist(keys)]))]
    params <- isolate(handleKeyInputs(params, lastKey))
  });
  observeEvent(input$upKey, { keyRecords[[input$upKeyId]] = FALSE });
  
  #update game plot at fixed interval
  observe({
    invalidateLater(400)
    output$plot1 <- renderPlot({
      plotFrame(isolate(update(params, AI)))
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
