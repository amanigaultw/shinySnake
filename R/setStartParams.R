setStartParams <- function(){
  
  snakePos <- data.frame(xPos = c(3, 3),
                         yPos = c(3, 2)) 
  
  foodPos <- data.frame(xPos = 8,
                        yPos = 8) 
  
  params <- reactiveValues(gridSize = 11,
                           
                           snakePos = snakePos,
                           snakeSize = 14,
                           snakeColor = "chartreuse4",
                           
                           foodPos = foodPos,
                           foodSize = 10,
                           foodColor = "brown",
                           
                           moveDir = "up",
                           
                           grow = F, 
                           eaten = F,
                           
                           alive = T)
  
  return(params)
}
