# UNCUYO - Inteligencia Artificial I:
## Proyecto Final - Anteproyecto.

## Modelo para detectar cuentas falsas de Instagram

**Nombre código del proyecto:** Heartbreak.
**Integrantes:** 
  - Nahuel Arrieta
  - Leonel Castinelli.

## Descripción

El proyecto consta  de generar un modelo que pueda predecir si una cuenta de la red social Instagram es falsa (ya sea un bot o tenga seguidores comprados). Se utilizará un algoritmo de machine learning entrenado con un dataset de la plataforma kaggle (https://www.kaggle.com/datasets/krpurba/fakeauthentic-user-instagram) el cuál ha recopilado datos de 65326 usuarios reales o auténticos y falsos desde el 1 al 20 de septiembre de 2019, lo cual prueba ser de grán utilidad ya que contiene muchas métricas de cada usuario. Además de ser muy extensa, contiene datos de utilidad como: 
- Número de posteos.
- Número de Seguidos.
- Número de Seguidores.
- Longitud de biografía.
- Disponibilidad de imagen de perfil.
- Disponibilidad de links externos.
- Longitud promedio de descripción en posteos.
- Porcentaje de posteos que no son imágenes.
- Porcentaje de tag de ubicación.
- Intervalo de tiempo de posteos.

## Objetivos, alcances y limitaciones

Nuestro  objetivo principal es desarrollar un modelo con machine learning que logre clasificar efectivamente un perfil falso de Instagram, llamaremos “falso” a una cuenta que sea un bot o tenga seguidores comprados, ya que estas no son cuentas de usuario “normales”, “reales” o “auténticas”. Es decir estamos ante un problema de clasificación.
	
El alcance de este proyecto se va a centrar únicamente en detectar cuentas falsas de Instagram. No sé abordarán otras redes sociales ni otro tipo de interacción dentro de la plataforma. Además se buscará aprovechar al máximo el dataset utilizando todos sus elementos, no se filtrarán por ningún tipo de atributo ya que todos son altamente útiles como número de seguidores, número de seguidos, si tiene imagen de perfil, si publica más tipos de contenido además de imágenes (videos), Ratio de engagement basado en likes, número total de posteos, y otros datos similares. 
	
Las limitaciones de este proyecto se deben a que está restringido a la red social de Instagram, y perfiles de la misma del año 2019, y los cambios sociales y tecnológicos a lo largo de los años podrían determinar una diferencia de las características que se usan para determinar si una cuenta es de un bot o spammer


## Formas de evaluación

Se utilizarán las siguientes métricas:

- Exactitud (Accuracy): Cantidad de cuentas identificadas correctamente como falsas en comparación con todas las cuentas clasificadas.

- Sensibilidad (Recall): Proporción de cuentas falsas reales son detectadas por el modelo.

- Precisión (Precisión): Cuántas de las cuentas que el modelo etiqueta como falsas son verdaderamente falsas.

- Especificidad (Specificity): Cuántas de las cuentas que el modelo etiqueta como falsas son verdaderamente falsas.

Además de probarse utilizando una fracción del dataset de entrenamiento, también se generaran perfiles falsos con características aleatorias que serán utilizados para probar la capacidad del modelo de reconocer perfiles falsos de instagram.

## Justificación

Consideramos que un modelo de machine learning es un enfoque correcto para el problema planteado porque estos pueden detectar patrones y relaciones complejas entre las características de las cuentas, las cuales quizá no capturamos a simple vista, también podríamos encontrar nuevas relaciones entre parámetros que caracterizan a una cuenta falsa o con seguidores comprados.

La detección de cuentas falsas requiere un gran análisis estadístico que un modelo de ML puede realizar en tiempo real y de manera eficiente. Especialmente, teniendo la posibilidad de entrenarlo con un dataset de 65.000 datos ya etiquetados, además de poder encontrar relaciones entre las columnas del dataset que pasarían inadvertidas ante un humano.

Finalmente, al tener una gran cantidad de columnas y filas en el dataset creemos que podemos sacarle mucho provecho con un enfoque de machine learning donde creemos que podemos generar un modelo efectivo.

**Listado de actividades a realizar:**

- **Actividad 1:** Recopilar información.**[5 días]**

- **Actividad 2:** Limpiar la información.**[4 días]**

- **Actividad 3:** Preprocesamiento de datos.**[4 días]**

- **Actividad 4:** Selección de los conjuntos de entrenamiento y prueba.**[4 días]**

- **Actividad 5:** Entrenamiento del modelo. **[5 días]**

- **Actividad 6:** Validación del modelo y análisis de las métricas resultantes. **[3 días]** 

- **Actividad 7:** Ajustes al modelo. **[4 días]**

- **Actividad 8:** Elaboración del informe final. **[4 días]**

**Grafico de las actividades:**
![](gantt_heartbreak.png)



### Proyectos similares

Lamentablemente no encontramos que otros proyectos han hecho otros usuarios con el dataset que usaremos. Pero se encontraron los siguientes proyectos similares al nuestro, buscando en internet, con el objetivo de ayudarnos en el proceso de obtención de los datos, preprocesamiento de los mismos y la elección del algoritmo.

**Distinción de bots y humanos en Twitter con Inteligencia Artificial**

https://rua.ua.es/dspace/bitstream/10045/120393/1/Distincion_de_bots_y_humanos_en_Twitter_con_Intel_Rico_Martinez_Maria_Esther.pdf 

En este trabajo, María Esther Rico Martínez busca verificar si una cuenta de la red social Twitter es verdadera o no. 
En el informe del mismo, se habla sobre la obtención de los datos; y se plantean inicialmente los siguientes algoritmos:

- Detección de cuentas falsas basada en reglas
- Detección de perfiles clonados usando el algoritmo de árbol de decisión C4.5
- Detección utilizando Machine-Learning
- Detección utilizando NPL
- Detección a través de características
- Detección utilizando ontologías
- Detección mediante aprendizaje semi-supervisado

Finalmente, la autora entrena cuatro modelos distintos de ML, presentando las distintas métricas para cada uno.

**Predicción de noticias falsas con ML**

https://oa.upm.es/71778/1/TFG_INNA_KRASIMIROVA_HRISTOVA.pdf

En este proyecto, se intenta predecir si una noticia es verdadera o falsa.
En el informe del link, se menciona toda la etapa de preprocesamiento, y se muestra las matrices de confusión luego de ejecutar los distintos algoritmos:

- Regresión Logística
- Naive Bayes
- Árbol de decisión
- KNN

**Modelo para la detección de noticias falsas en Twitter**

Este proyecto se centra en detectar publicaciones con información falsa, en el contexto político colombiano de las elecciones presidenciales de 2022. Se plantean:

- Support Vector Machines
- Regresión Logística
- Naive Bayes
- Random Forest
- XGBoost
- Redes neuronales
- Bidirectional Encoder Representations from Transformers