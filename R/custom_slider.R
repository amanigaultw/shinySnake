custom_slider <- function(id, min = 1, max = 30, value = 15, text = ""){
  div(id = "slide-container",
      HTML(paste0('<input type="range" min="', min, '" max="', max, '" value="', value, '" class="slider" id="', id, '"></input>
                   <output>', value, '</output><p>', text, '</p>'
                  ))
  )
}