import time

class Model:
    def __init__(self, model, name):
        self.model = model
        self.name = name
        self.avg_time = 0
        self.avg_accuracy = 0
    
    def train(self, X_train, y_train):
        self.model.fit(X_train, y_train)

    def test(self, X_test, y_test):
        accuracy = self.model.score(X_test, y_test)
        return accuracy
    
    def print_results(self):
        print('\n')
        print('Model:', self.name)
        print('Average accuracy:', self.avg_accuracy)
        print('Average time (s):', self.avg_time)
        print('-----------------------------------')

    
    def run(self, X_train, y_train, X_test, y_test, n):
        train_time = 0
        accuracy = 0

        for i in range(n):
            start = time.time()
            self.train(X_train, y_train)
            train_time += time.time() - start

            accuracy += self.test(X_test, y_test)

        self.avg_time = train_time / n
        self.avg_accuracy = accuracy / n 

        

    