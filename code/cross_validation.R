library(rpart)

##  create_folds()
create_folds <- function(dataframe, n) {
    ## separate the dataframe in n folds
    folds <- dataframe %>%
        mutate(fold = sample(1:n, nrow(dataframe), replace = TRUE)) %>%
        group_by(fold)
    return(folds)
}