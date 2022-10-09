move <- function(params){
  
  #compute new head position
  newHeadPos <- params$snakePos[1,] + getOffset(params$moveDir)
  
  #update body position (growth is the default)
  params$snakePos <- rbind(newHeadPos, params$snakePos)
  
  #deal with growth or lack thereof
  if(params$grow){
    params$grow <- FALSE
  }else{
    params$snakePos <- params$snakePos[-nrow(params$snakePos), ]
  }
  
  #update moveDirOld
  params$moveDirOld <- params$moveDir
  
  return(params)
}