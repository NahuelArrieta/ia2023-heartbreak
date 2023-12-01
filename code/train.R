library(randomForest)

train_model <- function(train_variables) {
    ## Get the dataframe
    dataframe <- get_train_df()

    ## Get the variables
    ntree <- train_variables$ntree
    mtry <- train_variables$mtry

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
