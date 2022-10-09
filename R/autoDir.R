autoDir <- function(params){
  
  possibleMoves <- c("left", "up", "down", "right")
  opposite <- switch(params$moveDirOld,
                     "left" = "right",
                     "right" = "left",
                     "up" = "down",
                     "down" = "up")
  possibleMoves <- possibleMoves[!possibleMoves %in% opposite]
  possibleMoves <- sample(possibleMoves, length(possibleMoves), replace = F)
  
  best_distance <- Inf
  best_move <- NULL
  for(i in 1:length(possibleMoves)){
    coords <- params$snakePos[1,] + getOffset(possibleMoves[i])
    distance <- abs(coords$xPos - params$foodPos$xPos) + abs(coords$yPos - params$foodPos$yPos)
    if(distance < best_distance){
      best_distance <- distance
      best_move <- possibleMoves[i]
    }
  }
  
  params$moveDir <- best_move
  
  return(params)
}