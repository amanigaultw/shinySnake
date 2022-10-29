library(shiny)

#load helper functions
fileSources = paste0("R/", list.files(path = "R/", pattern = "*.R"))
sapply(fileSources, source, .GlobalEnv)

############# PICK YOUR AI #############

# AI <- snakeAI0 # heuristic-based AI; always move towards the target
# AI <- snakeAI1 # random AI; move at random
# AI <- snakeAI2 # neural network AI trained using games played by snakeAI0 (not a very smart AI so far)
# AI <- snakeAI3 # use a path algorithm

############# PICK YOUR AI #############

shinyServer(function(input, output, session) {
  
  #start
  params <- setStartParams()
  keyRecords = reactiveValues()
  
  #handle key inputs
  observeEvent(input$downKey, { 
    keyRecords[[input$downKeyId]] = TRUE 
    keys = reactiveValuesToList(keyRecords)
    lastKey = names(keys[unlist(keys)])[length(names(keys[unlist(keys)]))]
    params <- isolate(handleKeyInputs(params, lastKey))
  })
  observeEvent(input$upKey, { keyRecords[[input$upKeyId]] = FALSE })
  
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
  output$instructionsManual <- renderUI({HTML("Controls: WASD/arrow keys")})
  output$bannerQuote <- renderUI({HTML("<i>“A neural network is the second best way to solve any problem. The best way is to actually understand the problem.”</i> - Unknown")})
  output$descriptionManualMode <- renderUI({HTML("<br>Before trying out different AIs, take a moment to familiarize yourself with the problem at hand; play the game using WASD or arrow keys.  This is especially important if you are not familiar with this game.")})
  
  #toggle
  observe({ 
    toggle(id="radioAI", condition = params$autoMode == T)
    toggle(id="instructionsManual", condition = params$autoMode == F)
    toggle(id="descriptionManualMode", condition = params$autoMode == F)
  })
  
  #handle toggling the app mode
  observeEvent(input$actionMode, {
    params <- toggleAutoMode(params)
    
    if (input$actionMode %% 2 == 1) {
      txt <- "Play the game yourself"
    } else {
      txt <- "Let an AI play the game"
    }
    updateActionButton(session, "actionMode", label = txt)
    })
  
  observeEvent(input$radioAI, {
    params$AI <- isolate(switch(input$radioAI,
                                "1" = snakeAI0,
                                "2" = snakeAI1,
                                "3" = snakeAI2,
                                "4" = snakeAI3,
                                snakeAI3))
    params$path <- isolate(NULL)
  })
  
  #
  
})
