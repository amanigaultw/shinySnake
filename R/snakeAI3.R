snakeAI3 <- function(params){
  
  #if no path has been found, try to get one
  if(is.null(params$path)){
    params <- getPath(params)
  }
  
  #if a valid path was found then follow it; else move at random
  if(!is.null(params$path)){
    params$moveDir <- coordsToMoveDir(params$snakePos[1,], params$path[1,])
    params$path <- params$path[-1, ]
  }else{
    params <- snakeAI1(params)
  }
  
  return(params)
}

coordsToMoveDir <- function(coords1, coords2){
  moveDir <- NULL
  if(coords1$xPos + 1 == coords2$xPos & coords1$yPos == coords2$yPos){
    moveDir <- "right"
  }
  if(coords1$xPos - 1 == coords2$xPos & coords1$yPos == coords2$yPos){
    moveDir <- "left"
  }
  if(coords1$xPos == coords2$xPos & coords1$yPos + 1 == coords2$yPos){
    moveDir <- "up"
  }
  if(coords1$xPos == coords2$xPos & coords1$yPos - 1 == coords2$yPos){
    moveDir <- "down"
  }
  moveDir
}
