import time
import numpy as np

class Model:
    def __init__(self, model, name):
        self.model = model
        self.name = name
        self.time_list = []
        self.accuracy_list = []
       
    
    def train(self, X_train, y_train):
        self.model.fit(X_train, y_train)

    def test(self, X_test, y_test):
        accuracy = self.model.score(X_test, y_test)
        return accuracy
    
    def print_results(self):
        avg_accuracy = np.mean(self.accuracy_list)
        avg_time = np.mean(self.time_list)
        sd_accuracy = np.std(self.accuracy_list)
        
        print('\n')
        print('Model:', self.name)
        print("Accuracy list:", self.accuracy_list)
        print('Average accuracy:', avg_accuracy)
        print('Standard deviation of accuracy:', sd_accuracy)
        print('Average time (s):', avg_time)
        print('-----------------------------------')


    def run(self, X, y, n):
        for i in range(n):
            ## Split X and y in n folds
            folds_X = np.array_split(X, n)
            folds_y = np.array_split(y, n)

            ## Get the train and test sets
            X_test = folds_X[i]
            y_test = folds_y[i]

            X_train = np.concatenate(np.delete(folds_X, i, 0))
            y_train = np.concatenate(np.delete(folds_y, i, 0))

            start = time.time()
            self.train(X_train, y_train)
            train_time = time.time() - start

            accuracy = self.test(X_test, y_test)

            self.time_list.append(train_time)
            self.accuracy_list.append(accuracy)
    

        

    