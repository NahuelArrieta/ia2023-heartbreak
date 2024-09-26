from sklearn.linear_model import LogisticRegression
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.tree import DecisionTreeClassifier


# Imports de nuestros algoritmos
from utils import train_models, test_models
import dataset_utils
import model as md

# Importar el logger
import my_logger

# Obtener un logger
logger = my_logger.get_logger()

train_dataset_path = 'dataset/fake_accounts_train.csv'
test_dataset_path = 'dataset/fake_accounts_test.csv'
prepocess_data = True

logger.info(f"Obteniendo dataset de entrenamiento de {train_dataset_path}")
logger.info(f'Obteniendo test dataset de {test_dataset_path}')
logger.info(f'Preprocesamiento de los datos: {prepocess_data}')

## Get datasets from the csv files
logger.info("Cargando datasets...")
X_train, y_train = dataset_utils.get_dataset(train_dataset_path)
X_test, y_test = dataset_utils.get_dataset(test_dataset_path)

## Preprocess the data
if prepocess_data:
    logger.info('Preprocesando datos...')
    X_train = dataset_utils.preprocess_data(X_train)
    X_test = dataset_utils.preprocess_data(X_test)

## List of Models.
models = []

## Decision Tree
decision_tree = md.Model(DecisionTreeClassifier(), "Decision Tree")
models.append(decision_tree)

### Logistic Regression
#max_iter = 1000
#logistic_regression = md.Model(LogisticRegression(max_iter=max_iter), "Logistic Regression")
#models.append(logistic_regression)
#
### Knn 
#k = 5
#knn = md.Model(KNeighborsClassifier(n_neighbors=k), "Knn")
#models.append(knn)
#
### Naive Bayes
#naive_bayes = md.Model(GaussianNB(), "Naive Bayes")
#models.append(naive_bayes)

## Train models and get the trained models
trained_models = train_models(models=models, X_train=X_train, y_train=y_train, number_of_folds=10)

## Test the models
test_models(trained_models=trained_models, X_test=X_test, y_test=y_test)


