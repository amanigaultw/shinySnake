spawnFood <- function(params){
  
  if(params$eaten){
    params <- getSpawnPos(params)
    params$eaten <- F
  }
  
  return(params)
}