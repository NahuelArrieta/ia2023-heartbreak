
## test the model
validate <- function(train_variables, file_name) {
    ## Get dataset
    dataframe <- get_train_df()

    ## Preprocess the dataframe
    preprocess_data <- preprocess(dataframe, train_variables)
    dataframe <- preprocess_data$dataframe


    ## Train the model
    print("Start training")
    model <- get_model(dataframe, train_variables)
    print("End training")

    ## get validation dataframe
    test_dataframe <- get_test_df()

    ## preprocess the dataframe
    preprocess_data <- preprocess(test_dataframe, train_variables)
    test_dataframe <- preprocess_data$dataframe
    message <- preprocess_data$message
   
    ## predict the test dataframe
    test_dataframe$prediction_class <- predict(model, newdata = test_dataframe, type = "class")

    ## Set class as boolean
    test_dataframe <- test_dataframe %>%
        mutate(prediction_class = ifelse(prediction_class > 0.5, TRUE, FALSE))

    ## Create confusion matrix
    confusion_matrix <- table(test_dataframe$is_fake, test_dataframe$prediction_class)

    print_results(model, confusion_matrix, file_name, train_variables, message)
}
