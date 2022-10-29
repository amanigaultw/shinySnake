handleKeyInputs <- function(params, key){
  
  if(is.null(key)){
    return(params)
  }
  
  #handle direction input
  moveKeys <- c("KeyA", "KeyW", "KeyS", "KeyD", "ArrowLeft", "ArrowUp", "ArrowDown", "ArrowRight")
  if(params$autoMode == F & key %in% moveKeys){
    params <- setmoveDir(params, keyToDir(key))
  }
 
  return(params) 
}
