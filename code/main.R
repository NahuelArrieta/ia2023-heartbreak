## Run other scripts
source("code/preprocessing.R")
source("code/get_dataset.R")
source("code/train.R")
source("code/test.R")
source("code/utils.R")
source("code/cross_validation.R")
source("code/validate.R")
source("code/print_results.R")

library(readr)
library(randomForest)
library(dplyr)

## create train_variables 
train_variables <- list(
    ntree = 100,
    mtry = 5,
    nfolds = 5,
    scale_data = FALSE,
    remove_non_image_post_percentage = FALSE,
    remove_location_tag_percentage = FALSE,
    remove_comments_engagement_rate = FALSE,
    remove_caption_zero = FALSE, 
    add_follow_difference = FALSE,
    add_follow_rate = TRUE,
    add_account_age = FALSE,
    add_follower_frequency = FALSE,
    add_following_frequency = FALSE,
    add_image_frequency = FALSE,
    remove_num_of_followers = FALSE,
    remove_num_of_following = FALSE,
    remove_follower_keywords = FALSE,
    remove_has_picture = FALSE,
    remove_bio_length = FALSE,
    remove_post_interval = FALSE,
    remove_promotional_keywords = FALSE
)

file_name <- "add_follow_difference"

train(train_variables, file_name)

# validate(train_variables, file_name)

