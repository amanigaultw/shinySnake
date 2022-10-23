plotFrame <- function(params){
  require(ggplot2)
  
  frame <- ggplot()
  
  if(!is.null(params$path)){
    pathPoints <- data.frame(xPos = c(params$snakePos$xPos[1], params$path$xPos),
                             yPos = c(params$snakePos$yPos[1], params$path$yPos))
    frame <- frame + 
      geom_path(aes(pathPoints$xPos, pathPoints$yPos), size = params$pathSize, color = params$pathColor)
  }
  
  frame <- frame + 
    geom_point(aes(params$foodPos$xPos, params$foodPos$yPos), size = params$foodSize, color = params$foodColor) +
    geom_point(aes(params$snakePos$xPos[-1], params$snakePos$yPos[-1]), size = params$snakeSize, color = params$snakeColor) +
    geom_point(aes(params$snakePos$xPos[1], params$snakePos$yPos[1]), size = params$snakeSize, color = params$snakeHeadColor) + 
    scale_x_continuous(breaks = seq(.5, params$gridSize - .5, by = 2), limits = c(0, params$gridSize - 1)) +
    scale_y_continuous(breaks = seq(.5, params$gridSize - .5, by = 2), limits = c(0, params$gridSize - 1)) +
    theme(axis.title.x=element_blank(),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank(),
          axis.title.y=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank()) +
    theme(panel.grid.minor = element_line(size = 1), panel.grid.major = element_line(size = 1))
  
  frame
}
