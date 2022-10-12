snakeAI1 <- function(params){
  
  possibleMoves <- c("left", "up", "down", "right")
  opposite <- switch(params$moveDirOld,
                     "left" = "right",
                     "right" = "left",
                     "up" = "down",
                     "down" = "up")
  possibleMoves <- possibleMoves[!possibleMoves %in% opposite]
  possibleMoves <- sample(possibleMoves, length(possibleMoves), replace = F)
  
  # move at random
  best_move <- NULL
  for(i in 1:length(possibleMoves)){
    coords <- params$snakePos[1,] + getOffset(possibleMoves[i])
    
    if(!validMove(coords, params)){
      next
    }
    
    best_move <- possibleMoves[i]
  }
  
  if(is.null(best_move)){
    params$alive <- F
    return(params)
  }
  
  params$moveDir <- best_move
  
  return(params)
}
