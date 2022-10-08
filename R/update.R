update <- function(params){
  
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