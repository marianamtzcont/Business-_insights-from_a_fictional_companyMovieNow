/*
		Create the database and the tables will be used.

The database belongs to a fictional movie rental company called MovieNow, which contains information about consumers, 
movie ratings, actor details, and more. The information and code provided here were downloaded from the course 
'Data-Driven Decision Making in SQL' on DataCamp. 

Tables in the Movie_now database: 

1. 'customers' table contains a column 'customer_id', a number which is a unique identifier for each customer, name, country,
    gender, date of birth and the date when the account for MovieNow was created.
	
2. 'movies' table includes a unique identifier movie_id, the title of the movie, the movie genre, the runtime, the release year,
    and, finally, what it costs to rent the movie.
	
3. 'renting' table records all movie rentals,'renting_id' is a unique identifier for each movie rental. The column 'customer_id' 
    tells us which customer rented the movie and 'movie_id' tells us which movie the customer rented. The rating a customer gives
	after watching the movie is stored in the column 'rating' which has values between 1 and 10, where 10 is the best rating. 
	The final column is the rental date.
	
4. 'actors' table contains information about the actors in the movies. Besides the unique identifier 'actor_id', we have the 
    actor's name, year of birth, nationality, and gender.
5. 'actsin' table shows which actor appears in which movie. Besides the unique identifier actsin_id, it includes movie_id and 
    actor_id.
	
*/ 

CREATE database Movie_now;

DROP TABLE IF EXISTS "movies";
CREATE TABLE movies
(
    movie_id INT PRIMARY KEY,
    title TEXT,
    genre TEXT,
    runtime INT,
    year_of_release INT,
    renting_price numeric
);
SELECT *
FROM movies;

COPY movies
	FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/4068/datasets/3eebf2a145b76fee37357bcd55ac54577c03c805/movies_181127_2.csv"' (DELIMITER ',', FORMAT CSV, HEADER);


DROP TABLE IF EXISTS "actors";
CREATE TABLE actors
(
    actor_id integer PRIMARY KEY,
    name character varying,
    year_of_birth integer,
    nationality character varying,
    gender character varying
);


COPY actors
	FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/4068/datasets/c67f20fa317e8229eed7586cda8bfce5fc177444/actors_181127_2.csv"' (DELIMITER ',', FORMAT CSV, HEADER);


DROP TABLE IF EXISTS "actsin";
CREATE TABLE actsin
(
    actsin_id integer PRIMARY KEY,
    movie_id integer,
    actor_id integer
);


COPY actsin
	FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/4068/datasets/6efc08575effcc9327c82fea18aaf22dfd61cc27/actsin_181127_2.csv"' (DELIMITER ',', FORMAT CSV, HEADER);


DROP TABLE IF EXISTS "customers";
CREATE TABLE customers
(
	customer_id integer PRIMARY KEY,
    name character varying,
    country character varying,
    gender character varying,
    date_of_birth date,
    date_account_start date
);


COPY customers
	FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/4068/datasets/4b1767d8e638ab26e62d98517fef297d72260992/customers_181127_2.csv"' (DELIMITER ',', FORMAT CSV, HEADER);


DROP TABLE IF EXISTS "renting";
CREATE TABLE renting
(
    renting_id integer PRIMARY KEY,
    customer_id integer NOT NULL,
    movie_id integer NOT NULL,
    rating integer,
    date_renting date
);


COPY renting
	FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/4068/datasets/d36ed7719976092a9b3387c8a2ac077914c9e1d2/renting_181127_2.csv"' (DELIMITER ',', FORMAT CSV, HEADER);

