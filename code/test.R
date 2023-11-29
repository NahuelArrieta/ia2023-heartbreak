library(dplyr)

## test the model
test <- function(model, train_variables) {
    ## get validation dataframe
    test_dataframe <- get_test_df()

    ## preprocess the dataframe
    test_dataframe <- preprocess(test_dataframe, TRUE)

    ## predict the test dataframe
    test_dataframe$prediction_class <- predict(model, newdata = test_dataframe, type = "class")

    ## Set class as boolean
    test_dataframe <- test_dataframe %>%
        mutate(prediction_class = ifelse(prediction_class > 0.5, TRUE, FALSE))

    ## Calculate the metrics
    FP <- sum(test_dataframe$prediction_class == TRUE & test_dataframe$is_fake == FALSE)
    TP <- sum(test_dataframe$prediction_class == TRUE & test_dataframe$is_fake == TRUE)
    FN <- sum(test_dataframe$prediction_class == FALSE & test_dataframe$is_fake == TRUE)
    TN <- sum(test_dataframe$prediction_class == FALSE & test_dataframe$is_fake == FALSE)

    ## Calculate the metrics
    accuracy <- (TP + TN) / (TP + TN + FP + FN)
    precision <- TP / (TP + FP)
    recall <- TP / (TP + FN)
    specificity <- TN / (TN + FP)
    negative_predictive_value <- TN / (TN + FN)

    ## Print the metrics
    print("\nMetrics:")
    print("| | **Predicted Positive**| **Predicted Negative** | |")
    print("|:--:|:--:|:--:|:--:|")
    print(paste("| **Actual Positive**", "| TP: ", TP, " | FN: ", FN, " | Sensitivity: ", recall, " |"))
    print(paste("| **Actual Negative**", "| FP: ", FP, " | TN: ", TN, " | Specificity: ", specificity, " |"))
    print(paste("| | Precision: ", precision, " | Negative Predictive Value: ", negative_predictive_value, " | **Accuracy**: ", accuracy, " |"))
    


    
}