# Inteligencia Artificial I - Informe Proyecto Final.

## Heartbreak: Modelo para detectar cuentas falsas de Instagram

**Integrantes:** 
  - Nahuel Arrieta
  - Leonel Castinelli.

## Descripción

El proyecto consta  de generar un modelo que pueda predecir si una cuenta de la red social Instagram es falsa (ya sea un bot o tenga seguidores comprados). Se utilizará un algoritmo de machine learning entrenado con un dataset de la plataforma kaggle (https://www.kaggle.com/datasets/krpurba/fakeauthentic-user-instagram) el cuál ha recopilado datos de 65326 usuarios reales o auténticos y falsos desde el 1 al 20 de septiembre de 2019, lo cual prueba ser de grán utilidad ya que contiene muchas métricas de cada usuario. Además de ser muy extensa, contiene datos de utilidad como: 

- Average Caption length: Longitud promedio de descripción en publicaciones.

- Average Hashtags count: Cantidad promedio de hashtags en publicaciones.

- Biography length: Longitud de la biografía.

- Caption Zero: Porcentaje de publicaciones con longitud de la descripición menor a 4 caracteres.

- Comments engagement rate: (número de comentarios) dividido por (número de publicaciones) dividido por (número de seguidores).

- Cosine similarity: Similaridad coseno promedio entre cada par de publicaciones.

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

## Investigación 

### Análisis de la features del dataset

- Average Caption length (en escala logarítmica)

![](./images/datasetMetrics/avg_caption_len.png)

- Average Hashtags count (en escala logarítmica)

![](./images/datasetMetrics/avg_hashtag_count.png)

- Biography length 

![](./images/datasetMetrics/bio_len.png)

- Caption Zero 

![](./images/datasetMetrics/caption_zero.png)

- Comments engagement rate (en escala logarítmica)

![](./images/datasetMetrics/comments_er.png)

- Cosine similarity

![](./images/datasetMetrics/cos_similarity.png)

- Follower keywords (en escala logarítmica)

![](./images/datasetMetrics/follower_kw.png)

- Has Picture

![](./images/datasetMetrics/has_picture.png)

- Like engagement rate (en escala logarítmica)

![](./images/datasetMetrics/like_er.png)

- Link Availibility

![](./images/datasetMetrics/link_available.png)

- Location tag percentage

![](./images/datasetMetrics/loc_tag_percentage.png)

- Non image post percentage

![](./images/datasetMetrics/non_image_percentage.png)

- Number of followers (en escala logarítmica)

![](./images/datasetMetrics/number_follower.png)

- Number of followings 

![](./images/datasetMetrics/number_following.png)

- Number of posts (en escala logarítmica)

![](./images/datasetMetrics/number_post.png)

- Post interval (en escala logarítmica)

![](./images/datasetMetrics/post_interval.png)

- Promotional keywords (en escala logarítmica)

![](./images/datasetMetrics/promotional_kw.png)


#### Conclusiones

- La distribución de las clases (real o fake) es equitativa, lo cual es bueno para el entrenamiento del modelo.

![](./images/datasetMetrics/class_dist.png)

- Podría considerarse utilizar como feature la diferencia entre el número de seguidores y seguidos (followers - following).

![](./images/datasetMetrics/followers_following_diff_1.png)
![](./images/datasetMetrics/followers_following_diff_2.png)

- La característica "Caption Zero" no es muy útil ya que los unicos valores que toma son 0 y 1. Además algunos datos son incorrectos ya que hay 83 cuentas que no tienen descripcion en sus publicaciones (la longitud promedio de descripción en publicaciones es 0) pero el valor de la característica es 0.

![](./images/datasetMetrics/caption_zero_diff.png)


- Las siguientes características tienen una distribución muy similar entre las clases real y fake. En principio, no serían muy útiles para el entrenamiento del modelo.

  - Non image post percentage
  - Location tag percentage
  - Comments engagement rate

- Las siguientes características tienen una distribución muy diferente entre las clases real y fake. Podrían ser muy útiles para el entrenamiento del modelo.

  - Biography length 
  - Follower keywords
  - Has Picture
  - Link Availibility
  - Promotional keywords 

- Las siguientes características se podrían añadir para denotar más relaciones entre las características del dataset:

  - Rate of follows: followers and following rate es la cantidad de followers dividida la cantidad de following.
  - Post frecuency: la cantidad de posts dividida el post interval(intervalo de posteos). 

### Análisis de los algoritmos disponibles.

¿Qué algoritmos podemos usar para este problema de clasificación?

Para un problema de clasificación existen varios algoritmos que podemos considerar:

- **Regresión Logística:** es un algoritmo lineal utilizado para la clasificación binaria. Estima la probabilidad de pertenecer a una clase específica.
- **Árboles de Decisión:** este algoritmo crea un modelo en forma de árbol, donde cada nodo representa una característica y cada rama representa una decisión o un resultado. Es utilizado tanto para clasificación binaria como para clasificación multiclase.
- **Bosques Aleatorios (Random Forest):** es un conjunto de árboles de decisión que trabajan en paralelo y generan predicciones. Cada árbol en el bosque vota por la clase a la que pertenece, y la clase con más votos se selecciona como la predicción final.
- **Máquinas de Vectores de Soporte (SVM):** este algoritmo encuentra un hiperplano óptimo que separa las clases en un espacio de alta dimensión. Es utilizado tanto para clasificación binaria como para clasificación multiclase.
- **Naive Bayes:** este algoritmo se basa en el teorema de Bayes y asume que todas las características son independientes entre sí. Es rápido y eficiente en términos de recursos computacionales.
- **Redes Neuronales Artificiales (ANN):** estas son estructuras que imitan el funcionamiento del cerebro humano. Pueden ser utilizadas para problemas de clasificación tanto binaria como multiclase, pero pueden requerir más datos y recursos computacionales.

Cabe destacar que la elección del algoritmo adecuado depende del problema específico, los datos disponibles y las características del conjunto de datos.


**Regresión Logística o Regresión Lineal.**

Este algoritmo es una buena opción para este problema de clasificación pero debido a que queremos aprovechar el dataset amplio del que disponemos, buscaremos usar un algoritmo más potente cómo Random Forest.

**Árboles de decisión.**

Debido a la gran cantidad de valores que tenemos en el dataset buscaremos usar un algoritmo que pueda encontrar las relaciones no obvias en el dataset, además de que es sensible al sobreajuste. Para esquivar estas desventajas buscaremos usar Random Forest que es más dificil de realizar un sobreajuste y además es menos sensible al cambio de las variables.

**Bósques aleatorios (Random Forest)**

Este algoritmo nos parece el ideal ya que puede aprovecharse de las relaciones que existen entre las variables predictoras y es menos sensible al sobreajuste, además de lograr aprovechar el tamaño de nuestro dataset.

**Máquinas de Vectores de Soporte.**

El algoritmo MVS da excelentes resultados en estos problemas de clasificación pero no tiene buena performance con datasets grandes, como es nuestro caso. Además de que requiere una gran capacidad de cómputo por su complejidad temporal de O(dn<sup>2</sup>), lo cual se volvería muy costoso debido al tamaño del dataset.

**Algoritmo Naive Bayes.**

El principal problema del uso de este algoritmo es que se asume que las variables no tienen ninguna correlación entre sí, lo cual es falso en nuestro dataset, por ejemplo, la cantidad de seguidores y el comments engagement rate estarán relacionados implícitamente.

**Redes Neuronales.**

Estos algoritmos quedan descartados ya que exceden el alcance de la cátedra.


#### Conclusión.

Debido al gran tamaño del dataset y la gran cantidad de parámetros, podemos aprovecharlos en Random Forest generando árboles con conjuntos variables predictoras distintas que denotarán relaciones que sean altamente efectivas en la detección de si un perfil de instagram es real o falsa, como por ejemplo: Número de followers y following.