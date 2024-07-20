from sklearn.linear_model import LogisticRegression
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.tree import DecisionTreeClassifier
import dataset_utils
import model as md


train_dataset_path = 'dataset/fake_accounts_train.csv'
test_dataset_path = 'dataset/fake_accounts_test.csv'
prepocess_data = True

## Get datasets from the csv files
X_train, y_train = dataset_utils.get_dataset(train_dataset_path)
X_test, y_test = dataset_utils.get_dataset(test_dataset_path)

## Preprocess the data
if prepocess_data:
    X_train = dataset_utils.preprocess_data(X_train)
    X_test = dataset_utils.preprocess_data(X_test)

## Logistic Regression
max_iter = 1000
logistic_regression = md.Model(LogisticRegression(max_iter=max_iter), "Logistic Regression")

## Knn 
k = 5
knn = md.Model(KNeighborsClassifier(n_neighbors=k), "Knn")

## Decision Tree
decision_tree = md.Model(DecisionTreeClassifier(), "Decision Tree")

## Naive Bayes
naive_bayes = md.Model(GaussianNB(), "Naive Bayes")

## Run the models
iterations = 5
models = [logistic_regression, knn, decision_tree, naive_bayes]
for model in models:
    model.run(X_train, y_train, X_test, y_test, iterations)
    model.print_results()




