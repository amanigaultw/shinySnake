paramsToInputs <- function(params){
  
  posVector <- rep(0.66, params$gridSize^2)
  
  index <- coordsToIndex(params$snakePos$xPos[1], params$snakePos$yPos[1], params$gridSize)
  posVector[index] <- 0
  
  for(i in 2:nrow(params$snakePos)){
    index <- coordsToIndex(params$snakePos$xPos[i], params$snakePos$yPos[i], params$gridSize)
    posVector[index] <- .33
  }
  
  index <- coordsToIndex(params$foodPos$xPos, params$foodPos$xPos, params$gridSize)
  posVector[index] <- 1
  
  return(posVector)
}
