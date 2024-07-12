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

    print("Start training model...")

    ## Train the model
    model <- randomForest(
        formula = is_fake ~ .,
        data = dataframe,
        ntree = ntree,
        mtry = mtry,
        na.action = na.omit
    )

    print("Train model complete.")

    return(model)

}
