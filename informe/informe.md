# Inteligencia Artificial I - Informe Proyecto Final.

## Heartbreak: Modelo para detectar cuentas falsas de Instagram

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

// TODO: Agregar todas las maetricas del dataset

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