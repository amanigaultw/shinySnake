library(shiny)
library(shinyjs)
library(shinythemes)
library(neuralnet)
library(Rcpp)
library(echarts4r)


#load helper functions
fileSources = paste0("R/", list.files(path = "R/", pattern = "*.R"))
sapply(fileSources, source, .GlobalEnv)

#load trained nn models
load("NN/nn1.RData")

#set game speed
game_speed = 100

#load fitness
load("data/fitness.RData")
load("data/snakeJS.RData")

