-- Teesside University - SQL Server Queries
-- Author: Ekan Ogedegbe
-- date: 2024-05-08

-- Database: Movies.BAK -- Movies Ranking Data 


-- a)	Module 3: Writing SELECT Queries with single Table

-- Demo A1: Writing Simple SELECT Query 

USE movies;
GO
-- Select and execute the following query to retrieve all columns, 
-- all rows from dbo.movie table
SELECT *
FROM dbo.movie

-- Step 7: Simple SELECT query with calculated column
-- Select and execute the following query to manipulate columns from the dbo.movie table. 
-- Note the lack of name for the new calculated column.
SELECT movie_id, title, budget, popularity, runtime, (popularity * runtime)
FROM dbo.movie;

-- Demo A2: Eliminating Duplicates with DISTINCT 

USE movies;
GO

-- Step 1. Select and execute the following query without distinct 

SELECT budget, revenue, runtime, vote_average, vote_count
FROM dbo.movie;

-- Step 2. Seslect and execute the following query to distinct budget, revenue, runtime, vote_average and vote_count columns, 
-- all rows from dbo.movie table

SELECT DISTINCT budget, revenue, runtime, vote_average, vote_count
FROM dbo.movie;

-- Demo A3: Using Column and Table Aliases Lesson 

USE movies;
GO
-- Select and execute the following query to use column and table aliases, 
-- from dbo.language table

-- Using Table Aliases
SELECT l.language_id, l.language_code,  l.language_name
FROM language AS l

-- Using Column Aliases
SELECT language_id AS LanguageID, language_code AS LanguageCode, language_name AS LanguageName
FROM language;

-- Demo A4: Writing Simple CASE Expressions

USE movies;
GO
-- Select and execute the following query to write simple CASE expression, 
-- from dbo.movie table

SELECT
    movie_id,
	title,
	overview,
    CASE movie_status
        WHEN 'released' THEN 'Available for viewing'
        WHEN 'post-production' THEN 'Currently in post-production'
        WHEN 'filming' THEN 'Currently filming'
        ELSE 'Unknown status'
    END AS movie_status_description
FROM movie; 

-- b)	Module 4: Joining and Querying Multiple Tables 

-- Demo B1: How to provide data from 2 related tables with a Join 

USE movies;
GO
-- Select and execute the following query to provide data from 2 related tables with a Join, 
-- from dbo.department and dbo.movie_crew table

SELECT d.department_id, d.department_name, mc.job
FROM department AS d JOIN movie_crew AS mc ON d.department_id = mc.department_id; 

-- Demo B2: How to Query with Inner Joins 

USE movies;
GO
-- Select and execute the following query to query with Inner Joins, 
-- from dbo.person and dbo.movie_cast table

SELECT p.person_id, p.person_name, mc.character_name, mc.cast_order
FROM person AS p
INNER JOIN movie_cast AS mc ON p.person_id = mc.person_id; 

-- Demo B3: How to Query with Outer Joins

USE movies;
GO
-- Select and execute the following query to query with Outer Joins, 
-- from dbo.department and dbo.movie_crew table

-- Using Left JOIN
SELECT department.department_name, movie_crew.job
FROM department
LEFT JOIN movie_crew ON department.department_id = movie_crew.department_id;

-- Demo B4: How Query with Cross Joins and Self Joins

USE movies;
GO
-- Select and execute the following query to query with Cross Joins and Self Joins, 
-- from dbo.language and dbo.movie_languages table

-- Using Cross JOIN
SELECT * FROM language
CROSS JOIN movie_languages;

-- Using Self Join
SELECT mc.person_id, mc.job, mc2.department_id
FROM movie_crew AS mc
JOIN movie_crew AS mc2 ON mc.department_id = mc2.person_id;

-- c)	Module 5: Sorting and Filtering Data 

-- Demo C1: How to Sort Data

USE movies;
GO
-- Select and execute the following query to sort data, 
-- from dbo.movie table

-- Using ASC ascending order
SELECT * 
FROM movie
ORDER BY popularity;

-- Using DESC descending order
SELECT * 
FROM movie
ORDER BY budget DESC;

-- Demo C2: How to Filter Data with Predicates

