## create train_variables 
train_variables <- list(
    remove_non_image_post_percentage = FALSE,
    remove_location_tag_percentage = FALSE,
    remove_comments_engagement_rate = FALSE,
    remove_caption_zero = FALSE,
    add_follow_difference = FALSE
)

## Set number of trees
ntree <- 100

## Set number of variables
mtry <- 5

## Set file name
file_name <- "test"

## train the model
model <- train_model(train_variables, ntree, mtry)

## test the model
test(model, train_variables, file_name)

