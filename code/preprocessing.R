preprocess <- function(dataframe, train_variables) {
    ## Set class as boolean
    dataframe$is_fake <- ifelse(dataframe$class == "f", TRUE, FALSE)

    ## Remove class column
    dataframe <- dataframe[, -which(names(dataframe) == "class")]

    ## start message as empty
    message_title <- "\n ## The following preprocessing steps will be applied: \n"
    message <- ""

    ## Always add account age for avoid calculating it multiple times
    dataframe <- add_account_age(dataframe)

    ## Modify the dataframe according to the train variables
    if (train_variables$remove_non_image_post_percentage) {
        dataframe <- remove_non_image_post_percentage(dataframe)
        message <- paste(message, "- Remove non image post percentage \n")
    }

    if (train_variables$remove_location_tag_percentage) {
        dataframe <- remove_location_tag_percentage(dataframe)
        message <- paste(message, "- Remove location tag percentage \n")
    }

    if (train_variables$remove_comments_engagement_rate) {
        dataframe <- remove_comments_engagement_rate(dataframe)
        message <- paste(message, "- Remove comments engagement rate \n")
    }

    if (train_variables$remove_caption_zero) {
        dataframe <- remove_caption_zero(dataframe)
        message <- paste(message, "- Remove caption zero \n")
    }

    if (train_variables$add_follow_difference) {
        dataframe <- add_follow_difference(dataframe)
        message <- paste(message, "- Add follow difference \n")
    }

    if (train_variables$add_follow_rate) {
        dataframe <- add_follow_rate(dataframe)
        message <- paste(message, "- Add follow rate \n")
    }

    if (train_variables$add_follower_frequency) {
        dataframe <- add_follower_frequency(dataframe)
        message <- paste(message, "- Add follower frequency \n")
    }

    ## Remove account age if not needed
    if (!train_variables$add_account_age) {
        dataframe <- remove_account_age(dataframe)
    } else {
        message <- paste(message, "- Add account age \n")
    }

    ## If no preprocessing steps are applied, set message to "No preprocessing steps will be applied"
    if (message == "") {
        message <- "No preprocessing steps will be applied\n"
    }
    message <- paste(message_title, message)
    

    preprocess_data <- list(
        dataframe = dataframe,
        message = message
    )

    return(preprocess_data)
}
