paramsToInputs <- function(params){
  
  posVector <- rep(0.5, params$gridSize^2)
  
  for(i in 1:nrow(params$snakePos)){
    index <- coordsToIndex(params$snakePos$xPos[i], params$snakePos$yPos[i], params$gridSize)
    posVector[index] <- 0
  }
  
  index <- coordsToIndex(params$foodPos$xPos, params$foodPos$xPos, params$gridSize)
  posVector[index] <- 1
  
  return(posVector)
}
