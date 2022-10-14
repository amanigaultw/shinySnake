#clear workspace
rm(list = ls())

#set working directory to whatever directory this file is saved in
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#load data
load("NN_data.RData")

#
library(neuralnet)

#
data <- as.data.frame(data)
data[,-1] <- apply(data[,-1], 2, as.numeric) 

#
data_shuffled <- data[sample(nrow(data)), ]

test <- data_shuffled[0:2000, ]

getNN <- function(data, filename){
  start <- Sys.time()
  nn <- neuralnet::neuralnet(nextMoveDir ~., data, hidden = 10, linear.output = FALSE, threshold = .1)
  save(nn, file = paste0(filename, ".RData"))
  end <- Sys.time()
  print(end - start)
}

getNN(data_shuffled[2001:3000, ], "nn1"); beepr::beep(3)
getNN(data_shuffled[2001:4000, ], "nn2"); beepr::beep(3)
getNN(data_shuffled[2001:6000, ], "nn3"); beepr::beep(3)
getNN(data_shuffled[2001:10000, ], "nn4"); beepr::beep(3)



getStringPred <- Vectorize(vectorize.args = "x",
                           FUN = function(x){
                             switch (x,
                                     "1" = "down",
                                     "2" = "left",
                                     "3" = "right",
                                     "4" = "up")
                           })

evaluatePred <- function(nn, truth){
  pred <- predict(nn, test[,-1])
  pred2 <- apply(pred, 1, function(x) which(x == max(x))[1])
  pred3 <- getStringPred(pred2)
  
  caret::confusionMatrix(table(prediction = pred3, reference = test[,1]))
}

#
load("nn1.RData")
evaluatePred(nn, test[,-1])

load("nn2.RData")
evaluatePred(nn, test[,-1])

load("nn3.RData")
evaluatePred(nn, test[,-1])

load("nn4.RData")
evaluatePred(nn, test[,-1])
