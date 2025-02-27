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
    if (train_variables$scale_data) {
        dataframe <- scale_data(dataframe)
        message <- paste(message, "- Scale data \n")
    }

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

    if (train_variables$add_following_frequency) {
        dataframe <- add_following_frequency(dataframe)
        message <- paste(message, "- Add following frequency \n")
    }

    if (train_variables$add_image_frequency) {
        dataframe <- add_image_frequency(dataframe)
        message <- paste(message, "- Add image frecuency \n")
    }

    if (train_variables$remove_num_of_followers) {
        dataframe <- remove_num_of_followers(dataframe)
        message <- paste(message, "- Remove number of followers \n")
    }

    if (train_variables$remove_num_of_following) {
        dataframe <- remove_num_of_following(dataframe)
        message <- paste(message, "- Remove number of following \n")
    }

    if (train_variables$remove_follower_keywords) {
        dataframe <- remove_follower_keywords(dataframe)
        message <- paste(message, "- Remove follower keywords \n")
    }

    if (train_variables$remove_has_picture) {
        dataframe <- remove_has_picture(dataframe)
        message <- paste(message, "- Remove has picture \n")
    }

    if (train_variables$remove_bio_length) {
        dataframe <- remove_bio_length(dataframe)
        message <- paste(message, "- Remove bio length \n")
    }

    if (train_variables$remove_post_interval) {
        dataframe <- remove_post_interval(dataframe)
        message <- paste(message, "- Remove post interval \n")
    }

    if (train_variables$remove_promotional_keywords) {
        dataframe <- remove_promotional_keywords(dataframe)
        message <- paste(message, "- Remove promotional keywords \n")
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
