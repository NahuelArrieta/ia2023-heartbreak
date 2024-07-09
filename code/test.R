library(dplyr)

## test the model
test <- function(model, train_variables, file_name) {
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

    ## Calculate the metrics
    FP <- confusion_matrix[2, 1]
    FN <- confusion_matrix[1, 2]
    TP <- confusion_matrix[1, 1]
    TN <- confusion_matrix[2, 2]

    ## Calculate the metrics
    accuracy <- (TP + TN) / (TP + TN + FP + FN)
    precision <- TP / (TP + FP)
    recall <- TP / (TP + FN)
    specificity <- TN / (TN + FP)
    negative_predictive_value <- TN / (TN + FN)

    # ## Print the metrics
    metrics <- "\n ## Metrics:\n"
    metrics <- paste(metrics, "| | **Predicted Positive**| **Predicted Negative** | |\n")
    metrics <- paste(metrics, "|:--:|:--:|:--:|:--:|\n")
    metrics <- paste(metrics, "| **Actual Positive**", "| TP: ", TP, " | FN: ", FN, " | Sensitivity: ", recall, " |\n")
    metrics <- paste(metrics, "| **Actual Negative**", "| FP: ", FP, " | TN: ", TN, " | Specificity: ", specificity, " |\n")
    metrics <- paste(metrics, "| | Precision: ", precision, " | Negative Predictive Value: ", negative_predictive_value, " | **Accuracy**: ", accuracy, " |\n")
    
    ## Get today date as yyyy-mm-dd hh:mm:ss
    today <- Sys.time()
    today <- format(today, "%Y-%m-%d %H:%M:%S")
    date <- paste("Date: ", today, "\n")

    ## Get the var used
    var <- paste("Variables: ", train_variables$ntree, " trees, ", train_variables$mtry, " mtry\n")

    ## Print the importance of the variables
    importance <- "\n ## Variable importance:\n"
    importance <- paste(importance, "| Variable | Importance |\n")
    importance <- paste(importance, "|:--:|:--:|\n")
    
    ## iterate over the importance getting the key and the value
    names <- rownames(model$importance)
    for (i in 1:length(names)) {
        importance <- paste(importance, "| ", names[i], " | ", model$importance[i, 1], " |\n")
    }


    ## Save the message and metrics
    title <- paste("# Test results for", file_name)
    message_to_save <- paste(title, date, var,message, metrics, importance, sep = "\n")
    file_name <- paste("results/", file_name, sep = "")

    # Add number as prefix
    current_files <- list.files("results")
    number <- length(current_files) + 1
    file_name <- paste(number, "-", file_name, ".md", sep = "")

    write(message_to_save, file = file_name, append = FALSE, sep = "\n")

    print("Test complete.")
}
