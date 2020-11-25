# ****** Sesion 07: Configuración de Bases de Datos Locales ****** #

CREATE DATABASE bedu_test;
DROP DATABASE bedu_test;

/* Para evitar errores y automatizar*/
CREATE DATABASE IF NOT EXISTS bedu_test;
DROP DATABASE IF EXISTS bedu_test;

USE bedu_test;

/* Tabal de usuarios para user.dat*/
CREATE TABLE IF NOT EXISTS users 
(
	id INT PRIMARY KEY,
    gender CHAR(1),
    age INT,
    occupation INT,
    zip_code VARCHAR(20)
);

DROP TABLE IF EXISTS users;

/* ****** Reto 1: Realizando operaciones con tablas ****** */
/* Descripcion: 
    Realizar operaciones SQL para administrar tablas
    Crear tablas acorde a los datos
*/
# Definir los campos y tipos de datos para la tabla movies haciendo uso de los archivos movies.dat y README.
# Crear la tabla movies (recuerda usar el mismo nombre del archivo sin la extensión para vincular nombres de tablas con archivos).
/* Tabla Movies*/
CREATE TABLE IF NOT EXISTS movies
(
	id INT PRIMARY KEY,
    title VARCHAR(120),
    genres VARCHAR(100)
);

DROP TABLE IF EXISTS movies;

# Definir los campos y tipos de datos para la tabla ratings haciendo uso de los archivos ratings.dat y README.
# Crear la tabla ratings (recuerda usar el mismo nombre del archivo sin la extensión para vincular nombres de tablas con archivos)
/* Tabla Raitings*/
# Fecha: Unix Epoch - Tiempo que ha trascurrido desde una fecha determinada
# Tabla pivote para hacer relacion entre User y Movies
CREATE TABLE IF NOT EXISTS ratings
(	
    user_id INT,
    movie_id INT,
    rating INT,
    time_stamp BIGINT    
);

# Tabla Ratings si se requiriera manejar llaves foraneas.
CREATE TABLE IF NOT EXISTS ratings
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    movie_id INT,
    rating INT,
    time_stamp BIGINT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);


/* ****** Reto 2: Importando datos a una tabla en formato CSV ****** */
/* Desarrollo: 
    Usando como base el archivo movies.dat, limpiarlo e importar los datos en la tabla movies creada en el Reto 1.
    Usando como base el archivo ratings.dat, limpiarlo e importar los datos en la tabla ratings creada en el Reto 2.
*/

/* Para importar los CSV es necesario cambiar los "::" por ; o cualquier otro separador y guardarlo como CSV 
    En MySQL Click derecho en la base de datos y seleccionar: Table Data Import Wizard
    Seleccionar el CSV, seleccionar el separador e importar
*/

/* ****** Reto 3: Realizando operaciones con Colecciones e importando datos ****** */
/* Desarrollo: 
    Se deberá de crear colecciones e importar los datos de los archivos movies.csv y ratings.csv.
*/

/* Lo primero para importar en Mongo es crear una Base de Datos
    Ahora para cada set  de datos se creo una coleecion dentro de la base de datos creada anteriormente.
    Se selecciona el archivo con los datos a importar, el formato (CSV)
    Se elige el tipo de datos que tendra cada columna y se importan los datos
*/