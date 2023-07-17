/*    
 						Business Case: 

MovieNow considers to invest money in new movies, based on the data in wich kind of 
movies the new budget should be invested?

Considering that it is more expensive for MovieNow to make recently produced movies 
available compared to older ones, it is a good starting point to investigate customer 
preferences based on the year of movie release.

Do customers give higher ratings to recently produced movies compared to older ones?
Is there a difference in preferences across countries?

To answer these questions, we will focus only on records of movies with at least 4 ratings 
and rentals since 2018-04-01. We will count the number of movie rentals, the number of different
movies, and calculate the average rating.

*/

SELECT c.country, 
    m.year_of_release,
    COUNT(*) AS n_rentals, 
    COUNT(DISTINCT r.movie_id) AS n_movies,
    ROUND(AVG(rating),2) AS avg_rating
FROM renting AS r
LEFT JOIN customers AS c 
ON c.customer_id= r.customer_id
LEFT JOIN movies AS m 
ON m.movie_id= r.movie_id
WHERE r.movie_id IN (
                    SELECT movie_id
                    FROM renting 
                    GROUP BY movie_id 
                    HAVING COUNT(rating)>= 4)
AND r.date_renting>='2018-04-01'
GROUP BY ROLLUP(m.year_of_release, c.country)
ORDER BY c.country, m.year_of_release;

 -- To determine the type of movies in which the new budget should be invested we can consider 
 -- allocating funds to movies of the highest-rated genres.
 -- Do customers have higher ratings for some movie genres rather than others?

SELECT genre,
        AVG(rating) AS avg_rating,
        COUNT(rating) AS n_rating,
        COUNT(*) AS n_rentals,
        COUNT(DISTINCT m.movie_id) AS n_movies 
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE r.movie_id IN ( 
	SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(rating) >= 3 )
AND r.date_renting >= '2018-01-01'
GROUP BY genre
ORDER BY n_rating DESC;
 -- Also, we can get some insights about if there is some customer preferences for certain 
 -- actors based in the actors nationality and gender. 
 -- Do customers give higher ratings to actors of certain nationalities and genders compared to others?

%%sql
SELECT a.nationality,
        a.gender,
        ROUND(AVG(r.rating),2) AS avg_rating,
        COUNT(r.rating) AS n_rating,
        COUNT(*) AS n_rentals,
        COUNT(DISTINCT a.actor_id) AS n_actors
FROM renting AS r
LEFT JOIN actsin AS ai
ON ai.movie_id = r.movie_id
LEFT JOIN actors AS a
ON ai.actor_id = a.actor_id
WHERE r.movie_id IN (
                    SELECT movie_id
                    FROM renting
                    GROUP BY movie_id
                    HAVING COUNT(rating) >= 4)
AND r.date_renting >= '2018-04-01'
GROUP BY CUBE (nationality,gender);

/*
Based on the resulting table from analyzing 999 records, it appears that there is a preference 
for British and USA movies, with 253 and 614 rentals respectively. Additionally, it was observed 
that male actors are slightly preferred, as in 661 out of the 999 analyzed movies, the actor was male.

With these insights into customer preferences, the company can make informed, data-driven decisions.

*/