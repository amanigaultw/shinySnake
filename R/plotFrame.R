plotFrame <- function(params){
  require(ggplot2)
  
  ggplot() + 
    geom_point(aes(params$foodPos$xPos, params$foodPos$yPos), size = params$foodSize, color = params$foodColor) +
    geom_point(aes(params$snakePos$xPos, params$snakePos$yPos), size = params$snakeSize, color = params$snakeColor) + 
    scale_x_continuous(breaks = seq(.5, params$gridSize - .5, by = 2), limits = c(0, params$gridSize - 1)) +
    scale_y_continuous(breaks = seq(.5, params$gridSize - .5, by = 2), limits = c(0, params$gridSize - 1)) +
    theme(axis.title.x=element_blank(),
          axis.text.x=element_blank(),
          axis.ticks.x=element_blank(),
          axis.title.y=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank())
}
