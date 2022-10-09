setmoveDir <- function(params, dir){
  
  opposite <- switch(params$moveDirOld,
                     "left" = "right",
                     "right" = "left",
                     "up" = "down",
                     "down" = "up")
  
  if(dir != opposite){
    params$moveDir <- dir
  }
  
  return(params)
} 