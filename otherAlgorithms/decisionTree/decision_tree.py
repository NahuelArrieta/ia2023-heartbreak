import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.tree import DecisionTreeClassifier



train_dataset_path = 'dataset/fake_accounts_train.csv'
test_dataset_path = 'dataset/fake_accounts_test.csv'
max_iter = 1000


## Clases are represented as 'f' and 'r' in the dataset
## 'f' is mapped to 1 and 'r' is mapped to 0
def map_classes(dataset):
    dataset[dataset == 'f'] = 1
    dataset[dataset == 'r'] = 0
    return dataset


## Get the training and testing datasets
train_dataset = np.genfromtxt(train_dataset_path, delimiter=',', dtype='str')
train_dataset = map_classes(train_dataset)

test_dataset = np.genfromtxt(test_dataset_path, delimiter=',', dtype='str')
test_dataset = map_classes(test_dataset)

## Get the features and classes
X_train = train_dataset[1:, 1:-1].astype(np.float64)
y_train = train_dataset[1:, -1].astype(np.float64)

X_test = test_dataset[1:, 1:-1].astype(np.float64)
y_test = test_dataset[1:, -1].astype(np.float64)

## Scale the features
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

## Decision Tree
model = DecisionTreeClassifier()
model.fit(X_train_scaled, y_train)

accuracy = model.score(X_test_scaled, y_test)

print('Accuracy:', accuracy)
