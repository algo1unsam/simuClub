# Clubes
En un municipio, los clubes de barrio están regulados de manera tal que se puede saber la calidad de cada uno. Se pide modelar utilizando el paradigma de objetos el dominio de un sistema que facilite la administración de estos clubes.

Cada club debe poder ser evaluado. Al hacerlo se determina un número (no acotado) de puntos que se calcula a partir de las actividades que allí funcionan, tales como los equipos que practican deportes o las actividades sociales que periódicamente realizan algunos de sus socios.

De un equipo de un club se conoce cuál es su plantel (conjunto de jugadores) y su capitán (el cual también es, obviamente, miembro del plantel). De cada jugador se conoce el valor se su pase y la cantidad de partidos que jugó para su club.

De una actividad social se conoce su socio organizador y todos los socios participantes de la misma. De cada socio se sabe cuántos años lleva en la institución.

A efectos de este sistema, todos los jugadores de un equipo son también socios del club; por lo tanto, podría darse que un jugador participe de una actividad social.

Un socio pertenece a un único club.

Cada actividad (sea un equipo o una actividad social) es evaluada. La evaluación de un club depende de las evaluaciones de sus actividades.
Si bien cualquier club puede tener equipos y actividades sociales, cada club define un perfil que determina el foco de la institución. Éste puede ser tradicional, comunitario, o profesional.


## Requerimientos.


### 1 Consultas simples
- a. Saber todos los socios de un club, todos los jugadores de un equipo y todos los socios de una actividad social

- b. Saber el socio más viejo de un club.

- c. Obtener los socios destacados de un club, un socio destacado es aquel que es capitán de un equipo u organizador de una actividad social.

### 2 Municipio
El municipio quiere saber dando un socio saber a que club pertence.

### 3 Estrella 

- a. Saber si un socio es estrella, lo cual es distinto de si se trata de un jugador o un socio común. 
Un socio común es estrella si lleva más de 20 años en la institución. 
Un jugador que tiene 50 o más partidos en el club es una estrella.
 
Pero un jugador con menos partidos también podría serlo dependiendo del perfil del club:
Si juega en un club Profesional, es estrella si el valor de su pase supera un valor configurable para el sistema, que es el mismo para todos los jugadores. 
Si juega en un club Comunitario, es estrella si participa en 3 o más actividades del club (deportivas o sociales).
Si juega en un club tradicional, puede ser estrella tanto porque su pase supera el valor configurado o porque participa en 3 o más actividades del club.

Ejemplo: En un club tradicional, bellota, bombon y burbuja son jugadoras, y el profesor es un socio comun.
  - Bellota: su pase es de un millon, juega al futbol y al basquet. Aun no disputa ningún partido. Tiene 0 años de antiguedad. 
  - Bombon: su pase es de 1000, juega al basquet. tiene 100 partidos. Tiene 0 años de antiguedad.
  - Burbuja: su pase es de 1000, juega al futbol y al basquet. También va a los asados de los domingos. Tiene 10 partidos jugados. Tiene 0 años de antiguedad
  - Profesor: solo asiste a los asados del domingo, tiene anio de antiguedad. Tiene 0 años de antiguedad.
  - el valor del pase para ser considerado estrella es de 500000.

En este caso Bellota es estrella por el valor del pase. Burbuja es estrella por los partidos jugados. 
Burbuja es estrella por tener 3 actividades. El profesor no es estrella ya que no tiene la antiguedad requerida

En las mismas condiciones pero en un club profesional,  solo Bellota y Bombon son estrellas, mientras que 
en un club comunitario solo Bombón y Burbuja son estrella.

- b.También se pide Obtener de entre los socios destacados, aquellos que además son estrellas.



### 4 Evaluaciones de actividades

Obtener la evaluación  de una actividad, el cual se mide como un número de unidades.
Los equipos suman 5 unidades por campeonato obtenido, 2 unidades por cada miembro del plantel y 5 puntos más si su capitán es una estrella.  
Para un equipo de fútbol vale la regla de todos los equipos, pero se le suman además 5 puntos por cada estrella del plantel (En este caso si el capitán es una estrella aportaría 10 puntos, 5 por la regla de “capitán estrella” y 5 por la regla de “miembro del plantel estrella”).
La evaluación de una actividad social es un valor que se conoce para cada actividad
 

### 5 Evaluaciones de clubes
Obtener la evaluación de un club, el cual se calcula como la división entre un número llamado evaluación bruta y la cantidad de socios del mismo. Para la evaluación bruta también se tiene en cuenta el gasto mensual del club, que es un valor que se conoce para cada club. 
La evaluación bruta se calcula distinto para cada perfil:
  - Tradicional: Es la suma de las evaluaciones de sus actividades menos el gasto mensual del club.
  - Comunitario: Es la suma de las evaluaciones de sus actividades  (no interesa los gastos)
  - Profesional: Es el doble de la suma de las evaluaciones de sus actividades menos 5 veces el gasto mensual del club.

### 7 Equipos experimentados
Saber si un equipo es experimentado. Un equipo es experimentado si todos los miembros del plantel tienen al menos 10 partidos jugados.

### 8 Clubes Prestigiosos
Saber si un club es prestigioso. Un club es prestigioso si tiene al menos un equipo experimentado o al menos una de sus actividades sociales tiene 5 o más participantes estrellas.
    


