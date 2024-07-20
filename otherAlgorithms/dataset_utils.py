from sklearn.preprocessing import StandardScaler
import numpy as np

def preprocess_data(data):
    ## Scale the features
    scaler = StandardScaler()
    data = scaler.fit_transform(data)
    
    return data


## Clases are represented as 'f' and 'r' in the dataset
## 'f' is mapped to 1 and 'r' is mapped
def map_classes(dataset):
    dataset[dataset == 'f'] = 1
    dataset[dataset == 'r'] = 0
    return

def get_dataset(dataset_path):
    dataset = np.genfromtxt(dataset_path, delimiter=',', dtype='str')
    map_classes(dataset)
    
    X = dataset[1:, 1:-1].astype(np.float64)
    y = dataset[1:, -1].astype(np.float64)
    
    return X, y
