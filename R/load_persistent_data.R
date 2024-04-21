load_persistent_data <- function(fitness){
  token <- readRDS("auth/token.rds")
  human_scores_persistent <- drop_read_csv("human_scores_persistent.csv")[,1]
  fitness$human <- human_scores_persistent
  return(fitness)
}