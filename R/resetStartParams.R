resetStartParams <- function(params){
  
  snakePos <- data.frame(xPos = c(3, 3),
                         yPos = c(3, 2)) 
  
  foodPos <- data.frame(xPos = 8,
                        yPos = 8)
  
  params$snakePos <- snakePos
  params$foodPos <- foodPos
  params$moveDir <- "up"
  params$grow = F
  params$eaten = F
  params$alive = T
  
  params <- getSpawnPos(params)
  
  return(params)
}