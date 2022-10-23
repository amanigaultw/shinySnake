#load trained nn models
load("NN/nnModel.RData")

#pick a model
nn <- nnModel[[1]]

#
library(neuralnet)

snakeAI2 <- function(params){
  
  possibleMoves <- c("left", "up", "down", "right")
  opposite <- switch(params$moveDirOld,
                     "left" = "right",
                     "right" = "left",
                     "up" = "down",
                     "down" = "up")
  possibleMoves <- possibleMoves[!possibleMoves %in% opposite]
  possibleMoves <- sample(possibleMoves, length(possibleMoves), replace = F)
  
  # move using nn prediction
  input <- matrix(paramsToInputs(params), nrow = 1)
  pred <- predict(nn, input)
  colnames(pred) <- c("down", "left", "right", "up")
  pred <- pred[, colnames(pred) %in% possibleMoves]
  best_move <- names(which(pred == max(pred)))
  
  params$moveDir <- best_move
  
  return(params)
}