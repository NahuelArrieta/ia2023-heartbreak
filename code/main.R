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
    scale_data = FALSE,
    remove_non_image_post_percentage = FALSE,
    remove_location_tag_percentage = FALSE,
    remove_comments_engagement_rate = FALSE,
    remove_caption_zero = FALSE, 
    add_follow_difference = FALSE,
    add_follow_rate = FALSE,
    add_account_age = FALSE,
    add_follower_frequency = FALSE,
    add_following_frequency = FALSE,
    add_image_frequency = FALSE,
    remove_num_of_followers = FALSE,
    remove_num_of_following = FALSE
)


## Set file name of the output md
file_name <- "follow_diff_without_flg"

## train the model
model <- train_model(train_variables)

## test the model
test(model, train_variables, file_name)

