eat <- function(params){
  
  #compute proposed head position
  nextHeadPos <- params$snakePos[1,] + getOffset(params$moveDir)
  
  #eat
  if(nextHeadPos$xPos == params$foodPos$xPos & nextHeadPos$yPos == params$foodPos$yPos){
    params$grow <- T
    params$eaten <- T
    params$score <- params$score + 1
    params$path <- NULL
  }
  
  return(params)
}