setStartParams <- function(asReactive = TRUE){
  
  params <- list(gridSize = 11,
                 
                 snakePos = data.frame(xPos = c(8, 8),
                                       yPos = c(8, 7)),
                 snakeSize = 24,
                 snakeColor = "chartreuse3",
                 snakeHeadColor = "chartreuse4",
                 
                 foodPos = data.frame(xPos = 3,
                                      yPos = 3) ,
                 foodSize = 10,
                 foodColor = "brown",
                 
                 moveDir = "up",
                 moveDirOld = "up",
                 
                 grow = F, 
                 eaten = F,
                 
                 gameCount = 0,
                 frame = 0,
                 score = 0,
                 alive = T,
                 
                 autoMode = T,
                 
                 path = NULL,
                 pathSize = 4,
                 pathColor = "pink")
  
  if(asReactive){
    params <- do.call("reactiveValues", params)
  }
  
  return(params)
}
