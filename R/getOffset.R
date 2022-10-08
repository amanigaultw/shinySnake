getOffset <- function(moveDir){
  offset = switch (moveDir,
                   "right" = c(1, 0),
                   "up" = c(0, 1),
                   "down" = c(0, -1),
                   "left" = c(-1, 0))
}