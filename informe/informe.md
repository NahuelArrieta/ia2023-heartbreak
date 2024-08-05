# Inteligencia Artificial I - Informe Proyecto Final.

## Heartbreak: Modelo para detectar cuentas falsas de Instagram

**Integrantes:** 
  - Nahuel Arrieta
  - Leonel Castinelli.

**Repositorio:** https://github.com/NahuelArrieta/ia2023-heartbreak

## Introducción.

En el marco de la materia Inteligencia Artificial I de la Licenciatura en Ciencias de la Computación de la Universidad Nacional de Cuyo, se propone la realización de un proyecto final que consiste en crear un módelo capaz de detectar cuentas falsas de Instagram.

Instagram es una red social con una gran popularidad, cuya principal función es compartir fotos y videos. El sistema de interacción se basa en seguir a otros usarios, por lo cual cada cuenta tiene seguidores y seguidos. Además de las publicaciones, cada cuenta tiene una biografía, una imagen de perfil y puede tener un link externo. Y este proyecto apunta a realizar un modelo de IA que ayude a encontrar características en cuentas falsas de Instagram.


### ¿Qué es una cuenta falsa? 
Una cuenta falsa es una cuenta de usuario en una red social que no representa a una persona real. Si bien pueden parecer fácil de identificar debido a ciertas características, como la falta de una imagen de perfil o poca actividad, muchos usuarios reales poseen también este comportamiento.  Dar una definición precisa de que es una cuenta falsa no es sencillo, ya que no existe un criterio único que permita identificarlas de manera inequívoca. Esto va a decantar en un gran desafío a la hora de testear la performance del modelo en un entorno real.

Como se indicó anteriormente, el modelo que se propone en este proyecto no tiene como objetivo identificar cuentas falsas de manera absoluta, sino detectar patrones y características comunes en cuentas que han sido identificadas como falsas en el pasado.

### Objetivo.
La masificación de las redes sociales ha llevado a la creación de cuentas falsas que buscan engañar a los usuarios. 

Detectar estas cuentas es de vital importancia por varias razones:
- En primer lugar, las cuentas falsas pueden ser utilizadas para difundir información errónea o engañosa, lo cual puede tener consecuencias negativas para los usuarios y la sociedad en general. 
- Además, estas cuentas a menudo están involucradas en actividades fraudulentas, como estafas y phishing, que ponen en riesgo la seguridad y privacidad de los usuarios legítimos. 
- Las cuentas falsas también pueden inflar artificialmente los números de seguidores y engagement, lo que distorsiona las métricas y afecta la credibilidad de influencers y marcas. Esto puede llevar a decisiones empresariales erróneas basadas en datos falsos. 
- Finalmente, la proliferación de cuentas falsas puede afectar la experiencia general del usuario, reduciendo la confianza en la plataforma y llevando a una menor interacción y satisfacción de los usuarios auténticos. 

Por todas estas razones, contar con un modelo que permita a Instagram detectar cuentas falsas de manera automática y eficiente es de suma importancia. El mismo contribuiría a mantener la confianza de los usuarios en la plataforma, promoviendo una experiencia más auténtica, satisfactoria y, sobre todo, más segura. 

### Proceso del proyecto.

Este proceso será llevado a cabo en las siguientes etapas, iniciaremos con un acercamiento al marco teórico en el que se va a trabajar, donde se describirán los algoritmos que utilizaremos en el proyecto y las razones por las que serán utilizados. Siguiente a la etapa descrita se hará un diseño experimental donde se describirá el dataset, las librerías utilizadas para la implementación, análsis de los datos obtenidos y experimentos llevados a cabo. Finalmente se realizará un análisis de los resultados y se dará una conclusión de qué tan aplicable es el modelo hoy en día. 

## Marco teórico.

En la siguientes secciones se analizarán los algoritmos disponibles para cumplir el objetivo principal del proyecto y se dará una conclusión de cual algoritmo es el más apropiado; y será usado para llevar a cabo el entrenamiento del modelo. 

### Análisis de los algoritmos a utilizar.
¿Qué algoritmos podemos usar para este problema de clasificación?

Para un problema de clasificación existen varios algoritmos que vamos a considerar:

