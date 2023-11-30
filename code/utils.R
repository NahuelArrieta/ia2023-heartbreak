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
