keyToDir <- function(key){
  
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