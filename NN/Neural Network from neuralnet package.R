#clear workspace
rm(list = ls())

#set working directory to whatever directory this file is saved in
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#load data
load("NN_data.RData")

#
library(neuralnet)

#set input data to numeric and keep output as character
data <- as.data.frame(data)
data[,-1] <- apply(data[,-1], 2, as.numeric)

#test train split
set.seed(1234)
data_shuffled <- data[sample(nrow(data)), ]
test <- data_shuffled[0:2000, ]

#model training function
getNN <- function(data, filename){
  start <- Sys.time()
  nn <- neuralnet::neuralnet(nextMoveDir ~., data, hidden = c(5,5), linear.output = FALSE, threshold = .2)
  save(nn, file = paste0(filename, ".RData"))
  end <- Sys.time()
  print(end - start)
}

#train models with increasingly more data (can take a while to run)
getNN(data_shuffled[2001:4000, ], "nn1"); beepr::beep(3)
getNN(data_shuffled[2001:6000, ], "nn2"); beepr::beep(3)
getNN(data_shuffled[2001:10000, ], "nn3"); beepr::beep(3)
getNN(data_shuffled[2001:22000, ], "nn4"); beepr::beep(3)

#function to quickly examine model performance
evaluatePred <- function(nn, truth){
  pred <- predict(nn, test[,-1])
  pred2 <- apply(pred, 1, function(x) which(x == max(x))[1])
  pred3 <- getStringPred(pred2)

  caret::confusionMatrix(table(prediction = pred3, reference = test[,1]))
}
#helper function
getStringPred <- Vectorize(vectorize.args = "x",
                           FUN = function(x){
                             switch (x,
                                     "1" = "down",
                                     "2" = "left",
                                     "3" = "right",
                                     "4" = "up")
                           })

#check model accuracy
# I am not expecting high accuracy given that the modeled heuristic AI choices
# are random whenever there is a tie in distance to target occurs.

load("nn1.RData")
nn1 <- nn
load("nn2.RData")
nn2 <- nn
load("nn3.RData")
nn3 <- nn
load("nn4.RData")
nn4 <- nn

evaluatePred(nn1, test[,-1])
evaluatePred(nn2, test[,-1])
evaluatePred(nn3, test[,-1])
evaluatePred(nn4, test[,-1])
