setStartParams <- function(){
  
  snakePos <- data.frame(xPos = c(3, 3),
                         yPos = c(3, 2)) 
  
  foodPos <- data.frame(xPos = 8,
                        yPos = 8) 
  
  params <- reactiveValues(gridSize = 11,
                           
                           snakePos = snakePos,
                           snakeSize = 24,
                           snakeColor = "chartreuse3",
                           snakeHeadColor = "chartreuse4",
                           
                           foodPos = foodPos,
                           foodSize = 10,
                           foodColor = "brown",
                           
                           moveDir = "up",
                           moveDirOld = "up",
                           
                           grow = F, 
                           eaten = F,
                           
                           score = 0,
                           alive = T)
  
  return(params)
}
