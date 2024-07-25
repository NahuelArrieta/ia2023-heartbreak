library(dplyr)

## test the model
test <- function(model, test_dataframe, train_variables) {   
    ## predict the test dataframe
    test_dataframe$prediction_class <- predict(model, newdata = test_dataframe, type = "class")

    ## Set class as boolean
    test_dataframe <- test_dataframe %>%
        mutate(prediction_class = ifelse(prediction_class > 0.5, TRUE, FALSE))

    ## Create confusion matrix
    confusion_matrix <- table(test_dataframe$is_fake, test_dataframe$prediction_class)

    return(confusion_matrix)

    print("Test complete.")
}
