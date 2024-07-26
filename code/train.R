library(randomForest)

get_model <- function(dataframe, train_variables) {
    ## Get the variables
    ntree <- train_variables$ntree
    mtry <- train_variables$mtry

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

train <- function(train_variables, file_name) {
    ## Get dataset
    dataframe <- get_train_df()

    ## Preprocess the dataframe
    preprocess_data <- preprocess(dataframe, train_variables)
    dataframe <- preprocess_data$dataframe

    ## Do cross validation
    folds <- create_folds(dataframe, train_variables$nfolds)

    ## Start empty confusion matrix
    all_confusion_matrix <- matrix(0, 2, 2)

    ## Train the models
    for (i in 1:train_variables$nfolds) {
        ## Get the train and test data
        train_data <- folds %>% filter(fold != i)
        test_data <- folds %>% filter(fold == i)

        ## Train the model
        model <- get_model(train_data, train_variables)

        ## Test the model
        confusion_matrix <- test(model, test_data, train_variables)

        ## Add the confusion matrix
        all_confusion_matrix <- all_confusion_matrix + confusion_matrix
    }

    ## Calculate the average confusion matrix
    all_confusion_matrix <- confusion_matrix / train_variables$nfolds

    ## Print results
    print_results(confusion_matrix, file_name, train_variables, preprocess_data$message)
}
