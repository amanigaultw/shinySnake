downKeyCount = 0;
$(document).on("keydown", function (e) {
  Shiny.onInputChange("downKey", downKeyCount++);
  Shiny.onInputChange("downKeyId", e.code);
});

upKeyCount = 0;
$(document).on("keyup", function (e) {
  Shiny.onInputChange("upKey", upKeyCount++);
  Shiny.onInputChange("upKeyId", e.code);
});

$(document).on("shiny:connected", function() {
  var slider = document.getElementById("FPSRange");
  Shiny.setInputValue("speed_slider", slider.value);
  slider.oninput = function() {
    Shiny.setInputValue("speed_slider", this.value);
    this.nextElementSibling.value = this.value
  }
});