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
    message_to_save <- paste(title, date,message, metrics, importance, sep = "\n")
    file_name <- paste("results/", file_name, sep = "")

    # Check if file already exists
    if (file.exists(paste0(file_name, ".md"))) {
        # Find a new file name by appending a number
        i <- 1
        while (file.exists(paste0(file_name, "_", i, ".md"))) {
            i <- i + 1
        }
        file_name <- paste0(file_name, "_", i, ".md")
    } else {
        file_name <- paste0(file_name, ".md")
    }

    write(message_to_save, file = file_name, append = FALSE, sep = "\n")
}
