# Proyecto Final - Heartbreak

- *Carrera*: Licenciatura en Ciencias de la Computación
- *Materia*: Inteligencia Artificial I
- *Alumno*: Nahuel Arrieta

## Introducción

Las redes sociales han transformado la manera en que las personas interactúan y consumen contenido en línea. Instagram, en particular, es una de las plataformas más populares, utilizada tanto por individuos como por empresas para marketing e influencia digital. Sin embargo, la proliferación de cuentas falsas y bots plantea un problema significativo, afectando la autenticidad del engagement y perjudicando a marcas y usuarios legítimos.

En el marco de la materia Inteligencia Artificial I de la Licenciatura en Ciencias de la Computación de la Universidad Nacional de Cuyo, se propone la realización de un proyecto final que consiste en crear un modelo capaz de detectar cuentas falsas de Instagram.  Se ha optado por aplicar algoritmos de aprendizaje automático supervisado para desarrollar un modelo capaz de clasificar cuentas como falsas o auténticas con un alto grado de precisión. Para ello, se ha utilizado un conjunto de datos etiquetado obtenido de Kaggle, conteniendo más de 65,000 cuentas con diversas características. El dataset fue producto de un trabajo similar ("Classification of instagram fake users using supervised machine learning algorithms") de K. R. Purba, D. Asirvatham y R. K. Murugesan [1].

A lo largo del documento, se detallará el marco teórico sobre la detección de cuentas falsas y los algoritmos utilizados, seguido del diseño experimental que incluye la selección de características, el preprocesamiento de datos y la metodología de entrenamiento y validación. Posteriormente, se presentará un análisis de los resultados obtenidos y las conclusiones finales, así como posibles mejoras futuras. 

## Marco Teórico

### Algoritmos Utilizados

La detección de cuentas falsas en redes sociales es un problema de clasificación binaria que ha sido abordado mediante diversas técnicas de aprendizaje automático. En términos generales, los modelos utilizados para este tipo de problemas incluyen:



#### Regresión Logística o Regresión Lineal

Un modelo lineal simple que estima la probabilidad de un elemento de pertenecer a una clase específica. Es una buena opción para los problema de clasificación, ya que utilizando una combinación lineal de las variables predictoras busca conseguir el valor de la variable dependiente: 

$$
z = w_1 x_1 + w_2 x_2 + \ldots + w_n x_n + b
$$
 
 
Donde:  $z$ es la respuesta que buscamos obtener, es decir, la clasificación; $w_i$ son los pesos de la ecuación; $x_i$ son las variables predictoras y $b$ es el sesgo de la predicción. Usando también la función logística $\sigma(z)$ siguiente para obtener la probabilidad de pertenencia a la clase que se quiere predecir:

$$
\sigma(z) = \frac{1}{1 + e^{-z}}
$$

Este último resultado junto a una función de umbral para definir de forma binaria la pertenencia del elemento que se está prediciendo, usando un umbral de $u$ en este caso:

$$
\text{Clase} = \begin{cases} 
1 & \text{si } \sigma(z) \geq u \\
0 & \text{si } \sigma(z) < u 
\end{cases}
$$

Para nuestro caso en particular las variables predictoras son los atributos del dataset. El algoritmo consiste en buscar los pesos de la combinación real para que satisfagan los resultados del conjunto de entrenamiento y así; usando la función logística y la función de umbral, determinar si un elemento pertenece o no a la clase que se predice.[2][3][4]

#### Árboles de decisión

Este algoritmo crea un modelo en forma de árbol, donde cada nodo representa una característica y cada rama representa una decisión o un resultado. Es utilizado tanto para clasificación binaria como para clasificación multiclase.

Para crear un árbol de decisión primero debemos seleccionar qué variables predictoras vamos a considerar. Se mide la ganancia de la información por cada variable predictora y se usa la de mayor ganancia para que sea el nodo raiz; luego con todos los datos en el nodo inicial se comienza a dividir de forma recursiva haciendo una selección de la mejor división usando la variable que maximicen la ganancia de información; y se continúa de esta forma hasta que se cumpla un criterio de parada.[5][6]

#### Bósques aleatorios (Random Forest)

