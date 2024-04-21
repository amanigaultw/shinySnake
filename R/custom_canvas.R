custom_canvas <- function(id, width="500", height="500", style="border:5px solid rgb(0, 0, 0);"){
  div(id = "canvas-container",
      style = "padding:1rem;",
      HTML(paste0('<canvas id="', id, '" width="', width, '" height="', height, '" style="', style, '">Sorry, your browser does not support canvas.</canvas>'))
  )
}
