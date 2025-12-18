
-- Check Statements: Demonstrates that CHECK constraints are enforced

-- Example 1: Try to insert invalid rating (should fail)
INSERT INTO review (review_id, user_id, movie_id, rating)
VALUES ('R99', 'U1', 'M1', 5.5);  -- Rating must be in 0.5 increments

-- Example 2: Try to insert negative follower count (should fail)
INSERT INTO users (user_id, username, email, follower_count)
VALUES ('U99', 'test', 'test@email.com', -1);  -- follower_count >= 0

-- Example 3: Try to insert movie with invalid year (should fail)
INSERT INTO movie (movie_id, title, release_year)
VALUES ('M99', 'Test Movie', 1870);  -- release_year >= 1888


-- Action Statements: Demonstrates referential integrity with CASCADE DELETE
-- When a user is deleted, all their content is automatically removed

-- Check user's content before deletion
SELECT 'Reviews:' as content_type, COUNT(*) FROM review WHERE user_id = 'U1'
UNION ALL
SELECT 'Lists:', COUNT(*) FROM list WHERE user_id = 'U1'
UNION ALL
SELECT 'Diary entries:', COUNT(*) FROM diary WHERE user_id = 'U1'
UNION ALL
SELECT 'Followers:', COUNT(*) FROM follower WHERE follower_id = 'U1' OR following_id = 'U1';

-- Delete the user (this will cascade to all related records)
DELETE FROM users WHERE user_id = 'U1';

-- Verify all related records were deleted
SELECT 'Reviews:' as content_type, COUNT(*) FROM review WHERE user_id = 'U1'
UNION ALL
SELECT 'Lists:', COUNT(*) FROM list WHERE user_id = 'U1'
UNION ALL
SELECT 'Diary entries:', COUNT(*) FROM diary WHERE user_id = 'U1';
-- All should return 0
*/