El algoritmo funciona igual que el de un árbol de decisión, pero es repetido hasta adquirir la cantidad de árboles que se hayan requerido con la cantidad correspondiente de variables predictoras cada uno. Para obtener un resultado, se recorre cada árbol hasta alcanzar un resultado, esto cuenta como un "voto" para la pertenencia a una clase; al finalizar la "votación" se toma la clase que haya adquirido la mayor cantidad de votos.[7]

Random Forest parece el algoritmo ideal ya que puede aprovecharse de las relaciones que existen entre las variables predictoras y es menos sensible al sobreajuste, además de lograr aprovechar el tamaño de nuestro dataset. En el mismo construimos una cantidad $m$ de árboles de decisión con distintos conjuntos de $n$ variables predictoras seleccionadas de forma aleatoria, cada árbol crece hasta una altura máxima.


#### Algoritmo Naive Bayes

Este algoritmo se basa en el teorema de Bayes y asume que todas las características son independientes entre sí, su fórmula es:

$$
P(A|B) = \frac{P(B|A) \cdot P(A)}{P(B)}
$$

Donde:
 - $P(A|B)$ es la probabilidad de que ocurra el evento A dado que ha ocurrido el evento B.
 - $P(B|A)$ es la probabilidad de que ocurra el evento B dado que ocurrió el evento A.
 - $P(A)$ es la probabilidad del evento A.
 - $P(B)$ es la probabilidad del evento B.

Y tenemos estas hipotesis:
 - *Independencia*: Se asume que las variables no tienen ninguna correlación entre sí.
 - *Cálculo de probabilidades*: Para clasificar una nueva instancia, el algoritmo calcula la probablidad de que la isntancia pertenezca a cada clase y selecciona la clase con la mayor probabilidad. Esto se calcula con la siguiente fórmula:

$$
P(C|X) = \frac{P(X|C) \cdot P(C)}{P(X)} 
$$

Donde: C es una clase y X es el vector de variables del elemento que se está evaluando.

Es rápido y eficiente en términos de recursos computacionales. Sin embargo, el principal problema del uso de este algoritmo es que se asume que las variables no tienen ninguna correlación entre sí, lo cual es falso en nuestro dataset, por ejemplo, la cantidad de seguidores y el comments engagement rate estarán relacionados implícitamente, esto supone una buena contradicción desde un principio, lo cual no hace que este algoritmo deje de ser interesante para un problema de clasificación como el nuestro.[8][9]

#### K-Nearest Neighbors

Un algoritmo que clasifica un punto de datos basado en la clase de sus vecinos más cercanos. La principal desventaja de este algoritmo es que es lento en la fase de predicción, ya que necesita calcular la distancia entre el punto a clasificar y todos los puntos del conjunto de entrenamiento. Además, no es muy efectivo con datasets grandes, como es nuestro caso. Pero este algoritmo tiene la ventaja de ser simple.

Este algoritmo se basa en calcular los $k$ vecinos más cercanos del conjunto de entrenamiento. La idea fundamental de es que los puntos de datos similares están cerca los unos de los otros en un espacio n-dimensional. Y el algoritmo funciona de la siguiente manera: 
- Primero, debe estar definido el valor de $k$.
- Luego se calcula la distancia entre el elemento a clasificar y todos los demás puntos del conjunto de entrenamiento, usando la distancia euclidiana.
- Se toman los $k$ vecinos más cercanos y se asigna la clase resultado como la clase mayoritaria entre los vecinos.
[10]




### Estudios Relacionados 

Se han considerado diversos estudios previos sobre la detección de bots y cuentas falsas, incluyendo trabajos que han utilizado Twitter, Instagram y otras plataformas. A continuación, se resumen algunos estudios relevantes:

 - **Purba et al.** (2019) [1] analizaron la detección de cuentas falsas en Instagram utilizando algoritmos de aprendizaje supervisado. Compararon cinco modelos de Machine Learning, concluyendo que Random Forest ofrecía la mejor precisión (91.76%). También identificaron las características más relevantes para la clasificación, como la longitud de la biografía, el número de seguidores, el número de publicaciones y la disponibilidad de enlaces. Es relevante destacar que en este estudio se utilizó el mismo dataset que en nuestro trabajo, lo que permite una comparación directa de los resultados obtenidos.

