## Run other scripts
source("code/preprocessing.R")
source("code/get_dataset.R")
source("code/train.R")
source("code/test.R")
source("code/utils.R")

library(readr)
library(randomForest)
library(dplyr)

## create train_variables 
train_variables <- list(
    ntree = 100,
    mtry = 5,
    remove_non_image_post_percentage = TRUE,
    remove_location_tag_percentage = TRUE,
    remove_comments_engagement_rate = TRUE,
    remove_caption_zero = TRUE, 
    add_follow_difference = TRUE,
    add_follow_rate = TRUE
)


## Set file name
file_name <- "follow_rate"

## train the model
model <- train_model(train_variables)

## test the model
test(model, train_variables, file_name)

