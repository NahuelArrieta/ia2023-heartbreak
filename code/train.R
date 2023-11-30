library(randomForest)

train_model <- function(train_variables, ntree, mtry) {
    ## Get the dataframe
    dataframe <- get_train_df()

    ## Preprocess the dataframe
    preprocess_data <- preprocess(dataframe, train_variables)
    dataframe <- preprocess_data$dataframe

    ## Train the model
    model <- randomForest(
        formula = is_fake ~ .,
        data = dataframe,
        ntree = ntree,
        mtry = mtry
    )

    return(model)

}
