update <- function(params, AI){
  
  params$frame <- params$frame + 1
  
  if(params$autoMode){
    params <- params$AI(params)
  }
  
  params <- die(params)
  
  if(params$alive){
    params <- eat(params)
    params <- move(params)
    params <- spawnFood(params) 
  }else{
    params <- saveFitness(params)
    params <- resetStartParams(params)
  }
  
  return(params)
}