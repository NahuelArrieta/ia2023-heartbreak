## Scale the data
scale_data <- function(dataframe) {
    scaled_dataframe <- as.data.frame(scale(dataframe))
    names(scaled_dataframe) <- names(dataframe)
    return(scaled_dataframe)
}

## Remove caption zero
remove_caption_zero <- function(dataframe) {
    dataframe <- dataframe[, -which(names(dataframe) == "cz")]
    return(dataframe)
}

## Remove non image post percentage
remove_non_image_post_percentage <- function(dataframe) {
    dataframe <- dataframe[, -which(names(dataframe) == "ni")]
    return(dataframe)
}

## Remove location tag percentage
remove_location_tag_percentage <- function(dataframe) {
    dataframe <- dataframe[, -which(names(dataframe) == "lt")]
    return(dataframe)
}

## Remove comments engagement rate
remove_comments_engagement_rate <- function(dataframe) {
    dataframe <- dataframe[, -which(names(dataframe) == "erc")]
    return(dataframe)
}

## Add follow difference
add_follow_difference <- function(dataframe) {
    dataframe$fd <- dataframe$flg - dataframe$flw
    return(dataframe)
}

## Add follow rate
add_follow_rate <- function(dataframe) {
    dataframe$fr <- dataframe$flw / dataframe$flg
    return(dataframe)
}

## Account age
add_account_age <- function(dataframe) {
    ## Calculated as post interval * number of posts
    dataframe$age <- dataframe$pi * dataframe$pos
    return(dataframe)
}

remove_account_age <- function(dataframe) {
    dataframe <- dataframe[, -which(names(dataframe) == "age")]
    return(dataframe)
}

## Add follower frequency
add_follower_frequency <- function(dataframe) {
    ## if age is 0, then the follower frequency is the number of followers
    dataframe$ff <- ifelse(dataframe$age == 0, 
                            dataframe$flw ,
                            round(dataframe$flw / dataframe$age,4))
    return(dataframe)
}

## Add following frequency
add_following_frequency <- function(dataframe) {
    ## if age is 0, then the following frequency is the number of following
    dataframe$fgf <- ifelse(dataframe$age == 0, 
                            dataframe$flg ,
                            round(dataframe$flg / dataframe$age,4))
    return(dataframe)
}

## Add Image frequency
add_image_frequency <- function(dataframe) {
    ## Images are calculated as the number of post minus the number of non image post
    ## If age is zero, there was any post, so the image frequency is zero
    dataframe$ifq <- ifelse(dataframe$age == 0, 
                            0,                
                            round((dataframe$pos - (dataframe$pos * dataframe$ni)) / dataframe$age,4))
    return(dataframe)
}

## Remove num of followers
remove_num_of_followers <- function(dataframe) {
    dataframe <- dataframe[, -which(names(dataframe) == "flg")]
    return(dataframe)
}

## Remove num of following
remove_num_of_following <- function(dataframe) {
    dataframe <- dataframe[, -which(names(dataframe) == "flw")]
    return(dataframe)
}

