import my_logger

logger = my_logger.get_logger()

def train_models(models, X_train, y_train, number_of_folds):
    
    trained_models = []
    for model in models:
        logger.info(f"Entrenando {model.name} con validacion cruzada de {number_of_folds} folds...")
        model.run(X_train, y_train, number_of_folds)
        logger.info(f"Resultados de entrenamiento de {model.name}:")
        model.print_results()
        trained_models.append(model)
        logger.info(f"Agregado modelo entrenado a trained_models: {trained_models}")

    return trained_models

def test_models(trained_models, X_test, y_test):
    for model in trained_models:
        logger.info(f"Evaluando {model.name} en dataset de test...")
        accuracy = model.test(X_test, y_test)
        my_logger.log_results(model.name, accuracy)