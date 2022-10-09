getSpawnPos <- function(params){
  
  #generate a vector of all possible food spawn positions
  possibleSpawns <- rep(1, params$gridSize^2)
  
  #identify food spawn positions that would overlap with snake positions
  for(i in 1:nrow(params$snakePos)){
    index <- coordsToIndex(params$snakePos$xPos[i], params$snakePos$yPos[i], params$gridSize)
    possibleSpawns[index] <- 0
  }
  
  #remove food spawn positions that would overlap with snake positions
  possibleIndexes <- which(possibleSpawns == 1)
  
  #randomly select a position from the vector
  chosenIndex <- sample(possibleIndexes, 1)
  
  #get the corresponding coordinates
  chosenCoords <- indexToCoords(chosenIndex, params$gridSize)
  
  #update the params object
  params$foodPos$xPos <- chosenCoords$x
  params$foodPos$yPos <- chosenCoords$y
  
  return(params)
}