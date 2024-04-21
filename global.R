library(shiny)
library(shinyjs)
library(shinythemes)
library(neuralnet)
library(Rcpp)
library(echarts4r)
library(rdrop2)

#load helper functions
fileSources = paste0("R/", list.files(path = "R/", pattern = "*.R"))
sapply(fileSources, source, .GlobalEnv)

#set game speed
game_speed = 100

#load trained nn models
load("NN/nn1.RData")

#load fitness
load("data/fitness.RData") |> load_persistent_data()

#load snake.js file as a string for extendShinyjs() to consume
load("data/snakeJS.RData")

#uploading persistent data to Dropbox
onStop(function() {
  drop_upload("data/human_scores_persistent.csv")
})