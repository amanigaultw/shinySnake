keyToDir <- function(key){
  
  dir = "up" #default move direction when key is NULL
  
  if(!is.null(key) & length(key) == 1){
    dir = switch (key,
                  "a" = "left",
                  "w" = "up",
                  "s" = "down",
                  "d" = "right",
                  "left" = "left",
                  "up" = "up",
                  "down" = "down",
                  "right" = "right") 
  }
}