- **Regresión Logística:** es un algoritmo lineal utilizado para la clasificación binaria. Estima la probabilidad de pertenecer a una clase específica.
- **Árboles de Decisión:** este algoritmo crea un modelo en forma de árbol, donde cada nodo representa una característica y cada rama representa una decisión o un resultado. Es utilizado tanto para clasificación binaria como para clasificación multiclase.
- **Bosques Aleatorios (Random Forest):** es un conjunto de árboles de decisión que trabajan en paralelo y generan predicciones. Cada árbol en el bosque vota por la clase a la que pertenece, y la clase con más votos se selecciona como la predicción final.
- **Naive Bayes:** este algoritmo se basa en el teorema de Bayes y asume que todas las características son independientes entre sí. Es rápido y eficiente en términos de recursos computacionales.
- **K-Nearest Neighbors (KNN):** este algoritmo clasifica un punto de datos basado en la clase de sus vecinos más cercanos. Es simple y fácil de implementar, pero puede ser lento con grandes conjuntos de datos.


**Regresión Logística o Regresión Lineal.**

Este algoritmo es una buena opción para los problema de clasificación, ya que utilizando una combinación lineal de las variables predictoras conseguir el valor de la variable dependiente: 

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

Para nuestro caso en particular las variables predictoras son los atributos del dataset. El algoritmo consiste en buscar los pesos de la combinación real para que satisfagan los resultados del conjunto de entrenamiento y así; usando la función logística y la función de umbral, determinar si un elemento pertenece o no a la clase que se predice.[1][2][3][4]

**Árboles de decisión.**

Este algoritmo también es útil para problemas de clasificación como el que tenemos en este proyecto, aunque es altamente sensible al sobreajuste. En el mismo construimos un árbol n-ario donde cada nodo representa un test de una de las variables predictoras y según su valor se va descendiendo por el árbor hasta llegar a las hojas del árbol donde esta representa una clasificación.[5]

Para crear un árbol de decisión primero debemos seleccionar qué variables predictoras vamos a considerar. Se mide la ganancia de la información por cada variable predictora y se usa la de mayor ganancia para que sea el nodo raiz; luego con todos los datos en el nodo inicial se comienza a dividir de forma recursiva haciendo una selección de la mejor división usando la variable que maximicen la ganancia de información; y se continúa de esta forma hasta que se cumpla un criterio de parada.[6][7] 

**Bósques aleatorios (Random Forest)**

Este algoritmo nos parece el ideal ya que puede aprovecharse de las relaciones que existen entre las variables predictoras y es menos sensible al sobreajuste, además de lograr aprovechar el tamaño de nuestro dataset. En el mismo construimos una cantidad $m$ de árboles de decisión con distintos conjuntos de $n$ variables predictoras seleccionadas de forma aleatoria, cada árbol crece hasta una altura máxima.

El algoritmo funciona igual que el de un árbol de decisión, pero es repetido hasta adquirir la cantidad de árboles que se hayan requerido con la cantidad correspondiente de variables predictoras cada uno. Para obtener un resultado, se recorre cada árbol hasta alcanzar un resultado, esto cuenta como un "voto" para la pertenencia a una clase; al finalizar la "votación" se toma la clase que haya adquirido la mayor cantidad de votos.[8]

**Algoritmo Naive Bayes.**

El principal problema del uso de este algoritmo es que se asume que las variables no tienen ninguna correlación entre sí, lo cual es falso en nuestro dataset, por ejemplo, la cantidad de seguidores y el comments engagement rate estarán relacionados implícitamente, esto supone una buena contradicción desde un principio, lo cual no hace que este algoritmo deje de ser interesante para un problema de clasificación como el nuestro.

El algoritmo se basa en el teorema de Bayes que describe la probabilidad de un evento, su fórmula es:

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

Donde: C es una clase y X es el vector de variables del elemento que se está evaluando.[9][10]

**K-Nearest Neighbors.**

La principal desventaja de este algoritmo es que es lento en la fase de predicción, ya que necesita calcular la distancia entre el punto a clasificar y todos los puntos del conjunto de entrenamiento. Además, no es muy efectivo con datasets grandes, como es nuestro caso. Pero este algoritmo tiene la ventaja de ser simple.

Este algoritmo se basa en calcular los $k$ vecinos más cercanos del conjunto de entrenamiento. La idea fundamental de es que los puntos de datos similares están cerca los unos de los otros en un espacio n-dimensional. Y el algoritmo funciona de la siguiente manera: 
- Primero, debe estar definido el valor de $k$.
- Luego se calcula la distancia entre el elemento a clasificar y todos los demás puntos del conjunto de entrenamiento, usando la distancia euclidiana.
- Se toman los $k$ vecinos más cercanos y se asigna la clase resultado como la clase mayoritaria entre los vecinos.
[11]

