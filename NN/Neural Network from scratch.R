#clear workspace
rm(list = ls())

#set working directory to whatever directory this file is saved in
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#load data
load("NN_data.RData")

data[,1] <- ifelse(data[,1] == "left", 0, 
                   ifelse(data[,1] == "up", 1, 
                          ifelse(data[,1] == "right", 2, 
                                 ifelse(data[,1] == "down", 3, NA))))
data <- apply(data, 2, as.numeric)

#turn into a matrix and get number of rows and cols
data <- as.matrix(data)
m = nrow(data)
n = ncol(data)

#shuffle rows
data_shuffled <- data[sample(nrow(data)), ]

#test-train split
data_dev <- t(data_shuffled[0:1000, ])
Y_dev <- data_dev[1,]
X_dev <- data_dev[2:n, ]

data_train <- t(data_shuffled[1000:m, ])
Y_train <- data_train[1,]
X_train <- data_train[2:n, ]

#scale pixel data (to range from 0 to 1)
# X_dev <- X_dev / 255
# X_train <- X_train / 255

X_train <- apply(X_train, 2, as.numeric)


#initialize parameters
init_params <- function(){
  W1 <- matrix(runif(10 * 121, -.5, .5) , nrow = 10, ncol = 121)
  b1 <- matrix(runif(10, -.5, .5), nrow = 10, ncol = 1)
  W2 <- matrix(runif(4 * 10, -.5, .5) , nrow = 4, ncol = 10)
  b2 <- matrix(runif(4, -.5, .5), nrow = 4, ncol = 1)
  
  return(list(W1 = W1,
              b1 = b1,
              W2 = W2,
              b2 = b2))
}

#ReLU function
ReLU <- function(x){
  return(max(0, x))
}

#softmax function
softmax <- function(x){
  stopifnot(is.matrix(x))
  
  temp <- x
  for(i in 1:nrow(x)){
    for(j in 1:ncol(x)){
      temp[i,j] <- exp(x[i, j]) / sum(exp(x[, j]))
    }
  }
  
  return(temp)
}

#forward propagation
forward_prop <- function(params, X){
  Z1 <- params$W1 %*% X + rep(params$b1, each = ncol(X))
  A1 <- apply(Z1, c(1, 2), ReLU)
  Z2 <- params$W2 %*% Z1 + rep(params$b2, each = ncol(X))
  A2 <- softmax(Z2)
  
  return(list(Z1 = Z1,
              A1 = A1,
              Z2 = Z2,
              A2 = A2))
}

#one hot encode function
one_hot <- function(Y){
  temp <- matrix(0, 4, length(Y))
  for(i in 1:length(Y)){
    temp[Y[i] + 1, i] <- 1 #must add plus one because the lowest Y digit is 0 instead of 1
  }
  row.names(temp) <- 0:3
  return(temp)
}

#derivative of ReLU
deriv_ReLU <- function(Z){
  return(+(Z > 0))
}

#backward propagation
back_prop <- function(fparams, params, X, Y){
  m = length(Y)
  one_hot_Y <- one_hot(Y)
  dZ2 = fparams$A2 - one_hot_Y
  dW2 = 1 / m * dZ2 %*% t(fparams$A1)
  db2 = 1 / m * rowSums(dZ2)
  dZ1 = params$W2 %*% dZ2 * deriv_ReLU(fparams$Z1)
  dW1 = 1 / m * dZ1 %*% t(X)
  db1 = 1 / m * rowSums(dZ1)
  
  return(list(dW1 = dW1,
              db1 = db1,
              dW2 = dW2,
              db2 = db2))
}

#update parameters
update_params <- function(params, bparams, alpha){
  W1 = params$W1 - alpha * bparams$dW1
  b1 = params$b1 - alpha * bparams$db1
  W2 = params$W2 - alpha * bparams$dW2
  b2 = params$b2 - alpha * bparams$db2
  
  return(list(W1 = W1,
              b1 = b1,
              W2 = W2,
              b2 = b2))
}

#get model prediction
get_predictions <- function(fparams){
  pred <- numeric()
  for(i in 1:ncol(fparams$A2)){
    pred[i] <- which(fparams$A2[,i] == max(fparams$A2[,i])) - 1
  }
  return(pred)
}

#get accuracy
get_accuracy <- function(predictions, Y){
  stopifnot(length(predictions) == length(Y))
  return(sum(+(predictions == Y)) / length(Y))
}

#gradient descent
# X <- X_train
# Y <- Y_train
# iterations <- 500 
# alpha <- .1
# X_test <- X_dev 
# Y_test <- Y_dev

gradient_descent <- function(X, Y, iterations, alpha, X_test, Y_test){
  params <- init_params()
  W1 <- params$W1
  b1 <- params$b1
  W2 <- params$W2
  b2 <- params$b2
  
  for(i in 1:iterations){
    fparams <- forward_prop(params, X)
    bparams <- back_prop(fparams, params, X, Y)
    params <- update_params(params, bparams, alpha)
    
    if(i %% 10 == 0){ #run this every 10 iterations
      print(paste("Iteration: ", i))
      print(paste("Train Accuracy: ", round(get_accuracy(get_predictions(fparams), Y), 3)))
      print(paste("Test Accuracy: ", round(get_accuracy(get_predictions(forward_prop(params, X_test)), Y_test), 3)))
    }
  }
  
  return(params)
}

#run gradient descent
params <- gradient_descent(X_train, Y_train, 500, .1, X_dev, Y_dev)

#save estimated parameters
save(params, file = "final_params (500 iterations).RData")

#check performance on test data
get_accuracy(get_predictions(forward_prop(params, X_dev)), Y_dev)





