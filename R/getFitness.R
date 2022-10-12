getFitness <- function(AI){
  params <- setStartParams(asReactive = F)
  frames_list <- list()
  i <- 1
  while(params$gameCount < 1){
    params <- update(params, AI)
    if(params$gameCount < 1){
      frames_list[[i]] <- params
      names(frames_list)[i] <- paste0("game", params$gameCount, "-score", params$score, "-frame", params$frame) 
      i <- i + 1
    }
  }
  
  return(frames_list[[length(frames_list)]]$score)
}

