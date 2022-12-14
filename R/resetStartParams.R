resetStartParams <- function(params){
  
  params$snakePos <- data.frame(xPos = c(3, 3),
                                yPos = c(3, 2)) 
  params <- getSpawnPos(params)
  params$moveDir <- "up"
  params$moveDirOld = "up"
  params$grow = F
  params$eaten = F
  params$alive = T
  params$score = 0
  params$gameCount <- params$gameCount + 1
  params$frame = 0
  params$path = NULL
  
  return(params)
}