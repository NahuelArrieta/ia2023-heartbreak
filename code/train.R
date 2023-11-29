library(randomForest)

train_model <- function(train_variables, ntree, mtry) {
    ## Get the dataframe
    dataframe <- get_train_df()

    ## Preprocess the dataframe
    dataframe <- preprocess(dataframe, FALSE)

    ## Train the model
    model <- randomForest(
        formula = is_fake ~ .,
        data = dataframe,
        ntree = ntree,
        mtry = mtry
    )

    return(model)

}