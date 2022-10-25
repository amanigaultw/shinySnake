keyToDir <- function(key){
  
  dir = switch (key,
                "KeyA" = "left",
                "KeyW" = "up",
                "KeyS" = "down",
                "KeyD" = "right",
                "ArrowLeft" = "left",
                "ArrowUp" = "up",
                "ArrowDown" = "down",
                "ArrowRight" = "right") 
}