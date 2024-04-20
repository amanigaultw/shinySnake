plotFrame <- function(params){
  # require(ggplot2)
  # require(quickPlot)
  # 
  # frame <- ggplot()
  # 
  # if(!is.null(params$path)){
  #   pathPoints <- data.frame(xPos = c(params$snakePos$xPos[1], params$path$xPos),
  #                            yPos = c(params$snakePos$yPos[1], params$path$yPos))
  #   frame <- frame + 
  #     geom_path(aes(pathPoints$xPos, pathPoints$yPos), size = params$pathSize, color = params$pathColor)
  # }
  # 
  # frame <- frame + 
  #   geom_point(aes(params$foodPos$xPos, params$foodPos$yPos), size = params$foodSize, color = params$foodColor) +
  #   geom_point(aes(params$snakePos$xPos[-1], params$snakePos$yPos[-1]), size = params$snakeSize, color = params$snakeColor) +
  #   geom_point(aes(params$snakePos$xPos[1], params$snakePos$yPos[1]), size = params$snakeSize, color = params$snakeHeadColor) + 
  #   scale_x_continuous(breaks = seq(.5, params$gridSize - .5, by = 2), limits = c(0, params$gridSize - 1)) +
  #   scale_y_continuous(breaks = seq(.5, params$gridSize - .5, by = 2), limits = c(0, params$gridSize - 1)) +
  #   theme(axis.title.x=element_blank(),
  #         axis.text.x=element_blank(),
  #         axis.ticks.x=element_blank(),
  #         axis.title.y=element_blank(),
  #         axis.text.y=element_blank(),
  #         axis.ticks.y=element_blank()) +
  #   theme(panel.grid.minor = element_line(size = 1), 
  #         panel.grid.major = element_line(size = 1))
  # 
  # return(quickPlot::Plot(frame, title = F, speedup = 100))
  
  return('
shinyjs.plotFrame = function(inputs) {
  
  const params = inputs[0];
  
  const dim = params.gridSize
  const canvas = document.getElementById("snakeCanvas");
  canvas.clientWidth = canvas.clientHeight;
  const ctx = canvas.getContext("2d");
  const height_pxl = canvas.clientHeight;
  const unit_pxl = height_pxl / dim;

  drawFrame();
  
  function drawFrame(){
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    drawGrid(dim);
    if(params.path !== null){
      for(var i = 0; i < params.path.xPos.length - 1; i++){
        drawPath(params.path.xPos[i], params.path.yPos[i], params.path.xPos[i + 1], params.path.yPos[i + 1]);
      }
    }
    drawFood(params.foodPos.xPos[0], params.foodPos.yPos[0]); 
    for(var i = params.snakePos.xPos.length - 1; i >= 0; i--){
      if (i === 0){
        drawSnakeHead(params.snakePos.xPos[i], params.snakePos.yPos[i]); 
      }else{
        drawSnakeBody(params.snakePos.xPos[i], params.snakePos.yPos[i]); 
      }
    }
  }
  
  function drawPath(x1, y1, x2, y2, color = "pink"){
    x_start = unit_pxl * x1 + unit_pxl / 2;
    y_start = unit_pxl * y1 + unit_pxl / 2;
    x_end = unit_pxl * x2 + unit_pxl / 2;
    y_end = unit_pxl * y2 + unit_pxl / 2;
    ctx.beginPath();
    ctx.strokeStyle = color;
    ctx.lineCap = "round";
    ctx.lineWidth = 10;
    ctx.moveTo(x_start, y_start);
    ctx.lineTo(x_end, y_end);
    ctx.stroke();
  }
  
  function drawSnakeHead(i, j, color = "#06a94d"){
      ctx.fillStyle = color;
      size = unit_pxl + unit_pxl / 5;
      x = unit_pxl * i + unit_pxl / 2;
      y = unit_pxl * j + unit_pxl / 2;
      ctx.beginPath();
      ctx.arc(x, y, size / 2, 0, 2 * Math.PI);
      ctx.fill();
  }
  
  function drawSnakeBody(i, j, color = "#07da63"){
      ctx.fillStyle = color;
      size = unit_pxl + unit_pxl / 5;
      x = unit_pxl * i + unit_pxl / 2;
      y = unit_pxl * j + unit_pxl / 2;
      ctx.beginPath();
      ctx.arc(x, y, size / 2, 0, 2 * Math.PI);
      ctx.fill();
  }
  
  
  function drawFood(i, j, color = "red"){
      ctx.fillStyle = color;
      size = unit_pxl - unit_pxl / 10;
      x = unit_pxl * i + unit_pxl / 2;
      y = unit_pxl * j + unit_pxl / 2;
      ctx.beginPath();
      ctx.arc(x, y, size / 2, 0, 2 * Math.PI);
      ctx.fill();
  }
  
  function drawCell(i, j){
      margin = unit_pxl / 20
      x = unit_pxl * i + margin;
      y = unit_pxl * j + margin;
      size = unit_pxl - unit_pxl / 10;
      ctx.fillRect(x, y, size, size);
  }
  
  function drawGrid(dim, color = "#E5E4E2"){
      ctx.fillStyle = color;
  
      for (var i = 0; i < dim; i ++){
          for (var j = 0; j < dim; j ++){
              drawCell(i, j);
          }
      }
  }
}')
}
