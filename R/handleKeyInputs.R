handleKeyInputs <- function(params, key){
  
  if(is.null(key)){
    return(params)
  }
  
  #toggle autoMode
  if(key == "m"){
    params$autoMode <- !params$autoMode
    return(params)
  }
  
  #handle direction input
  moveKeys <- c("a", "w", "s", "d", "left", "up", "down", "right")
  if(params$autoMode == F & key %in% moveKeys){
    params <- setmoveDir(params, keyToDir(key))
  }
 
  return(params) 
}