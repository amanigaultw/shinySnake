library(Rcpp)

getPath <- function(params){
  
  path <- initiatepath(params)
  while(!pathCompleted(path, params) && sum(!path$explored) > 0){
    path <- updatepath(path, params)
  }
  
  if(pathCompleted(path, params)){
    path <- prunePath(path, params)
  }else{
    path <- NULL
  }
  
  params$path <- path[-1, ]
  params
}

initiatepath <- function(params){
  data.frame(params$foodPos,
             index = 0, 
             explored = FALSE)
}

getAdjacentCells <- function(pos){
  data.frame(xPos = c(pos$xPos + 1, pos$xPos - 1, pos$xPos, pos$xPos),
             yPos = c(pos$yPos, pos$yPos, pos$yPos + 1, pos$yPos - 1),
             index = pos$index + 1,
             explored = FALSE)
}

updatepath <- function(path, params){
  
  rowToExplore <- which(path$explored == FALSE)[1]
  adjacentCells <- getAdjacentCells(path[rowToExplore, ])
  path$explored[rowToExplore] <- TRUE
  check <- rbind(path[, c(1,2)], params$snakePos[-1,c(1,2)])
  
  validVector <- getValidAdj(as.matrix(adjacentCells[,c(1,2)]), as.matrix(check), params$gridSize)
  validCells <- adjacentCells[validVector,]
  rbind(path, validCells)
}

pathCompleted <- function(path, params){
  sum(duplicated(rbind(path[,c(1,2)], params$snakePos[1,])[,c(1,2)])) > 0
}

prunePath <- function(path, params){
  prunedPath <- path[which(path$xPos == params$snakePos[1,]$xPos & path$yPos == params$snakePos[1,]$yPos),]
  index <- min(prunedPath$index)
  
  while(index > 0){
    nextPath <- path[path$index == index - 1,]
    keep <- logical()
    for(i in 1:nrow(nextPath)){
      keep[i] <- isAdjacent(prunedPath[prunedPath$index == index,], nextPath[i,])
    }
    nextPath <- nextPath[keep,]
    prunedPath <- rbind(prunedPath, nextPath[1,])
    index <- min(prunedPath$index)
  }
  
  return(prunedPath) 
}

isAdjacent <- function(coords1, coords2){
  adjacent <- FALSE
  if(coords1$xPos + 1 == coords2$xPos & coords1$yPos == coords2$yPos){
    adjacent <- TRUE
  }
  if(coords1$xPos - 1 == coords2$xPos & coords1$yPos == coords2$yPos){
    adjacent <- TRUE
  }
  if(coords1$xPos == coords2$xPos & coords1$yPos + 1 == coords2$yPos){
    adjacent <- TRUE
  }
  if(coords1$xPos == coords2$xPos & coords1$yPos - 1 == coords2$yPos){
    adjacent <- TRUE
  }
  adjacent
}

cppFunction('LogicalVector getValidAdj(NumericMatrix adj, NumericMatrix check, int size) {
  
  int nrow = adj.nrow();
  LogicalVector out(nrow);
  int limit = size - 1;
  int nrowc = check.nrow(); 
  
  for(int i = 0; i < nrow; ++i) {
    out[i] = true;
    int x = adj(i,0);
    int y = adj(i,1);
    
    if((x < 0) | (y < 0) | (x > limit) | (y > limit)){
    out[i] = false;
    }
    
    for(int j = 0; j < nrowc; ++j){
      if((x == check(j,0)) & (y == check(j,1))){
        out[i] = false;
      }
    }
  }
  
  return out;
}')
