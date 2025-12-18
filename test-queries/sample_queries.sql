-- -----------------------------------------------------------------------------------------
-- Sample Queries for Movie Social Network Database
-- Demonstrates all query types from the project documentation
-- -----------------------------------------------------------------------------------------

-- Query 1 - Simple Single Table Query
-- -----------------------------------------------------------------------------------------
-- Find all active users who joined in 2023,
-- showing their username, join date, and follower count,
-- ordered by most popular first.

SELECT username, join_date, follower_count
FROM users
WHERE EXTRACT(YEAR FROM join_date) = 2023
ORDER BY follower_count DESC;

/*
Expected Output:
 username   | join_date  | follower_count
------------|------------|---------------
 indiefilmfan| 2023-01-20 | 89
 solocinema  | 2023-11-15 | 2
 newuser     | 2023-12-01 | 0
*/


-- Query 2 - Natural Join Query
-- -----------------------------------------------------------------------------------------
-- Find public lists created by users,
-- showing username and list title for lists with more than 3 movies.

SELECT u.username, l.title, l.movie_count
FROM users u
NATURAL JOIN list l
WHERE l.is_public = true
  AND l.movie_count > 3
ORDER BY l.movie_count DESC;

/*
Expected Output:
 username    | title                     | movie_count
-------------|---------------------------|------------
 filmstudent | Film School Essentials    | 5
 cinemalover | 2023 Watchlist            | 4
 horrormaven | Horror Through the Decades| 4
*/


-- Query 3 - Cross Product Equivalent
-- -----------------------------------------------------------------------------------------
-- Same as query 2 but using cross product:
-- public lists with more than 3 movies and their creators.

SELECT u.username, l.title, l.movie_count
FROM users u, list l
WHERE u.user_id = l.user_id
  AND l.is_public = true
  AND l.movie_count > 3
ORDER BY l.movie_count DESC;

/*
Expected Output (same as Query 2):
 username    | title                     | movie_count
-------------|---------------------------|------------
 filmstudent | Film School Essentials    | 5
 cinemalover | 2023 Watchlist            | 4
 horrormaven | Horror Through the Decades| 4
*/


-- Query 4 - GROUP BY with HAVING
-- -----------------------------------------------------------------------------------------
-- Find movie genres that have an average rating above 6
-- and contain at least 2 movies.

SELECT 
    genre,
    COUNT(*) as movie_count,
    ROUND(AVG(rating)::numeric, 2) as avg_rating
FROM movie
WHERE genre IS NOT NULL
GROUP BY genre
HAVING AVG(rating) > 6 
   AND COUNT(*) >= 2
ORDER BY avg_rating DESC;

/*
Expected Output:
 genre               | movie_count | avg_rating
---------------------|-------------|------------
 Crime, Drama        | 2           | 9.05
 Drama               | 2           | 6.50
*/


-- Query 5 - Subquery
-- -----------------------------------------------------------------------------------------
-- Find users who have reviewed movies that are longer than 150 minutes.

SELECT DISTINCT u.username, u.email
FROM users u
WHERE u.user_id IN (
    SELECT DISTINCT r.user_id
    FROM review r
    WHERE r.movie_id IN (
        SELECT m.movie_id
        FROM movie m
        WHERE m.runtime > 150
    )
)
ORDER BY u.username;

/*
Expected Output:
 username    | email
-------------|-------------------
 cinemalover | cinema@email.com
 indiefilmfan| indie@email.com
*/


-- Query 6 - Self Join (No NATURAL JOIN)
-- -----------------------------------------------------------------------------------------
-- Find pairs of different users where both follow each other (mutual follows).

SELECT 
    u1.username as user1,
    u2.username as user2
FROM follower f1
JOIN follower f2 
    ON f1.follower_id = f2.following_id 
    AND f1.following_id = f2.follower_id
JOIN users u1 ON f1.follower_id = u1.user_id
JOIN users u2 ON f1.following_id = u2.user_id
WHERE u1.user_id < u2.user_id  -- Prevents duplicate pairs (A,B) and (B,A)
ORDER BY u1.username, u2.username;

/*
Expected Output:
 user1        | user2
--------------|--------------
 cinemalover  | moviebuff42
 cinemalover  | filmstudent
*/
