keyToDir <- function(key){
  
  dir = switch (key,
                "KeyA" = "left",
                "KeyW" = "down",
                "KeyS" = "up",
                "KeyD" = "right",
                "ArrowLeft" = "left",
                "ArrowUp" = "down",
                "ArrowDown" = "up",
                "ArrowRight" = "right")
}