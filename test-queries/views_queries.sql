
-- VIEW provides a simplified interface to complex data.
-- It updates automatically when underlying data changes.

-- Before using the view directly, let's see complex query that the view simplifies:
SELECT 
    u.user_id,
    u.username,
    u.join_date,
    u.follower_count,
    u.following_count,
    COUNT(DISTINCT r.review_id) as review_count,
    COUNT(DISTINCT d.diary_id) as diary_entries,
    COUNT(DISTINCT l.list_id) as list_count,
    COALESCE(AVG(r.rating), 0) as avg_review_rating,
    COUNT(DISTINCT f.following_id) as users_following
FROM users u
LEFT JOIN review r ON u.user_id = r.user_id
LEFT JOIN diary d ON u.user_id = d.user_id
LEFT JOIN list l ON u.user_id = l.user_id
LEFT JOIN follower f ON u.user_id = f.follower_id
GROUP BY u.user_id, u.username, u.join_date, u.follower_count, u.following_count
ORDER BY u.join_date DESC
LIMIT 5;

-- After View: Using the view is much simpler
SELECT *
FROM user_activity_summary
ORDER BY join_date DESC
LIMIT 5;

/*
Expected Output (example):
 user_id | username    | join_date  | follower_count | following_count | review_count | diary_entries | list_count | avg_review_rating | users_following
---------|-------------|------------|----------------|-----------------|--------------|---------------|------------|-------------------|-----------------
 U9      | newuser     | 2023-12-01 | 0              | 0               | 0            | 0             | 1          | 0.00              | 0
 U10     | solocinema  | 2023-11-15 | 2              | 0               | 0            | 0             | 0          | 0.00              | 0
 U6      | indiefilmfan| 2023-01-20 | 89             | 112             | 1            | 1             | 1          | 5.00              | 1
*/

-- -----------------------------------------------------------------------------------------
-- Additional Demonstration Queries
-- -----------------------------------------------------------------------------------------

-- 1. Show movie availability (using the view)
SELECT *
FROM movie_availability
LIMIT 5;

/*
Expected Output:
 title                    | release_year | genre        | movie_rating | provider_name | session_type | quality_format | price
--------------------------|--------------|--------------|--------------|---------------|--------------|----------------|-------
 The Shawshank Redemption | 1994         | Drama        | 9.3          | Netflix       | streaming    | 4K             | 15.99
 The Dark Knight          | 2008         | Action...    | 9.0          | AMC Theaters  | theater      | IMAX           | 12.50
*/

-- 2. Test view updates automatically
-- First, check current state
SELECT username, review_count, avg_review_rating 
FROM user_activity_summary 
WHERE username = 'cinemalover';

-- Add a new review
INSERT INTO review (review_id, user_id, movie_id, rating, content)
VALUES ('R11', 'U1', 'M7', 4.0, 'Another great review!');

-- View automatically reflects the change
SELECT username, review_count, avg_review_rating 
FROM user_activity_summary 
WHERE username = 'cinemalover';

-- Clean up (optional)
DELETE FROM review WHERE review_id = 'R11';

-- -----------------------------------------------------------------------------------------
-- Summary Statistics
-- -----------------------------------------------------------------------------------------

SELECT 
    'Database Summary' as category,
    COUNT(*) as value
FROM (
    SELECT 'Total Users' as item, COUNT(*) FROM users
    UNION ALL
    SELECT 'Total Movies', COUNT(*) FROM movie
    UNION ALL
    SELECT 'Total Reviews', COUNT(*) FROM review
    UNION ALL
    SELECT 'Total Lists', COUNT(*) FROM list
    UNION ALL
    SELECT 'Total Diary Entries', COUNT(*) FROM diary
    UNION ALL
    SELECT 'Total Follow Relationships', COUNT(*) FROM follower
) as summary;
