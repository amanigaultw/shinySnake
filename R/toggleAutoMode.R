toggleAutoMode <- function(params){
  params$autoMode <- !params$autoMode
  if(params$autoMode == FALSE){
    params$path <- NULL
  }
  return(params)
}