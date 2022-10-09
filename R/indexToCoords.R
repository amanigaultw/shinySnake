indexToCoords <- function(index, gridSize){
  x <- floor((index - 1) / gridSize)
  y <- (index - 1) %% gridSize
  
  return(list(x = x,
              y = y))
}