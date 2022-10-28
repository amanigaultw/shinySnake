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
  
  validVector <- rep(TRUE, 4)
  for(i in 1:nrow(adjacentCells)){
    coords <- adjacentCells[i, ]
    if(sum(duplicated(rbind(path, coords)[,c("xPos", "yPos")])) > 0){ #first check if the adjacent cell has already been mapped
      validVector[i] <- FALSE
      next
    }
    if(coords$xPos < 0 | coords$yPos < 0 | coords$xPos > params$gridSize - 1 | coords$yPos > params$gridSize - 1){
      validVector[i] <- FALSE
      next
    }
    if(sum(duplicated(rbind(params$snakePos[-1,], coords[, c("xPos", "yPos")]))) > 0){
      validVector[i] <- FALSE
      next
    }
  }
  validCells <- adjacentCells[validVector,] #keep the rows that passed both checks
  rbind(path, validCells)
}

pathCompleted <- function(path, params){
  sum(duplicated(rbind(path[,c("xPos", "yPos")], params$snakePos[1,])[,c("xPos", "yPos")])) > 0
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