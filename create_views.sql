-- -----------------------------------------------------
-- Assignment: (5), Spring, 2025
-- Student: To Thao Nhi Trinh
-- Email: tothaonhi.trinh@student.uts.edu.au
-- 
-- Database: Movie Social Network (Letterboxd Clone)
-- Description: This database powers a social network for movie enthusiasts 
-- where users can log films they've watched, write reviews, create lists, 
-- follow other users, and track where movies are available to stream.
-- Users can maintain personal diaries of their viewing experiences, rate films,
-- create curated collections, and discover new movies through social connections.
-- Inspired by: https://letterboxd.com/
-- -----------------------------------------------------

DROP VIEW IF EXISTS user_activity_summary CASCADE;
DROP VIEW IF EXISTS movie_availability CASCADE;

CREATE VIEW user_activity_summary AS
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
GROUP BY u.user_id, u.username, u.join_date, u.follower_count, u.following_count;

CREATE VIEW movie_availability AS
SELECT 
    m.title,
    m.release_year,
    m.genre,
    m.rating as movie_rating,
    vp.provider_name,
    vs.session_type,
    vs.quality_format,
    vs.price
FROM movie m
JOIN viewing_session vs ON m.movie_id = vs.movie_id
JOIN viewing_provider vp ON vs.provider_id = vp.provider_id
WHERE vs.price <= 10.00
ORDER BY m.rating DESC, vs.price ASC;