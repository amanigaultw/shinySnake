update <- function(params){
  
  if(params$autoMode){
    params <- params$AI(params)
  }
  
  params <- die(params)
  
  if(params$alive){
    params <- eat(params)
    params <- move(params)
    params <- spawnFood(params) 
  }else{
    params <- resetStartParams(params)
  }
  
  return(params)
}