/*--------------- 
Duckdb queries för sakila.duckdb databasen
---------------*/
--
-- TASK 1 - A) 39 rader
SELECT
    title,
    length
FROM
    staging.film;

--
SELECT
    title,
    length
FROM
    staging.film
WHERE
    length > 180
ORDER BY
    length DESC;

--
-- TASK 1 - B)  5 rader
SELECT
    title,
    rating,
    length,
    description
FROM
    staging.film;

/*
Kastar ett brett "nät" här.
Jag normaliserar stora och småbokstäver till lowercase.
Jag filtrerar på ALLA titlar som innehåller 'love' i sig.
Mina 'sökparametrar' är fortfarande FÖR breda. Måste narrow it down.
 */
SELECT
    title,
    rating,
    length,
    description
FROM
    staging.film
WHERE
    LOWER(title) LIKE '%love%'
ORDER BY
    title;

--
/* 
Kastat ett smalare nät där jag här söker efter någonting mer specifikt.
Normaliserar alla bokstäver först.
Filtrerar på enbart love i titelns första ord eller sista ord.
 */
SELECT
    title,
    rating,
    length,
    description
FROM
    staging.film
WHERE
    LOWER(title) = 'love'
    OR LOWER(title) LIKE 'love %'
    OR LOWER(title) LIKE '% love'
    OR LOWER(title) LIKE '% love %'
ORDER BY
    title;

--
-- TASK 1 - C)
/* 
Shortest: 46 min.
Avg: 115.27min med en avrundning till max 2 decimaler.
Median: 114min.
Longest: 185min.
Totalt antal filmer: 1k.
 */
FROM
    staging.film;

--
SELECT
    MIN(length) AS shortest,
    ROUND(AVG(length), 2) AS average_length,
    MEDIAN (length) AS median_length,
    MAX(length) AS longest,
    COUNT(*) AS total_films
FROM
    staging.film;

--
-- TASK 1 - D) 1.66$ per dag.
/* 
Kolla vad för data type allting har.
rental_rate == DECIMAL
rental_duration == BIGINT
rental_rate / rental_duration == DOUBLE
 */
SELECT
    typeof (rental_rate) AS rate_type,
    typeof (rental_duration) AS duration_type,
    typeof (rental_rate / rental_duration) AS result_type
FROM
    staging.film
LIMIT
    10;

--
SELECT
    title,
    rental_rate,
    rental_duration,
    ROUND(CAST(rental_rate AS DOUBLE) / rental_duration, 2) AS cost_per_day
FROM
    staging.film;

--
SELECT
    title,
    rental_rate,
    rental_duration,
    ROUND(CAST(rental_rate AS DOUBLE) / rental_duration, 2) AS cost_per_day
FROM
    staging.film
ORDER BY
    cost_per_day DESC
LIMIT
    10;

--
-- TASK 1 - E) använder mig utav en JOIN (JOIN == INNER JOIN)
SELECT
    a.first_name || ' ' || a.last_name AS actor_name,
    COUNT(fa.film_id) AS number_of_films
FROM
    staging.actor a
    JOIN staging.film_actor fa ON a.actor_id = fa.actor_id
GROUP BY
    a.actor_id,
    actor_name
ORDER BY
    number_of_films DESC,
    actor_name ASC
LIMIT
    10;