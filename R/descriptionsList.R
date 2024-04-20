descriptionsList <- list("1" = "
                         <b>Description:</b>
                         <br>
                         This AI is based on a simply heuristic rule. 
                         Each turn the player must choose between moving forward, turning left, or turning right. 
                         This AI always picks whichever direction makes the snake move closer to the target (ties are broken at random).
                         This works well initially, but lacks the foresight to anticipate deadends.",
                         "2" = "
                         <b>Description:</b>
                         <br>
                         This AI moves (almost) at random. It does avoid running into walls.",
                         "3" = "
                         <b>Description:</b>
                         <br>
                         This AI is a work in progress. I am hoping to update the underlying neural netwok to be smarter in the future.",
                         "4" = "
                         <b>Description:</b>
                         <br>
                         This AI begins by computing a path to the target, then follows this path. 
                         If the path to the target is currently blocked, the AI moves randomly then tries to compute a path again.")