#### Conclusión.

Debido al gran tamaño del dataset y la gran cantidad de parámetros, podemos aprovecharlos en Random Forest generando árboles con conjuntos variables predictoras distintas que denotarán relaciones que sean altamente efectivas en la detección de si un perfil de instagram es real o falsa, como por ejemplo: Número de followers y following.


## Diseño Experimental.

### Descripción del dataset.

Se utilizará un algoritmo de machine learning entrenado con un dataset de la plataforma kaggle (https://www.kaggle.com/datasets/krpurba/fakeauthentic-user-instagram) el cuál ha recopilado datos de 65326 usuarios reales o auténticos y falsos desde el 1 al 20 de septiembre de 2019, lo cual resulta ser de grán utilidad ya que contiene muchas métricas de cada usuario. Además de ser muy extensa, contiene datos muy interesantes como: 

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

### Implementación.

Para llevar a cabo este proyecto se van a utilizar dos lenguajes de programación R y Python. La razón para usar R es por sus librerías orientadas al machine learning y en especial la del algoritmo Random Forest que vamos a estar utilizando para este proyecto. Además python tiene una sintaxis sencilla y librerías útiles para obtener modelos con los algoritmos que vamos a realizar implementaciones sencillas y también librerías para manipular datos y archivos.

Las librerías a usar en R son: 
- randomForest
- readr
- dplyr

Las librerías de python son:
- os
- random
- sklearn
- numpy
- time

### Análisis de los datos.

#### Features del dataset

**Average Caption length**:

- En la siguiente gráfica podemos ver una comparativa de la longitud promedio del pie de una publicación de las clases real y fake. En el eje $x$ se corresponde a la longitud promedio de los pie de publicación y en el eje $y$ se observa la cantidad de usuarios. La linea azul son los usuarios reales y la linea roja son usuarios fake.

![](./images/datasetMetrics/avg_caption_len.png)

- Por lo que podemos observar ambas clases tienen una gran similitud en la longitud de sus pie de publicación por lo que en un principio podríamos decir que no es una buena feature para diferenciar ambas clases.

**Average Hashtags count**: 

- En esta gráfica podemos observar la cantidad promedio de hashtags en comparativa entre las clases real y fake en un gráfico en escala logarítmica. En el eje $x$ tenemos el número de hashtags y en el eje $y$ la cantidad de usuarios.

![](./images/datasetMetrics/avg_hashtag_count.png)

- Lo que podemos observar en la gráfica es una similitud muy grande, entre los usuarios reales y fake, en el número de hashtags, pero luego comienzan a destacarse más los usuarios fake a partir de los 12 hashtags. Por lo que podría ser una feature muy útil para distinguir a un usuario fake de uno real.

**Biography length**: 

- En la gráfica se muestra una comparación entre la longitud de la biografía de las cuentas reales y fake. El eje $x$ representa la longitud de la biografía y el eje $y$ el número de usuarios.

![](./images/datasetMetrics/bio_len.png)

- Podemos ver que hay una gran cantidad de usuarios de la clase fake que tienen una longitud de biografía pequeña, pero luego, cuando crece la longitud de biografía, se vuelve más difícil distinguir a un usuario real de otro fake. Por lo cual esta feature puede llegar a ser útil para la clasificación.

**Caption Zero**: 

- Aquí se visualiza el balance entre las cuentas real y fake cuyo porcentaje de pies de publicación de *casi cero* caracteres es la mayoría, para esto se tomaron las que fueran menores o iguales que 3 de las cuentas reales y fake, El valor 1 representa las que tienen un porcentaje de mayoría de pies de publicación casi nulos y 0 los que tienen un porcentaje mayoritario de pies de publicación superior a 3.  

![](./images/datasetMetrics/caption_zero.png)

- Podemos observar que ambas clases tienen una proporción extremadamente similar, tanto en mayoría de pies de publicación *casi nulas* como en publicaciones con pies de publicación más largos. Por lo tanto, esta feature no es de tanta utilidad por si sola para diferenciar usuarios reales de usuarios fake. 

**Comments engagement rate**: 

- En este gráfico en escala logarítmica se puede observar una comparación del rate de participación de los comentarios de las cuentas real y fake. Esta participación se calcula de la siguiente forma:

$$
\frac{comentarios}{\frac{posteos}{seguidores}}
$$

- En el eje de las $x$ tenemos representado el rate de participación de comentarios, mientras que en el eje $y$ el número de usuarios.

![](./images/datasetMetrics/comments_er.png)

- Se observa en el gráfico que ambas clases tienen un rate de participación de comentarios muy similar, salvo por algunos picos de la clase real que tienen más engagement que la clase fake, pero son casos muy aislados para que sea una feature determinante por si sola.

**Cosine similarity**: 

- En este gráfico podemos comparar el promedio de similaridad coseno entre las publicaciones que tiene un usuario. Es decir, medimos la similitud promedio entre las publicaciones de un usuario. En el eje $x$ se visualiza el valor que de la similitud coseno y en el eje $y$ el número de usuarios.

![](./images/datasetMetrics/cos_similarity.png)

- El gráfico nos muestra que hay una diferencia entre la similitud coseno de los usuarios reales y fake, por lo que esta feature podría ser útil para diferenciar a ambas clases.

**Follower keywords**: 

- En la gráfica (en escala logarítmica) se compara el promedio de uso de palabras clave que buscan obtener nuevos seguidores o likes como por ejemplo: f4f, follow for follow; follback o folback, de la expresión "follow back".

![](./images/datasetMetrics/follower_kw.png)

- Podemos observar una clara diferencia entre las clases real y fake; los usuarios fake usan mayor cantidad de follower keywords. Por lo tanto esta podría ser una buena feature para diferenciar la clase de usuarios reales de los fake.

**Has Picture**: 

- Es una comparativa gráfica entre las clases real y fake de las cuentas que tienen foto de perfil. En donde 1 corresponde a que el usuario si tiene foto de perfil y 0 en caso contrario.

![](./images/datasetMetrics/has_picture.png)

- Vemos en el gráfico que la mayoría de usuarios tienen una imagen de perfil pero no hay una diferencia notable entre las clases real y fake, por lo tanto esta feature no es de mucha utilidad de forma individual.

**Like engagement rate**: 

- Es esta gráfica en escala logarítmica se compara el nivel de interacción en forma de los "me gusta" en las publicaciones hechas por las cuentas reales y fake. En el eje $y$ el número de usuarios y en el eje $x$ se encuentra el rate de interacción que se calcula de la siguiente forma: 
  
$$
\frac{likes}{\frac{posteos}{seguidores}}
$$

![](./images/datasetMetrics/like_er.png)

- En el gráfico vemos que ambas clases tienen un distribución similar en el plano por lo que esta feature puede no ser muy útil para clasificar a los usuarios reales y fake.

**Link Availibility**: 

- El gráfico muestra el balance de la disponibilidad de un link externo de las cuentas reales y fake. El valor 1 representa que la cuenta tiene un link externo asociado a ella y el valor 0 representa lo contrario.

![](./images/datasetMetrics/link_available.png)

- Podemos ver que los usuarios fake son los que menos links externos tienen, por lo que esta feature podría ser muy útil para nuestro problema de clasificación.

**Location tag percentage**: 

- En la imagen se visualiza la comparativa de publicaciones con la etiqueta de la ubicación en los posteos de las cuentas reales y fake. Los usuarios con valor 1 se muestran los usuarios que tienen un gran porcentaje de etiquetas de ubicación en sus publicaciones; mientras que los que tienen valor 0, no. 

![](./images/datasetMetrics/loc_tag_percentage.png)

- Por lo que se observa, no se puede diferenciar claramente a ambas clases por esta feature, lo que prueba que no es de gran utilidad.

**Non image post percentage**: 

- Compara la cantidad de posteos que no son sólo imagenes, como video o carrusel, entre las clases real y fake. Donde el valor 1 representa a los usuarios con un porcentaje mayoritario de publicaciones que no son sólo imágenes, mientras que 0 representa a lo contrario.

![](./images/datasetMetrics/non_image_percentage.png)

- Por lo que se puede ver en la gráfica, ambos grupos están muy igualados por lo que esta feature no resulta de utilidad por si sola.

**Number of followers**: 

- El siguiente gráfico en escala logarítmica expresa una comparación de el número de seguidores entre las clases real y fake. El eje $x$ representa el número de seguidores, mientras que el eje $y$ representa al número de usuarios.

![](./images/datasetMetrics/number_follower.png)

- Los usuarios reales son más distinguibles de los fake cuando los seguidores sobrepasan los 2500 seguidores; por lo cual esta feature puede ser muy útil.

**Number of followings**: 

- Este gráfico en escala logarítmica muestra una comparación de el número de seguidos entre las clases real y fake. En el eje $x$ se presenta el número de seguidos, mientras que el eje $y$ es el número de usuarios.

![](./images/datasetMetrics/number_following.png)

- En el gráfico se observa que en un número bajo y alto de seguidos se diferencian claramente los usuarios reales de los fake. Por lo que esta feature puede llegar a ser fructífera.

**Number of posts**: 

- El gráfico compara el numero de posteos de las clases real y fake en escala logarítmica. El eje $x$ representa el número de posts, el eje $y$ muestra el número de usuarios

![](./images/datasetMetrics/number_post.png)

- Lo que se puede observar es que no hay una diferencia clara entre el número de posteos de ambas clases por lo que no puede ser una feature de gran utilidad por si sola. 

**Post interval**: 

- Esta gráfica muestra el promedio de tiempo en horas entre posteos de las clases real y fake en una gráfica en escala logarítmica. En el eje $x$ se reflejan los promedios de tiempo, en horas, entre posteos; mientras que el eje $y$ representa el número de usuarios.

![](./images/datasetMetrics/post_interval.png)

- Por lo que podemos observar es que el promedio de tiempo entre posteos entre las clases real y fake son distintas, por lo que esta feature puede llegar a ser productiva para clasificar a los usuarios.

**Promotional keywords**: 

- La gráfica en escala logarítmica siguiente expresa el uso promedio de palabras claves promocionales de las clases real y fake. El eje $x$ se corresponde con el uso promedio de palabras promocionales en posteos y en el eje $y$ es corresponde con el número de usuarios.

![](./images/datasetMetrics/promotional_kw.png)

- En el gráfico podemos ver claramente que se diferencia la clase de usuarios reales de los fake por el promedio de palabras promocionales, por lo que esta feature prueba ser de utilidad para nuestro problema de clasificación.

#### Conclusiones del análisis de las features del dataset

- La distribución de las clases (real o fake) es muy equitativa, lo cual es bueno para el entrenamiento del modelo y ayudará a evitar el sesgo del modelo. Esto último se visualiza en la siguiente gráfica:

![](./images/datasetMetrics/class_dist.png)

- Podría considerarse utilizar como feature la diferencia entre el número de seguidores y seguidos (followers - following).

- En la siguiente gráfica se observa la diferencia entre followers y following en los valores negativos, es decir, aquellos usuarios que tienen más seguidos que seguidores.
  
![](./images/datasetMetrics/followers_following_diff_1.png)

- En la gráfica próxima veremos la diferencia entre followers y following en los valores positivos, es decir, aquellos usuarios que tienen más seguidores que seguidos.

![](./images/datasetMetrics/followers_following_diff_2.png)

- Podemos concluir que la diferencia entre seguidores y seguidos logra diferenciar de forma más clara a ambas clases se logran diferenciar mejor combinando estas dos features.

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

#### Features que se pueden añadir.

Ahora veremos qué features se pueden derivar de las actuales para ver si se pueden generar features con relevancia.

- Las siguientes características se podrían añadir para denotar más relaciones entre las características del dataset:

  - Follow difference: Diferencia entre el número de seguidores y seguidos.
  - Rate of follows: Cantidad de followers dividida la cantidad de following.
  - Post frecuency: Cantidad de posts dividida el post interval(intervalo de posteos). 
  - Account age: Antigüedad de la cuenta. Se puede calcular en base a la cantidad de posts y el post interval.
  - Follower frequency: Cantidad de followers dividida la antigüedad de la cuenta.
  - Following frequency: Cantidad de following dividida la antigüedad de la cuenta.
  - Images frequency: Cantidad de imágenes dividida la antigüedad de la cuenta.


#### Métricas.

Para medir el rendimiento de los modelos usaremos una matriz de confusión como la siguiente:

 | | **Predicted Positive**| **Predicted Negative** | |
 |:--:|:--:|:--:|:--:|
 | **Actual Positive** | TP:  True Positives  | FN:  False Negatives  | Sensitivity:  $$\frac{TP}{TP + FN}$$   |
 | **Actual Negative** | FP:  False Positives  | TN:  True Negatives  | Specificity:  $$\frac{FP}{FP + TN}$$  |
 | | Precision:  $$\frac{TP}{TP + FP}$$  | Negative Predictive Value:  $$\frac{FN}{FN + TN}$$  | **Accuracy**:  $$\frac{TP + TN}{TP + TN + FP + FN}$$  |


### Experimentos.
En base a los análisis realizados, se desarolló código para poder aplicar las modificaciones y se entrenó el modelo con el algoritmo Random Forest. Se realizaron varios experimentos con distintas configuraciones de hiperparámetros y se evaluaron los resultados obtenidos.

A continuación se presentan los de las pruebas realizadas:

#### 1- Modelo sin preprocesamiento.
El primer modelo se entrenó sin realizar ningún tipo de preprocesamiento en los datos, con el objetivo de evaluar las modificaciones que se pueden realizar en el dataset para mejorar el rendimiento del modelo. Se utilizaron 100 árboles y 5 variables predictoras en cada árbol.

Los resultados de la matriz de confusión fueron las siguientes:
 | | **Predicted Positive**| **Predicted Negative** | |
 |:--:|:--:|:--:|:--:|
 | **Actual Positive** | TP:  6224  | FN:  285  | Sensitivity:  0.956214472269166  |
 | **Actual Negative** | FP:  1083  | TN:  5474  | Specificity:  0.834833002897667  |
 | | Precision:  0.851785958669769  | Negative Predictive Value:  0.95051224170863  | **Accuracy**:  0.895300780652074  |

Además se obtuvo la importancia de las diferentes variables:
 | Variable | Importance |
 |:--:|:--:|
 |  Link availability  |  2153.48815752171  |
 |  Comments engagement rate  |  2152.98693259071  |
 |  Num following  |  2091.16579555838  |
 |  Like engagement rate  |  1448.20487223423  |
 |  Num followers  |  735.805088278248  | 
 |  Bio length  |  627.457577048002  |
 |  Location tag percentage  |  600.213569894813  |
 |  Avg caption length  |  534.722734277606  |
 |  Post interval  |  495.154604529331  |
 |  Num posts |  459.761258190958  |
 |  Cosine similarity  |  354.513301793794  |
 |  Caption zero  |  266.496444291937  |
 |  Average hashtag count  |  199.270343752644  |
 |  Promotional keywords   |  195.66162222508  |
 |  Non image percentage  |  168.669221114669  |
 |  Followers keywords  |  122.984566460685  |
 |  Has picture  |  13.2295974190987  |


Las primeras conclusiones que se pueden obtener de este modelo son:
- Contrariamente a lo que se esperaba, la característica "Comments engagement rate" resultó ser una de las más importantes para la clasificación de las cuentas.
- Las características "Follower keywords",  "Has Picture" y "Non image percentage" son las menos importantes para el modelo.
- Las variables "Location tag percentage", "Bio length", "Post interval" y "Promotional keywords" no tuvieron el impacto que esperábamos cuando analizamos el dataset.

#### 2- Dataset con followers-following ratio.

Al dataset se le incluyó una feature denominada "follow_rate" que representa la relación entre el número de seguidores y seguidos de una cuenta. 

La importancia que tuvo esta nueva característica en el modelo fue de 2366.98, siendo la más importante de todas las variables. Además se notó una importante disminución en la importancia de las variables "Num followers" (de 735.80 a 413.23) y "Num following" (de 2091.17 a 1104.46). 

En cuanto a los resultados, el se obtuvo una mejora en la accuracy del modelo, pasando de 0.8953 a 0.8973.

#### 3- Dataset con antigüedad de la cuenta.
Se agregó una característica al dataset denominada "account_age" que representa la antigüedad de la cuenta. Se calculó multiplicando el número de publicaciones por el intervalo de tiempo entre publicaciones, lo cual nos da un indicio de cuánto tiempo lleva la cuenta activa; sin embargo si la cuenta no ha publicado nada, la antigüedad será 0.

Esta nueva feature no fue muy útil ya que su importancia fue de 437.20 y la accuracy disminuyó ligéramente a 0.8941.

#### 4- Dataset con followers frequency.
En esta prueba se añadió una nueva feature al dataset denominada "followers_frequency" que representa la cantidad de seguidores dividida la antigüedad de la cuenta.

Al igual que la prueba anterior, esta nueva característica tuvo una baja  importancia en el modelo (355.15) y el accuracy disminuyó a 0.8937.

#### 5- Dataset con following frequency.
Para este entrenamiento se añadió una feature denominada "following_frequency" que representa la cantidad de seguidos dividida la antigüedad de la cuenta. 

En esta caso la variable tuvo una importancia alta (1177.64) y la importancia de "Num following" disminuyó a 1598.15. La accuracy del modelo fue de 0.8960.

#### 6- Dataset con image frequency.
Se añadió una nueva feature al dataset denominada "image_frequency" calculada como la cantidad de imágenes dividida la antigüedad de la cuenta. Nuevamente, los resultados no fueron los esperados ya que la importancia de la variable fue de 332.48 y la accuracy del modelo bajó a 0.8944.

#### 7- Escalado de variables.
En esta prueba se escaló el dataset utilizando la función `scale` de la librería `sklearn.preprocessing`, con el objetivo de normalizar las variables y mejorar el rendimiento del modelo.

Sin embargo, los resultados no fueron los esperados ya que la cantidad de falsos negativos aumentó considerablemente (de 285 a 1805), lo que se tradujo en una disminución de la accuracy del modelo a 0.7766.

#### 8- Eliminación de variables. 
En base al primer análisis de las variables del dataset se consideró eliminar las siguientes variables debido a que su distribución era muy similar entre las clases real y fake:
- Non image post percentage
- Location tag percentage
- Comments engagement rate
- Caption zero

En este caso la accuracy del modelo decreció notablemente a 0.8733 y la importancia de "Post Interval" cambió de 495.15 a 877.80. El resto de las variables no tuvieron cambios significativos en su importancia.

#### 9- Dataset con diferencia entre followers y following.
En este modelo se añadió una feature al dataset llamada "follow_differece" obtenida de la resta entre el número de seguidores y seguidos de una cuenta.

Esta prueba tuvo un buen resultado: La accuracy mejoró a 0.8966 y la importancia de la variable fue de 1967.10. Además cabe destaccar que la importancia de "Num following" bajó a la mitad (de 2091.16 a 1002.19), mientras que la de "Num followers" se mantuvo.

#### 10- Dataset sin non_image_post_percentage, location_tag_percentage y caption_zero.
Esta prueba es similar a la número 8, pero se decidió mantener la variable "Comments engagement rate" debido a la importancia que tuvo en el modelo sin preprocesamiento. 

Si bien el modelo tuvo un mucho mejor rendimiento que el modelo de la prueba 8, tuvo una accuracy similar al modelo sin preprocesamiento (0.8954) y la importancia de las variables no tuvo cambios significativos.


## Análisis de resultados.

Los resultados de los experimentos han llevado a obtener información al respecto de la incidencia sobre los resultados de los distintas features del dataset:
- La característica "Comments engagement rate" resultó ser una de las más importantes para la clasificación de las cuentas, y su eliminación puede afectar negativamente el rendimiento del modelo.
- Las características "Follow difference" y "Follow rate" resultaron ser muy importantes para la clasificación de las cuentas, y su inclusión en el modelo mejoró significativamente el rendimiento del modelo.
- Si se aplican las características "Follow difference" y "Follow rate", las características "Num followers" y "Num following" pierden importancia en el modelo.
- La eliminación de las características "Non image post percentage", "Location tag percentage" y "Caption zero" tuvo un ligero impacto positivo en el rendimiento del modelo, pero no fue significativo.
- El escalado de las variables tuvo resultados negativos en el rendimiento del modelo de Random Forest.
- Las características "Account age", "Followers frequency", "Following frequency" e "Image frequency" no tuvieron un impacto significativo en el rendimiento del modelo.
- Las features "Follow keywords", "Has Picture", "Bio length", "Has Picture" y "Promotional keywords" han tenido baja importancia en todas las pruebas realizadas, por lo que podrían ser eliminadas.

### Por qué este trabajo no es útil en la actualidad

Este trabajo no es útil en la actualidad debido a los cambios en la sociedad tras la pandemia del 2020, además de las distintas actualizaciones que ha tenido la red social desde la fecha en que se recopiló la información del dataset utilizado en este proyecto. La adición de visualización de medios como videos, la incorporación de la separación del audio del posteo y las publicaciones en conjunto de usuarios. Cambian las condiciones en las que las cuentas reales y fake se comportan, en adición, se añaden más características a cada cuenta que podrían ser relevantes en la clasificación de una cuenta. 

## Referencias.

 - [1] https://www.ibm.com/es-es/topics/logistic-regression
 - [2] https://datascientest.com/es/que-es-la-regresion-logistica
 - [3] https://es.wikipedia.org/wiki/Regresi%C3%B3n_log%C3%ADstica
 - [4] Stuart Russell, Peter Norvig: AIMA 4ta Edición; Pág. 684, Capítulo 19,  Sección 6, Subsección 5
 - [5] Stuart Russell, Peter Norvig: AIMA 4ta Edición; Pág. 657, Capítulo 19,  Sección 3.
 - [6] https://machinelearningparatodos.com/arboles-de-decision-en-python/
 - [7] https://anderfernandez.com/blog/programar-arbol-decision-python-desde-0/
 - [8] https://www.ibm.com/mx-es/topics/random-forest
 - [9] https://www.freecodecamp.org/espanol/news/como-funcionan-los-clasificadores-naive-bayes-con-ejemplos-de-codigo-de-python/
 - [10] https://aprendeia.com/algoritmo-naive-bayes-machine-learning/
 - [11] https://www.ibm.com/es-es/topics/knn

 - Kaggle del dataset: https://www.kaggle.com/datasets/krpurba/fakeauthentic-user-instagram
 - Paper publicado por Kristo Radion Purba, David Asirvatham y R.K. Murugesan donde se realizó un ejercicio similar al hecho por este proyecto: https://www.researchgate.net/publication/341796393_Classification_of_instagram_fake_users_using_supervised_machine_learning_algorithms


### Código

#### Random Forest en R


Para el entrenamiento del modelo Random Forest en R se utilizó la librería 'randomForest', la cual provee las funciones necesarias para entrenar el modelo y realizar las predicciones sobre el conjunto de test para luego evaluar el rendimiento del modelo.


``` r
## Train the model
model <- randomForest(
    formula = is_fake ~ .,
    data = dataframe,
    ntree = ntree,
    mtry = mtry,
    na.action = na.omit
)

## Predict the classes
test_dataframe$prediction_class <- predict(model, newdata = test_dataframe, type = "class")
```

Para poder realizar el prepocesamiento necesario en los datos, se definió en el archivo `code/utils.R` todas las funciones necesarias para realizar las transformaciones requeridas. Por ejemplo para poder eliminar las variable 'non_image_post_percentage':


``` r
## Remove non image post percentage
remove_non_image_post_percentage <- function(dataframe) {
      dataframe <- dataframe[, -which(names(dataframe) == "ni")]
      return(dataframe)
}
```

Se definió una función que dada una lista de parametros denominada `train_variables` se encarga de llamar a esas funciones para realizar el preprocesamiento de los datos.


``` r
## Set the variables to train the model
train_variables <- list(
    ntree = 100,
    mtry = 5,
    scale_data = FALSE,
    remove_non_image_post_percentage = TRUE,
    remove_location_tag_percentage = TRUE,
    remove_comments_engagement_rate = FALSE,
    remove_caption_zero = TRUE, 
    add_follow_difference = FALSE,
    add_follow_rate = FALSE,
    add_account_age = FALSE,
    add_follower_frequency = FALSE,
    add_following_frequency = FALSE,
    add_image_frequency = FALSE
)

## Train the model
model <- train_model(train_variables)
```
Además se creó una función que se encarga de evaluar el rendimiento del modelo y generar un archivo `.md` dentro de la carpeta `results` para cada prueba realizada y así comparar los resultados obtenidos con distintas configuraciones de hiperparámetros.
Estos archivos contienten información sobre la configuración utilizada, la matriz de confusión y la importancia de cada variable en el modelo. 

#### Otros algorithmos en Python

Para los algoritmos de Regresión Logística, Árboles de Decisión, KNN y Naive Bayes se utilizó la librería `sklearn` de Python. La implemetnación se basó en una clase `Model` que contiene los métodos necesarios para entrenar el modelo, realizar las predicciones y evaluar el rendimiento del modelo.

``` python

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
```

Luego de esto, se creó una instancia de la clase `Model` para cada algoritmo y se llamó al método `run` un determinado número de veces para obtener el rendimiento promedio del modelo.


``` python
## Run the models
iterations = 5
models = [logistic_regression, knn, decision_tree, naive_bayes]
for model in models:
    model.run(X_train, y_train, X_test, y_test, iterations)
    model.print_results()
``` 