- **Rico Martínez** (2021) [12] desarrolló un modelo basado en Inteligencia Artificial para distinguir entre bots y humanos en Twitter. Aplicaron modelos de aprendizaje profundo y técnicas de selección de características obtenidas de la API de Twitter, logrando una precisión elevada mediante redes neuronales.

- **Hristova** (2022) [13] exploró la predicción de noticias falsas mediante Machine Learning, analizando la propagación de información errónea en redes sociales. Se evaluaron múltiples algoritmos, destacando que los árboles de decisión y Random Forest lograban una alta precisión en la identificación de contenido manipulado.

Estos estudios proporcionan una base sólida para la detección de cuentas falsas en redes sociales, resaltando la importancia del uso de modelos de aprendizaje automático para la clasificación precisa de usuarios falsos. 



## Diseño Experimental

### Métricas de Evaluación
Para evaluar el rendimiento del modelo, se han utilizado las siguientes métricas:
Se utilizarán las siguientes métricas:

- **Exactitud (Accuracy):** Cantidad de cuentas identificadas correctamente como falsas en comparación con todas las cuentas clasificadas.

- **Sensibilidad (Recall):** Proporción de cuentas falsas reales son detectadas por el modelo.

- **Precisión (Precisión):** Cuántas de las cuentas que el modelo etiqueta como falsas son verdaderamente falsas.

- **Especificidad (Specificity):** Cuántas de las cuentas que el modelo etiqueta como falsas son verdaderamente falsas.

### Descripción del dataset.

