library(readr)

## Get the dataframe
get_dataframe <- function(file_path) {
    dataframe <-  readr::read_csv(file_path)
    return(dataframe)
}

## Get train dataframe 
get_train_df <- function() {
    file_path <- "dataset/fake_accounts_train.csv"
    dataframe <- get_dataframe(file_path)
    return(dataframe)
}

## Get test dataframe
get_test_df <- function() {
    file_path <- "dataset/fake_accounts_test.csv"
    dataframe <- get_dataframe(file_path)
    return(dataframe)
}

