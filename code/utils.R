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