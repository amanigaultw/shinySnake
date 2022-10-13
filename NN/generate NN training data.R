rm(list = ls())

setwd(dirname(dirname(rstudioapi::getActiveDocumentContext()$path)))

#load helper functions
fileSources = paste0("R/", list.files(path = "R/", pattern = "*.R"))
sapply(fileSources, source, .GlobalEnv)

#get frames data from 1000 games running using a simple heuristic AI
if(file.exists("NN/frameData raw.RData")){
  load("NN/frameData raw.RData")
}else{
  #
  params <- setStartParams(asReactive = F)
  
  #
  startTime <- Sys.time()
  frames_list <- list()
  i <- 1
  while(params$gameCount < 1000){
    params <- update(params)
    frames_list[[i]] <- params
    names(frames_list)[i] <- paste0("game", params$gameCount, "-score", params$score, "-frame", params$frame)
    i <- i + 1
    if(i %% 100 == 0){
      print("still running")
      print(params$gameCount)
    }
  }
  endTime <- Sys.time()
  endTime - startTime
  beepr::beep(3)
  
  save(frames_list, file = "NN/frameData raw.RData", compress = "xz") 
}

#examine fitness and get the max score of each game
gameCount <- numeric(length(frames_list))
score <- numeric(length(frames_list))
for(i in 1:length(frames_list)){
  gameCount[i] <- frames_list[[i]]$gameCount
  score[i] <- frames_list[[i]]$score
}
maxScores <- aggregate(score, list(gameCount), max)
names(maxScores) <- c("gameID", "maxScore")
hist(maxScores$maxScore)
median(maxScores$maxScore)

#remove the frames between the last successful score and death
keep <- rep(TRUE, length(frames_list))
for(i in 1:length(frames_list)){
  max <- maxScores$maxScore[maxScores$gameID == frames_list[[i]]$gameCount]
  if(frames_list[[i]]$score == max){
    keep[i] <- FALSE
  }
}
frames_list_success <- frames_list[keep]

data <- matrix(nrow = (length(frames_list_success) - 1), ncol = frames_list_success[[1]]$gridSize^2 + 1)
for(i in 1:(length(frames_list_success) - 1)){
  data[i,] <- c(frames_list_success[[i + 1]]$moveDir, paramsToInputs(frames_list_success[[i]]))
}

colnames(data) <- c("nextMoveDir", paste0("pos", 1:121))

save(data, file = "NN/NN_data.RData")




