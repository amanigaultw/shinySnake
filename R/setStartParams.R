setStartParams <- function(asReactive = TRUE){
  
  params <- list(gridSize = 11,
                 
                 snakePos = data.frame(xPos = c(3, 3),
                                       yPos = c(3, 2)),
                 snakeSize = 24,
                 snakeColor = "chartreuse3",
                 snakeHeadColor = "chartreuse4",
                 
                 foodPos = data.frame(xPos = 8,
                                      yPos = 8) ,
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
                 
                 autoMode = T)
  
  if(asReactive){
    params <- do.call("reactiveValues", params)
  }
  
  return(params)
}