Para el entrenamiento y validación del modelo se utilizó un cojunto de datos de la plataforma kaggle (https://www.kaggle.com/datasets/krpurba/fakeauthentic-user-instagram) el cuál ha recopilado datos de 65326 usuarios reales o auténticos y falsos desde el 1 al 20 de septiembre de 2019, lo cual resulta ser de grán utilidad ya que contiene muchas métricas de cada usuario. Además de ser muy extensa, contiene datos muy interesantes como: 

- Average Caption length: Longitud promedio de descripción en publicaciones.

- Average Hashtags count: Cantidad promedio de hashtags en publicaciones.

- Biography length: Longitud de la biografía.

- Caption Zero: Porcentaje de publicaciones con longitud de la descripición menor a 4 caracteres.

- Comments engagement rate: (número de comentarios) dividido por (número de publicaciones) dividido por (número de seguidores).

- Cosine similarity: Similaridad coseno promedio entre las publicaciones de un usuario.

- Follower keywords: Uso promedio de palabras "follower hunter" (follow, like, folback, follback, f4f) por publicación.

- Has Picture: Si la cuenta tiene imagen de perfil.

- Like engagement rate: (número de likes) dividido por (número de publicaciones) dividido por (número de seguidores).

- Link Availibility: Si la cuenta tiene un link externo.

- Location tag percentage: Porcentaje de publicaciones con tag de ubicación.

- Non image post percentage: Porcentaje de publicaciones que no son imágenes (video, carousel).

- Number of followers: Número de seguidores.

- Number of followings: Número de seguidos.

- Number of posts: Número de publicaciones.

- Post interval: Intervalo de tiempo en horas entre publicaciones.

- Promotional keywords: Uso promedio de palabras "promocionales" (regrann, contest, repost, giveaway, mention, share, give away, quiz) por publicación.


### Análisis de las features


#### Average Caption length

En la siguiente gráfica podemos ver una comparativa de la longitud promedio del pie de una publicación de las clases real y fake. En el eje $x$ se corresponde a la longitud promedio de los pie de publicación y en el eje $y$ se observa la cantidad de usuarios. La linea azul son los usuarios reales y la linea roja son usuarios fake.

![](./images/datasetMetrics/avg_caption_len.png)

Por lo que podemos observar ambas clases tienen una gran similitud en la longitud de sus pie de publicación por lo que en un principio podríamos decir que no es una buena feature para diferenciar ambas clases.

#### Average Hashtags count 

En esta gráfica podemos observar la cantidad promedio de hashtags en comparativa entre las clases real y fake en un gráfico en escala logarítmica. En el eje $x$ tenemos el número de hashtags y en el eje $y$ la cantidad de usuarios.

![](./images/datasetMetrics/avg_hashtag_count.png)

Lo que podemos observar en la gráfica es una similitud muy grande, entre los usuarios reales y fake, en el número de hashtags, pero luego comienzan a destacarse más los usuarios fake a partir de los 12 hashtags. Por lo que podría ser una feature muy útil para distinguir a un usuario fake de uno real.

#### Biography length 

En la gráfica se muestra una comparación entre la longitud de la biografía de las cuentas reales y fake. El eje $x$ representa la longitud de la biografía y el eje $y$ el número de usuarios.

![](./images/datasetMetrics/bio_len.png)

Podemos ver que hay una gran cantidad de usuarios de la clase fake que tienen una longitud de biografía pequeña, pero luego, cuando crece la longitud de biografía, se vuelve más difícil distinguir a un usuario real de otro fake. Por lo cual esta feature puede llegar a ser útil para la clasificación.

#### Caption Zero 

Aquí se visualiza el balance entre las cuentas real y fake cuyo porcentaje de pies de publicación de *casi cero* caracteres es la mayoría, para esto se tomaron las que fueran menores o iguales que 3 de las cuentas reales y fake, El valor 1 representa las que tienen un porcentaje de mayoría de pies de publicación casi nulos y 0 los que tienen un porcentaje mayoritario de pies de publicación superior a 3.  

![](./images/datasetMetrics/caption_zero.png)

Podemos observar que ambas clases tienen una proporción extremadamente similar, tanto en mayoría de pies de publicación *casi nulas* como en publicaciones con pies de publicación más largos. Por lo tanto, esta feature no es de tanta utilidad por si sola para diferenciar usuarios reales de usuarios fake. 

#### Comments engagement rate 

En este gráfico en escala logarítmica se puede observar una comparación del rate de participación de los comentarios de las cuentas real y fake. Esta participación se calcula de la siguiente forma:

$$
\frac{comentarios}{\frac{posteos}{seguidores}}
$$

En el eje de las $x$ tenemos representado el rate de participación de comentarios, mientras que en el eje $y$ el número de usuarios.

![](./images/datasetMetrics/comments_er.png)

Se observa en el gráfico que ambas clases tienen un rate de participación de comentarios muy similar, salvo por algunos picos de la clase real que tienen más engagement que la clase fake, pero son casos muy aislados para que sea una feature determinante por si sola.

#### Cosine similarity 

En este gráfico podemos comparar el promedio de similaridad coseno entre las publicaciones que tiene un usuario. Es decir, medimos la similitud promedio entre las publicaciones de un usuario. En el eje $x$ se visualiza el valor que de la similitud coseno y en el eje $y$ el número de usuarios.

![](./images/datasetMetrics/cos_similarity.png)

El gráfico nos muestra que hay una diferencia entre la similitud coseno de los usuarios reales y fake, por lo que esta feature podría ser útil para diferenciar a ambas clases.

#### Follower keywords 

En la gráfica (en escala logarítmica) se compara el promedio de uso de palabras clave que buscan obtener nuevos seguidores o likes como por ejemplo: f4f, follow for follow; follback o folback, de la expresión "follow back".

![](./images/datasetMetrics/follower_kw.png)

Podemos observar una clara diferencia entre las clases real y fake; los usuarios fake usan mayor cantidad de follower keywords. Por lo tanto esta podría ser una buena feature para diferenciar la clase de usuarios reales de los fake.

#### Has Picture 

Es una comparativa gráfica entre las clases real y fake de las cuentas que tienen foto de perfil. En donde 1 corresponde a que el usuario si tiene foto de perfil y 0 en caso contrario.

![](./images/datasetMetrics/has_picture.png)

Vemos en el gráfico que la mayoría de usuarios tienen una imagen de perfil pero no hay una diferencia notable entre las clases real y fake, por lo tanto esta feature no es de mucha utilidad de forma individual.

#### Like engagement rate 

Es esta gráfica en escala logarítmica se compara el nivel de interacción en forma de los "me gusta" en las publicaciones hechas por las cuentas reales y fake. En el eje $y$ el número de usuarios y en el eje $x$ se encuentra el rate de interacción que se calcula de la siguiente forma: 
  
$$
\frac{likes}{\frac{posteos}{seguidores}}
$$

![](./images/datasetMetrics/like_er.png)

En el gráfico vemos que ambas clases tienen un distribución similar en el plano por lo que esta feature puede no ser muy útil para clasificar a los usuarios reales y fake.

#### Link Availibility 

El gráfico muestra el balance de la disponibilidad de un link externo de las cuentas reales y fake. El valor 1 representa que la cuenta tiene un link externo asociado a ella y el valor 0 representa lo contrario.

![](./images/datasetMetrics/link_available.png)

Podemos ver que los usuarios fake son los que menos links externos tienen, por lo que esta feature podría ser muy útil para nuestro problema de clasificación.

#### Location tag percentage 

En la imagen se visualiza la comparativa de publicaciones con la etiqueta de la ubicación en los posteos de las cuentas reales y fake. Los usuarios con valor 1 se muestran los usuarios que tienen un gran porcentaje de etiquetas de ubicación en sus publicaciones; mientras que los que tienen valor 0, no. 

![](./images/datasetMetrics/loc_tag_percentage.png)

Por lo que se observa, no se puede diferenciar claramente a ambas clases por esta feature, lo que prueba que no es de gran utilidad.

#### Non image post percentage 

Compara la cantidad de posteos que no son sólo imagenes, como video o carrusel, entre las clases real y fake. Donde el valor 1 representa a los usuarios con un porcentaje mayoritario de publicaciones que no son sólo imágenes, mientras que 0 representa a lo contrario.

![](./images/datasetMetrics/non_image_percentage.png)

Por lo que se puede ver en la gráfica, ambos grupos están muy igualados por lo que esta feature no resulta de utilidad por si sola.

#### Number of followers 

El siguiente gráfico en escala logarítmica expresa una comparación de el número de seguidores entre las clases real y fake. El eje $x$ representa el número de seguidores, mientras que el eje $y$ representa al número de usuarios.

![](./images/datasetMetrics/number_follower.png)

Los usuarios reales son más distinguibles de los fake cuando los seguidores sobrepasan los 2500 seguidores; por lo cual esta feature puede ser muy útil.

#### Number of followings 

Este gráfico en escala logarítmica muestra una comparación de el número de seguidos entre las clases real y fake. En el eje $x$ se presenta el número de seguidos, mientras que el eje $y$ es el número de usuarios.

![](./images/datasetMetrics/number_following.png)

En el gráfico se observa que en un número bajo y alto de seguidos se diferencian claramente los usuarios reales de los fake. Por lo que esta feature puede llegar a ser fructífera.

#### Number of posts 

El gráfico compara el numero de posteos de las clases real y fake en escala logarítmica. El eje $x$ representa el número de posts, el eje $y$ muestra el número de usuarios

![](./images/datasetMetrics/number_post.png)

Lo que se puede observar es que no hay una diferencia clara entre el número de posteos de ambas clases por lo que no puede ser una feature de gran utilidad por si sola. 

#### Post interval 

Esta gráfica muestra el promedio de tiempo en horas entre posteos de las clases real y fake en una gráfica en escala logarítmica. En el eje $x$ se reflejan los promedios de tiempo, en horas, entre posteos; mientras que el eje $y$ representa el número de usuarios.

![](./images/datasetMetrics/post_interval.png)

Por lo que podemos observar es que el promedio de tiempo entre posteos entre las clases real y fake son distintas, por lo que esta feature puede llegar a ser productiva para clasificar a los usuarios.

#### Promotional keywords 

La gráfica en escala logarítmica siguiente expresa el uso promedio de palabras claves promocionales de las clases real y fake. El eje $x$ se corresponde con el uso promedio de palabras promocionales en posteos y en el eje $y$ es corresponde con el número de usuarios.

![](./images/datasetMetrics/promotional_kw.png)

En el gráfico podemos ver claramente que se diferencia la clase de usuarios reales de los fake por el promedio de palabras promocionales, por lo que esta feature prueba ser de utilidad para nuestro problema de clasificación.

## Algoritmos Utilizados

En este trabajo, se ha elegido **Random Forest** como algoritmo principal, ya que ha demostrado ser robusto en tareas de clasificación con múltiples características. Random Forest es un conjunto de árboles de decisión que combina predicciones de varios modelos individuales para reducir el riesgo de sobreajuste y mejorar la generalización. Además, proporciona una medida de importancia de características, lo que permite evaluar cuáles atributos son más relevantes para la clasificación.

Además de Random Forest, se han probado otros algoritmos de clasificación, incluyendo **Regresión Logística, K-Nearest Neighbors (KNN), Árboles de Decisión y Naive Bayes**. Pero la implementación de estos algoritmos no ha sido tan exhaustiva como en el caso de Random Forest, ya que se ha priorizado la evaluación de este último debido a su eficacia en problemas de clasificación.



### Herramientas Utilizadas 

Para este proyecto se utilizaron las siguientes herramientas:

El algorithm de Random Forest se implementó en el lenguaje de programación R debido a que es un lenguaje muy utilizado en el ámbito de la ciencia de datos y machine learning. Además, R cuenta con una gran cantidad de librerías y funciones que facilitan la implementación de algoritmos de machine learning. Se necesitaron las siguientes librerías:
- randomForest
- readr
- dplyr

Por otro lado, se utilizó Python para los otros modelos (Regresión Logística, Árboles de Decisión, Naive Bayes, K-Nearest Neighbors) y para el preprocesamiento de datos. Las librerías utilizadas en Python fueron:
- os
- random
- sklearn
- numpy
- time

### Preprocesamiento de Datos 
El conjunto de datos fue obtenido de Kaggle y contenía información sobre más de 65,000 cuentas etiquetadas como reales o falsas. 

Se dividió el conjunto de datos en dos partes: un conjunto de entrenamiento (80%) y un conjunto de validación (20%). 

Este dataset habia sido previamente limpiado y no contenía valores nulos o faltantes, y la distribución de clases estaba balanceada. Por esta razón, no fue necesario realizar otro tipo de preprocesamiento adicional.




### Experimentos Realizados
Para todos los modelos se utilizó una configuración de 5-fold cross-validation para evaluar el rendimiento del modelo en el conjunto de entrenamiento. 

Para los modelos de Naive Bayes, Regresión Logística y K-Nearest Neighbors, se realizaron experimentos sencillos con configuraciones básicas, sin ajuste de hiperparámetros ni selección de características.

En el caso de Random Forest, se realizaron 30 experimentos distintos en los que se aplicaban una o más de las siguientes configuraciones: selección de características, eliminación de características irrelevantes, ajuste de hiperparámetros y adición de nuevas características. 

La metodología para elegir las configuraciones de los experimentos fue la siguiente: se fueron eliminando o agregando características al modelo de forma individual y se evaluaba el impacto en la precisión del modelo. Luego, se combinaban las características que habían demostrado ser más relevantes y se evaluaba nuevamente la performance. Durante este proceso, se ajustaron los hiperparámetros `mtry` y `ntree` para encontrar la configuración que maximizara la precisión del modelo y minimizara la desviación estándar.

A continuación se describen las configuraciones realizadas:

#### Selección de características
Algunas features del dataset original no variaban significativamente entre las clases real y fake, por lo que se plantearon experimentos en los que se eliminaban estas características para evaluar su impacto en el rendimiento del modelo. Las características eliminadas fueron:

  - Non image post percentage
  - Location tag percentage
  - Caption zero
  - Comments engagement rate

#### Agregar nuevas características
Al momento de evaluar la legitimidad de cuenta de Instagram, existen agunos comportamientos que pueden ser indicativos de que una cuenta es falsa. Por ejemplo, una cuenta que tiene muchos seguidores pero sigue a muy pocos, o una cuenta reciente con mucha interacción. Por esta razón, se agregaron nuevas características al dataset que podrían ser útiles para la clasificación. Las características agregadas fueron:

  - follow_rate = number_of_followers / number_of_following
  - follow_difference = number_of_followers  - number_of_following
  - account_age = post_interval * number_of_posts
  - follower_frequency = number_of_followers / account_age
  - folowing_frequency = number_of_following / account_age
  - image_frequency = (number_of_posts - non_image_post_percentage) / account_age

#### Eliminación de características potencialmente irrelevantes en el entrenamiento
Durante el entrenamiento, algunas características no tenían un impacto significativo en la clasificación de las cuentas. Entonces, se realizaron experimentos en los que se eliminaban estas características para evitar el sobreajuste y mejorar la generalización del modelo. Las características eliminadas fueron:

  - Number of followers
  - Number of following
  - Follower keywords
  - Has picture
  - Bio length
  - Post interval
  - Promotional keywords
  
#### Variación de hiperparámetros
Se variaron los valores de los hiperparámetros `mtry` y `ntree` para evaluar su impacto en el rendimiento del modelo. Se probaron diferentes combinaciones de valores para estos hiperparámetros, buscando la configuración que maximizara la precisión del modelo, sin perder estabilidad.

  - ntree: 100, 150, 175, 200
  - mtry: 5, 8, 10


### Evaluación de Modelos
Si bien se realizaron 30 experimentos con Random Forest, se presentan a continuación los resultados que obtuvieron una precisión superior al 90% en el conjunto de entrenamiento. Para cada experimento, se muestra la configuración de hiperparámetros, las características utilizadas, la precisión y la desviación estándar obtenidas en el conjunto de entrenamiento.

Además se muestran los experimentos realizados con los otros algoritmos, incluyendo Regresión Logística, K-Nearest Neighbors, Naive Bayes y Árboles de Decisión. 


| Id | Algoritmo | Variables | Modificaciones | Accuracy | Desviación Estándar |
|----|-----------|-----------|----------------|----------|---------------------|
| 005 | Random Forest | - mtry: 5 <br> - ntree: 100 |   - Add follow rate <br>  - Remove number of following | 0.9022 | 0.0045 |
| 006 | Random Forest | - mtry: 5 <br> - ntree: 100 |   - Add follow rate  <br>  - Remove number of following | 0.9023 | 0.0034 |
| 011 | Random Forest | - mtry: 5 <br> - ntree: 100 |   - Remove caption zero | 0.9020 | 0.0025 | 
| 021 | Random Forest | - mtry: 5 <br> - ntree: 100 |  - Remove caption zero  <br>  - Add follow rate  <br>  - Remove number of followers | 0.9027 | 0.0007 |
| 022 | Random Forest | - mtry: 5 <br> - ntree: 100 |  - Remove non image post percentage <br>  - Remove caption zero <br>  - Add follow rate  <br> - Remove number of followers  | 0.9023 | 0.0035 |
| 023 | Random Forest | - mtry: 5 <br> - ntree: 100 |    - Remove non image post percentage <br>  - Add follow rate <br>  - Remove number of followers | 0.9027 | 0.0023 |
| 024 | Random Forest | - mtry: 8 <br> - ntree: 175 |   - Remove caption zero <br>  - Add follow rate  <br>  - Remove number of followers | 0.9020 | 0.0033 |
| 028 | Random Forest | - mtry: 5 <br> - ntree: 175 | - Remove caption zero <br>  - Add follow rate  <br>  - Remove number of followers | 0.9035 | 0.0022 |
| 030 | Random Forest | - mtry: 10 <br> - ntree: 175 | - Remove caption zero <br>  - Add follow rate  <br>  - Remove number of followers | 0.9025 | 0.0022 |
| LR | Regresión Logística | --- | --- |  0.8100 |  0.0049 |
| KNN | K-Nearest Neighbors | - k: 5 | --- | 0.8139 | 0.0046 |
| NB | Naive Bayes | --- | --- | 0.8561 | 0.0040 |
| DT | Árbol de Decisión | --- | --- | 0.7140 |0.0171 |

## Análisis y Discusión de Resultados
Durante el entrenamiento, el que obtuvo los mejores resultados fue Random Forest 030 con una precisión del 90.35% y una desviación estándar de 0.0022. Entonces, se validó el modelo con el conjunto de validación y se obtuvo la siguiente matriz de confusión:

| | **Predicted Positive**| **Predicted Negative** | |
 |:--:|:--:|:--:|:--:|
 | **Actual Positive** | TP:  6218  | FN:  291  | Sensitivity:  0.955292671685359  |
 | **Actual Negative** | FP:  1055  | TN:  5443  | Specificity:  0.837642351492767  |
 | | Precision:  0.854942939639764  | Negative Predictive Value:  0.949250087199163  | **Accuracy**:  0.896517259936957  |


Estos resultados indican que el modelo es altamente efectivo en la detección de cuentas falsas, aunque con una tasa moderada de falsos positivos. La sensibilidad del modelo es del 95.5%, lo que significa que es capaz de detectar la gran mayoría de cuentas falsas en el conjunto de validación. La especificidad del 83.7% indica que el modelo también es capaz de identificar cuentas reales con una precisión razonable. La precisión del modelo es del 85.5%, lo que significa que la mayoría de las cuentas clasificadas como falsas son verdaderamente falsas.


Se identificó que las características más importantes para la clasificación fueron:
1. Follow Rate 
2. Link Availability 
3. Engagement Rate Comments
4. Engagement Rate Likes
5. Biography Length



## Conclusiones Finales

El presente estudio ha demostrado que la inteligencia artificial es una herramienta efectiva para la detección de cuentas falsas en Instagram. Mediante el uso de **Random Forest**, se logró una precisión cercana al 90%, destacando la importancia de ciertos atributos como la tasa de seguimiento y la disponibilidad de enlaces externos.

Además, proyectos relacionados han obtenidos resultados similares en la detección de bots y cuentas falsas en redes sociales, lo que sugiere que los algoritmos de aprendizaje automático pueden ser una solución viable para este problema. [1][12][13]

Posibles mejoras futuras incluyen:
- **Exploración de modelos más complejos como XGBoost o Redes Neuronales**.
- **Análisis de texto en captions y comentarios para mejorar la detección de patrones fraudulentos**.
- **Uso de técnicas de ajuste de umbrales para reducir falsos positivos**.

## Bibliografía

- [1] Kristo Radion Purba, David Asirvatham, Raja Kumar Murugesan. *Classification of Instagram Fake Users Using Supervised Machine Learning Algorithms*, International Journal of Electrical and Computer Engineering, 2019.

- [2] DataScientest. *¿Qué es la regresión logística?* Recuperado de [https://datascientest.com/es/que-es-la-regresion-logistica](https://datascientest.com/es/que-es-la-regresion-logistica)

- [3] IBM. *Regresión logística*. Recuperado de [https://www.ibm.com/es-es/topics/logistic-regression](https://www.ibm.com/es-es/topics/logistic-regression)

- [4] Stuart Russell, Peter Norvig. *Artificial Intelligence: A Modern Approach* (4ª ed., p. 684, cap. 19, sec. 6, subsec. 5).

- [5] Stuart Russell, Peter Norvig. *Artificial Intelligence: A Modern Approach* (4ª ed., p. 657, cap. 19, sec. 3).

- [6] Machine Learning para Todos. *Árboles de decisión en Python*. Recuperado de [https://machinelearningparatodos.com/arboles-de-decision-en-python/](https://machinelearningparatodos.com/arboles-de-decision-en-python/)

- [7] IBM. *Random Forest*. Recuperado de [https://www.ibm.com/mx-es/topics/random-forest](https://www.ibm.com/mx-es/topics/random-forest)

- [8] Aprende IA. *Algoritmo Naive Bayes en Machine Learning*. Recuperado de [https://aprendeia.com/algoritmo-naive-bayes-machine-learning/](https://aprendeia.com/algoritmo-naive-bayes-machine-learning/)

- [9] FreeCodeCamp. *¿Cómo funcionan los clasificadores Naive Bayes?* Recuperado de [https://www.freecodecamp.org/espanol/news/como-funcionan-los-clasificadores-naive-bayes-con-ejemplos-de-codigo-de-python/](https://www.freecodecamp.org/espanol/news/como-funcionan-los-clasificadores-naive-bayes-con-ejemplos-de-codigo-de-python/)

- [10] IBM. *K-Nearest Neighbors (KNN)*. Recuperado de [https://www.ibm.com/es-es/topics/knn](https://www.ibm.com/es-es/topics/knn)

- [11] IBM. *Redes neuronales*. Recuperado de [https://www.ibm.com/es-es/topics/neural-networks](https://www.ibm.com/es-es/topics/neural-networks)

- [12] María Esther Rico Martínez. *Distinción de bots y humanos en Twitter con Inteligencia Artificial*, Trabajo Fin de Máster en Ingeniería Informática, 2021.

- [13] Inna Krasimirova Hristova. *Predicción de noticias falsas mediante Machine Learning*, Trabajo Fin de Grado, 2022.