USE movies;
GO
-- Select and execute the following query to filter data with predicates, 
-- from dbo.language and dbo.movie table

SELECT * 
FROM language
WHERE language_id = 24574;

SELECT * 
FROM movie 
WHERE movie_id > 300000 AND budget >= 50000000;

-- Demo C3: How to Filter Data with TOP and OFFSET-FETCH

USE movies;
GO
-- Select and execute the following query to filter data using TOP and OFFSET_FETCH, 
-- from dbo.movie table

-- Using TOP 
SELECT TOP 7 * 
FROM movie
ORDER BY revenue DESC;

-- Using OFFSET-FETCH

SELECT *
FROM movie
ORDER BY budget DESC
OFFSET 7 ROWS
FETCH NEXT 5 ROWS ONLY;

-- Demo C4: How to work with Unknown Values

USE movies;
GO
-- Select and execute the following query to work with Unknown values, 
-- from dbo.movie table

SELECT
    CASE 
        WHEN budget IS NULL THEN 'Unknown'
        ELSE budget
    END AS budget,
    CASE 
        WHEN popularity IS NULL THEN 'Unknown'
        ELSE popularity 
    END AS popularity,
	CASE 
        WHEN revenue IS NULL THEN 'Unknown'
        ELSE revenue 
    END AS revenue,
	CASE 
        WHEN runtime IS NULL THEN 'Unknown'
        ELSE runtime 
    END AS runtime
FROM movie;

-- d)	Module 6: Working with Data Types 

-- Demo D1: Working with Data Type examples 

USE movies;
GO

-- Working with Data Type 

-- Step 1. Create a table

CREATE TABLE Film_Name (
    movie_id INT,
    title VARCHAR(200),
    popularity DECIMAL(10, 6),
    vote_average DECIMAL (10, 2),
    release_date DATE
);

-- Step 2. Insert data into the Film_Name table
INSERT INTO Film_Name(movie_id, title, popularity, vote_average, release_date)
VALUES 
(1, 'Avatar', 290.945555, 65.50, '2024-02-19'),
(2, 'Star Wars', 126.393695, 44.44, '1977-05-25'), 
(3, 'Forrest Gump', 138.133331, 37.89, '1994-07-06')

-- Step 3. Query the Film_Name table
SELECT * FROM Film_Name;

-- Demo D2: Working with Character Data

USE movies;
GO

-- Working with Character Data

USE movies;
GO

-- Working with Character Data

-- Step 1. Create a table

CREATE TABLE Movie_Actor (
    movie_actor_id INT,
    movie_actor_name VARCHAR(100),
    country VARCHAR(50),
    languages CHAR(30),
    film_acted TEXT
);

-- Step 2. Insert data into the Movie_Actor table

INSERT INTO Movie_Actor(movie_actor_id, movie_actor_name, country, languages, film_acted)
VALUES (1, 'Jason Statam', 'United States of America', 'English', 'The Beekeeper'),
(2, 'Shah Rukh Khan', 'India', 'Hindi', 'Asoka'),
(3, 'Chris Hemsworth', 'Australia', 'English', 'Furiosa: A mad maga saga')

-- Step 3. Query the Movie_Actor table

SELECT * FROM Movie_Actor;

-- Demo D3: Working with Date and Time Data 

USE movies;
GO

-- Working with Data and Time Data

-- Step 1. Create a table 

CREATE TABLE Movie_Purchase (
    purchase_id INT,
    movie_id INT,
    purchase_date DATE,
    purchase_time TIME
);

-- Step 2. Insert data into the Order table
INSERT INTO Movie_Purchase (purchase_id, movie_id, purchase_date, purchase_time)
VALUES (1, 6, '2021-02-12', '10:30:00'),
(2, 5, '2021-09-24', '15:24:30'),
(3, 1, '2022-01-10', '07:12:48')

-- Step 3. Query the Order table
SELECT * FROM Movie_Purchase;

-- e)	Module 7: Using DML to Modify Data 

-- Demo E1: Adding Data to Tables

USE movies;
GO

-- Step 1. Select and execute the following query to see all data in dbo.department table

SELECT * FROM department

-- Step 2. Select and execute the following query to add data to dbo.department table

INSERT INTO department(department_id, department_name)
VALUES 
(13, 'Script Writing'),
(14, 'VFX Editing')

