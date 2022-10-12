validMove <- function(coords, params){
  valid <- T
  for(j in 1:nrow(params$snakePos)){
    if(params$snakePos$xPos[j] == coords$xPos & params$snakePos$yPos[j] == coords$yPos){
      valid <- F
      break
    }
  }
  if(coords$xPos < 0 | coords$yPos < 0 | coords$xPos > params$gridSize - 1 | coords$yPos > params$gridSize - 1){
    valid <- F
  }
  return(valid)
}