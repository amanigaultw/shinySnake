library(shiny)
library(shinyjs)
library(shinythemes)
library(neuralnet)
library(Rcpp)


#load helper functions
fileSources = paste0("R/", list.files(path = "R/", pattern = "*.R"))
sapply(fileSources, source, .GlobalEnv)

#load trained nn models
load("NN/nn1.RData")

game_speed = 100


