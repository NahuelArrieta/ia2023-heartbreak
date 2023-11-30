preprocess <- function(dataframe, train_variables) {
    ## Set class as boolean
    dataframe$is_fake <- ifelse(dataframe$class == "f", TRUE, FALSE)

    ## Remove class column
    dataframe <- dataframe[, -which(names(dataframe) == "class")]

    ## start message as empty
    message_title <- "\n ## The following preprocessing steps will be applied: \n"
    message <- ""

    ## Modify the dataframe according to the train variables
    if (train_variables$remove_non_image_post_percentage) {
        ## Remove non image post percentage
        message <- paste(message, "- Remove non image post percentage \n")
    }

    if (train_variables$remove_location_tag_percentage) {
        ## Remove location tag percentage
        message <- paste(message, "- Remove location tag percentage \n")
    }

    if (train_variables$remove_comments_engagement_rate) {
        ## Remove comments engagement rate
        message <- paste(message, "- Remove comments engagement rate \n")
    }

    if (train_variables$remove_caption_zero) {
        ## Remove caption zero
        message <- paste(message, "- Remove caption zero \n")
    }

    if (train_variables$add_follow_difference) {
        ## Add follow difference
        message <- paste(message, "- Add follow difference \n")
    }

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
