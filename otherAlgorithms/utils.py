def trainModels(models, X_train, y_train, number_of_folds):
    for model in models:
        model.run(X_train, y_train, number_of_folds)
        model.print_results()

def testModels(models, X_train, y_train, X_test, y_test):
    for model in models:
        model.train(X_train, y_train)
        accuracy = model.test(X_test, y_test)
        print('Model:', model.name)
        print('Accuracy:', accuracy)
        print('-----------------------------------')