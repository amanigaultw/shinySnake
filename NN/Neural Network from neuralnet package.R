#clear workspace
rm(list = ls())

#set working directory to whatever directory this file is saved in
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#load data
load("NN_data.RData")

#
library(neuralnet)

#
dim(data)
data <- as.data.frame(data)
data[,-1] <- apply(data[,-1], 2, as.numeric) 

#
data_shuffled <- data[sample(nrow(data)), ]

test <- data_shuffled[0:2000, ]


train <- data_shuffled[2001:4000, ]
nn <- neuralnet(nextMoveDir ~., train, hidden = 10, linear.output = FALSE)
save(nn, file = "nn1.RData")

train <- data_shuffled[2001:8000, ]
nn <- neuralnet(nextMoveDir ~., train, hidden = 10, linear.output = FALSE)
save(nn, file = "nn2.RData")

train <- data_shuffled[2001:16000, ]
nn <- neuralnet(nextMoveDir ~., train, hidden = 10, linear.output = FALSE)
save(nn, file = "nn3.RData")

train <- data_shuffled[2001:32000, ]
nn <- neuralnet(nextMoveDir ~., train, hidden = 10, linear.output = FALSE)
save(nn, file = "nn4.RData")



pred <- predict(nn, test[,-1])
pred2 <- apply(pred, 1, function(x) which(x == max(x))[1])
getStringPred <- Vectorize(vectorize.args = "x",
                 FUN = function(x){
                   switch (x,
                           "1" = "down",
                           "2" = "left",
                           "3" = "right",
                           "4" = "up")
                 })
pred3 <- getStringPred(pred2)

caret::confusionMatrix(table(prediction = pred3, reference = test[,1]))