-- Step 3. Select and execute the following query to see all data in dbo.gender table

SELECT * FROM dbo.gender

-- Step 4. Select and execute the following query to add data to dbo.gender table

INSERT INTO gender(gender_id, gender)
 VALUES 
(3, 'Transgender'),
(4, 'Genderqueer'),
(5, 'Cisgender')

-- Demo E2: Modifying and Removing Data

USE movies;
GO
-- Modifying data
-- Step 1. Select and execute the following query to see all data of a single row in dbo.movie table

SELECT * FROM movie WHERE movie_id = 5

-- Step 2. Modify or Update data in a single row in dbo.movie table

UPDATE movie
SET homepage = 'http://www.fourrooms.com/movie/four-rooms/', popularity = 25.900000
WHERE movie_id = 5;

-- Removing data
-- Step 3. Select and execute the following query to see all data in dbo.movie_actor table

SELECT * FROM Movie_Actor

-- Step 4. Execute the following query to Remove Data from the movie_actor table

DELETE FROM Movie_Actor
WHERE languages = 'English';

-- Demo E3: Generating Automatic Column Values

USE movies;
GO
-- Step 1. Select and execute the following query to Generate Automatic column values, 

CREATE TABLE movie_rating (
    rating_id INT IDENTITY(1,1) PRIMARY KEY,
    rating DECIMAL(4, 2),
    rating_source VARCHAR(100),
);

-- Step 2. Inserting data into the movie table
INSERT INTO movie_rating (rating, rating_source)
VALUES (3.5, 'Imdb'),
       (5.0, 'rottentomatoe'),
       (4.9, 'Metacritic');

-- f)	Module 8: Using Built-In Functions

-- Demo F1: Writing Queries with Built-In Functions

USE movies;
GO
-- Select and execute the following query using built-in functions, 

-- 1. Aggregate Function
-- a. COUNT(*)

SELECT COUNT(*) AS movie_rows FROM movie;

-- b. SUM(column_name)

SELECT SUM(budget) AS total_budget FROM movie;

-- c. AVG(column_name)

SELECT AVG(vote_count) AS avg_vote_count FROM movie;

-- d. MIN(column_name)

SELECT MIN(popularity) AS minimum_popularity FROM movie;

-- e. MAX(column_name)

SELECT MAX(revenue) AS maximum_revenue FROM movie;

-- 2. String Function
-- a. CONCAT()

SELECT CONCAT(title, ' ', 'was budgeted at', ' ', budget) AS full_information FROM movie;

-- b. UPPER(column_name)

SELECT UPPER(character_name) AS character_name FROM movie_cast;

-- c. LOWER(column_name)

SELECT LOWER(job) AS job_description FROM movie_crew;

-- Demo F2: Using Conversion Functions

USE movies;
GO
-- Select and execute the following query using conversion functions, 

-- 1. CAST and CONVERT Functions
-- a. CAST Function

SELECT CAST(vote_average AS INT) AS vote_average FROM movie

-- b. CONVERT Function

SELECT CONVERT(INT, runtime) AS runtime FROM movie;

-- Demo F3: Using Logical Functions

USE movies;
GO
-- Select and execute the following query using logical functions, 

-- 1. Logical Functions
-- a. ISNULL Function

SELECT ISNULL(homepage, 'Unknown') AS homepage FROM movie;

-- b. COALESCE Function

SELECT COALESCE(vote_average, vote_count, 0) AS vote_average FROM movie;

-- c. CASE Function

SELECT 
    title,
    CASE 
        WHEN vote_count > 5000 THEN 'High'
        ELSE 'Low'
    END AS vote_count_flag
FROM movie;

-- Demo F4: Using Functions to Work with NULL 

USE movies;
GO
-- Select and execute the following query using functions to work with NULL, 

-- 1. ISNULL Function

SELECT homepage FROM movie WHERE homepage IS NULL;

-- b. IS NOT NULL Function

SELECT homepage FROM movie WHERE homepage IS NOT NULL;

-- c. CASE Function

SELECT 
    title,
    CASE 
        WHEN revenue IS NULL THEN 'No Revenue'
        ELSE 'Revenue Exists'
    END AS revenue_flag
FROM movie;

