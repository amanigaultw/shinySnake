saveFitness <- function(params){
  
  params$lastScore = params$score
  
  if(params$autoMode == F){
    params$fitness$`human` <- c(params$fitness$`human`, params$score)
  }else{
    switch(params$radioAI,
           "1" = {params$fitness$`AI 1` <- c(params$fitness$`AI 1`, params$score)},
           "2" = {params$fitness$`AI 2` <- c(params$fitness$`AI 2`, params$score)},
           "3" = {params$fitness$`AI 3` <- c(params$fitness$`AI 3`, params$score)},
           "4" = {params$fitness$`AI 4` <- c(params$fitness$`AI 4`, params$score)})
  }
  
  fitness <- params$fitness
  save(fitness, file = "data/fitness.RData")
  
  return(params)
}