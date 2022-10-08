die <- function(params){
  params <- eatSelf(params)
  params <- outOfBounds(params)
  return(params)
}

eatSelf <- function(params){
  nextHeadPos <- params$snakePos[1,] + getOffset(params$moveDir)
  willEatSelf <- F
  for(i in 1:nrow(params$snakePos)){
    if(nextHeadPos$xPos == params$snakePos$xPos[i] & nextHeadPos$yPos == params$snakePos$yPos[i]){
      willEatSelf <- T
    }
  }
  if(willEatSelf){
    params$alive <- F
  }
  return(params)
}

outOfBounds <- function(params){
  nextHeadPos <- params$snakePos[1,] + getOffset(params$moveDir)
  if(nextHeadPos$xPos < 0 | nextHeadPos$yPos < 0 | nextHeadPos$xPos > params$gridSize - 1 | nextHeadPos$yPos > params$gridSize - 1){
    params$alive <- F
  }
  return(params)
}
