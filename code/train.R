library(randomForest)

get_model <- function(dataframe, train_variables) {
    ## Get the variables
    ntree <- train_variables$ntree
    mtry <- train_variables$mtry

    ## Train the model
    model <- randomForest(
        formula = is_fake ~ .,
        data = dataframe,
        ntree = ntree,
        mtry = mtry,
        na.action = na.omit
    )

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
    accuracy_results <- c()

    ## Start empty map to track the importance of each variable
    variable_importance <- new.env()

    print("Start training") 

    ## Train the models
    for (i in 1:train_variables$nfolds) {

        print(paste("Fold: ", i))

        ## Get the train and test data
        train_data <- folds %>% filter(fold != i)
        test_data <- folds %>% filter(fold == i)

        ## Train the model
        model <- get_model(train_data, train_variables)

        ## Test the model
        confusion_matrix <- test(model, test_data, train_variables)

        ## Add the accuracy
        current_accuracy <- confusion_matrix[1, 1] + confusion_matrix[2, 2]
        current_accuracy <- current_accuracy / sum(confusion_matrix)

        accuracy_results <- c(accuracy_results, current_accuracy)

        ## Add the importance of the variables
        names <- rownames(model$importance)
        for (i in 1:length(names)) {
            if (exists(names[i], variable_importance)) {
                variable_importance[[names[i]]] <- variable_importance[[names[i]]] + model$importance[i, 1]
            } else {
                variable_importance[[names[i]]] <- model$importance[i, 1]
            }
        }
    }

    ## Calculate the average importance of the variables
    names <- names(variable_importance)
    for (i in 1:length(variable_importance)) {
        variable_importance[[names[i]]] <- variable_importance[[names[i]]] / train_variables$nfolds
    }

    ## Print results
    print_results_train(file_name, train_variables, preprocess_data$message, accuracy_results, variable_importance)

    print("Training complete.")
}


print_results_train <- function(file_name, train_variables, message, accuracy_results, variable_importance) {
    ## Get the cross validation results
    cv_results <- ""
    if (length(accuracy_results) > 0) {
        cv_results <- paste("\n Number of folds: ", length(accuracy_results), "\n")

        cv_results <- "\n ## Cross validation results:\n"
        cv_results <- paste(cv_results, "| Fold | Accuracy |\n")
        cv_results <- paste(cv_results, "|:--:|:--:|\n")
        for (i in 1:length(accuracy_results)) {
            cv_results <- paste(cv_results, "| ", i, " | ", accuracy_results[i], " |\n")
        }

        cv_results <- paste(cv_results, " \n")

        cv_results <- paste(cv_results, "**Mean Accuracy**: ", mean(accuracy_results), " \n")
        cv_results <- paste(cv_results, "**Standard Deviation**: ", sd(accuracy_results), " \n")
    }

    ## Print the importance of the variables
    importance <- "\n ## Variable importance:\n"
    importance <- paste(importance, "| Variable | Importance |\n")
    importance <- paste(importance, "|:--:|:--:|\n")

    ## iterate over the importance getting the key and the value
    names <- names(variable_importance)
    for (i in 1:length(names)) {
        if (names[i] == "fold") {
            next
        }
        importance <- paste(importance, "| ", names[i], " | ", variable_importance[[names[i]]], " |\n")
    }
        
    ## Get today date as yyyy-mm-dd hh:mm:ss
    today <- Sys.time()
    today <- format(today, "%Y-%m-%d %H:%M:%S")
    date <- paste("**Date:** ", today, "\n")

    ## Get the var used
    var <- paste("## Variables \n")
    var <- paste(var, "- ntree: ", train_variables$ntree, "\n")
    var <- paste(var, "- mtry: ", train_variables$mtry, "\n")


    ## Save the message and metrics
    title <- paste("# Test results for", file_name)
    message_to_save <- paste(title, date, var,message,cv_results,importance,sep = "\n")
    
    ## Add number as prefix
    current_files <- list.files("results")
    number <- length(current_files) + 1

    ## Add 0 before the number if it is less than 1000
    if (number < 10) {
        number <- paste("00", number, sep = "")
    } else if (number < 100) {
        number <- paste("0", number, sep = "")
    }
    
    file_name <- paste("results/", number, "-", file_name, ".md", sep = "")

    write(message_to_save, file = file_name, append = FALSE, sep = "\n")
}


check_model <- function(train_variables) {
     ## Get dataset
    dataframe <- get_train_df()

    ## Preprocess the dataframe
    preprocess_data <- preprocess(dataframe, train_variables)
    dataframe <- preprocess_data$dataframe

    ## Do cross validation
    folds <- create_folds(dataframe, train_variables$nfolds)

    ## Start empty confusion matrix
    all_confusion_matrix <- matrix(0, 2, 2)
    accuracy_results <- c()
    f1_results <- c()

    ## Start empty map to track the importance of each variable
    variable_importance <- new.env()

    print("Start training") 

    ## Train the models
    for (i in 1:train_variables$nfolds) {

        print(paste("Fold: ", i))

        ## Get the train and test data
        train_data <- folds %>% filter(fold != i)
        test_data <- folds %>% filter(fold == i)

        ## Train the model
        model <- get_model(train_data, train_variables)

        ## Test the model
        confusion_matrix <- test(model, test_data, train_variables)

        ## Add the accuracy
        current_accuracy <- confusion_matrix[1, 1] + confusion_matrix[2, 2]
        current_accuracy <- current_accuracy / sum(confusion_matrix)

        accuracy_results <- c(accuracy_results, current_accuracy)

        ## Calculate the F1 score
        recall <- confusion_matrix[1, 1] / (confusion_matrix[1, 1] + confusion_matrix[1, 2])
        precision <- confusion_matrix[1, 1] / (confusion_matrix[1, 1] + confusion_matrix[2, 1])

        f1_score <- 2 * (precision * recall) / (precision + recall)

        f1_results <- c(f1_results, f1_score)
    }

    ## Print results
    print("Results")

    print("Accuracy")
    print(accuracy_results)


    print("F1 Score")
    print(f1_results)
}