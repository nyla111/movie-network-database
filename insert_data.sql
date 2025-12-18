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

-- Insert sample data for Users (including users with no followers/following)
INSERT INTO users (user_id, username, email, bio, avatar_URL, join_date, follower_count, following_count) VALUES
('U1', 'cinemalover', 'cinema@email.com', 'Film enthusiast since 1995. Specializing in classic Hollywood and international cinema. Host weekly movie nights.', 'https://example.com/avatar1.jpg', '2020-01-15', 245, 187),
('U2', 'moviebuff42', 'buff42@email.com', 'Watching everything from silent classics to modern blockbusters. Film critic for local newspaper.', 'https://example.com/avatar2.jpg', '2020-03-22', 189, 203),
('U3', 'filmstudent', 'student@email.edu', 'NYU Film School graduate. Focused on auteur theory and cinematography analysis.', 'https://example.com/avatar3.jpg', '2021-06-10', 156, 98),
('U4', 'casualviewer', 'viewer@email.com', 'Just here for the good movies. Not a critic, just someone who loves great storytelling.', 'https://example.com/avatar4.jpg', '2022-11-05', 45, 67),
('U5', 'directorfan', 'directors@email.com', 'Following the complete works of Kubrick, Nolan, and Scorsese. Creating comprehensive director retrospectives.', 'https://example.com/avatar5.jpg', '2021-09-18', 178, 145),
('U6', 'indiefilmfan', 'indie@email.com', 'Passionate about independent cinema and discovering hidden gems from film festivals.', 'https://example.com/avatar6.jpg', '2023-01-20', 89, 112),
('U7', 'horrormaven', 'horror@email.com', 'Horror film specialist. From Universal classics to modern psychological thrillers.', 'https://example.com/avatar7.jpg', '2022-07-14', 203, 167),
('U8', 'scifigeek', 'scifi@email.com', 'Science fiction enthusiast. Analyzing futuristic concepts and their real-world implications.', 'https://example.com/avatar8.jpg', '2021-12-03', 167, 134),
('U9', 'newuser', 'new@email.com', 'Just joined the community! Excited to discover new films.', 'https://example.com/avatar9.jpg', '2023-12-01', 0, 0), -- User with no followers/following
('U10', 'solocinema', 'solo@email.com', 'I prefer to watch films alone and rarely interact socially.', 'https://example.com/avatar10.jpg', '2023-11-15', 2, 0); -- User with followers but not following anyone

-- Insert sample data for Movies (including movies without reviews)
INSERT INTO movie (movie_id, title, release_year, director, country, rating, genre, plot_summary, runtime, poster_url) VALUES
('M1', 'The Shawshank Redemption', 1994, 'Frank Darabont', 'USA', 9.3, 'Drama', 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency. Based on Stephen King''s novella.', 142, 'https://example.com/shawshank.jpg'),
('M2', 'The Godfather', 1972, 'Francis Ford Coppola', 'USA', 9.2, 'Crime, Drama', 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son. A masterpiece of American cinema.', 175, 'https://example.com/godfather.jpg'),
('M3', 'The Dark Knight', 2008, 'Christopher Nolan', 'USA', 9.0, 'Action, Crime, Drama', 'Batman faces the Joker, a criminal mastermind who seeks to undermine society through chaos. Heath Ledger''s iconic performance.', 152, 'https://example.com/darkknight.jpg'),
('M4', 'Parasite', 2019, 'Bong Joon Ho', 'South Korea', 8.6, 'Comedy, Drama, Thriller', 'A poor family schemes to become employed by a wealthy family and infiltrate their household. Winner of the Palme d''Or and Best Picture Oscar.', 132, 'https://example.com/parasite.jpg'),
('M5', 'Spirited Away', 2001, 'Hayao Miyazaki', 'Japan', 8.6, 'Animation, Adventure, Family', 'A young girl wanders into a world ruled by gods, witches, and spirits. Studio Ghibli''s masterpiece that won the Academy Award for Best Animated Feature.', 125, 'https://example.com/spirited.jpg'),
('M6', 'Inception', 2010, 'Christopher Nolan', 'USA', 8.8, 'Action, Adventure, Sci-Fi', 'A thief who steals corporate secrets through dream-sharing technology is given the inverse task of planting an idea into a CEO''s mind. Mind-bending concepts.', 148, 'https://example.com/inception.jpg'),
('M7', 'Pulp Fiction', 1994, 'Quentin Tarantino', 'USA', 8.9, 'Crime, Drama', 'The lives of two mob hitmen, a boxer, and a pair of diner bandits intertwine in four tales of violence and redemption. Nonlinear storytelling at its best.', 154, 'https://example.com/pulpfiction.jpg'),
('M8', 'The Matrix', 1999, 'Lana Wachowski, Lilly Wachowski', 'USA', 8.7, 'Action, Sci-Fi', 'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers. Red pill or blue pill?', 136, 'https://example.com/matrix.jpg'),
('M9', 'Goodfellas', 1990, 'Martin Scorsese', 'USA', 8.7, 'Biography, Crime, Drama', 'The story of Henry Hill and his life in the mob, covering his relationship with his wife and his mob partners. "As far back as I can remember, I always wanted to be a gangster."', 146, 'https://example.com/goodfellas.jpg'),
('M10', 'Seven Samurai', 1954, 'Akira Kurosawa', 'Japan', 8.6, 'Action, Drama', 'A poor village under attack by bandits recruits seven unemployed samurai to help them defend themselves. Influenced countless films worldwide.', 207, 'https://example.com/sevansamurai.jpg'),
('M11', 'The Silence of the Lambs', 1991, 'Jonathan Demme', 'USA', 8.6, 'Crime, Drama, Thriller', 'A young FBI cadet must receive the help of an incarcerated and manipulative cannibal killer to help catch another serial killer. Only three films to win the "Big Five" Oscars.', 118, 'https://example.com/silence.jpg'),
('M12', 'Interstellar', 2014, 'Christopher Nolan', 'USA', 8.6, 'Adventure, Drama, Sci-Fi', 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival. Scientific accuracy meets emotional storytelling.', 169, 'https://example.com/interstellar.jpg'),
('M13', 'The Room', 2003, 'Tommy Wiseau', 'USA', 3.7, 'Drama', 'A melodramatic story about betrayal and love triangles that has become a cult classic for its unconventional filmmaking.', 99, 'https://example.com/theroom.jpg'), -- Movie with no reviews
('M14', 'Citizen Kane', 1941, 'Orson Welles', 'USA', 8.3, 'Drama, Mystery', 'Following the death of a publishing tycoon, news reporters scramble to discover the meaning of his final utterance.', 119, 'https://example.com/citizenkane.jpg'); -- Movie with no reviews

-- Insert sample data for Collections (platform-curated)
INSERT INTO collection (collection_id, collection_name, description, total_movies, category, is_active) VALUES
('C1', 'Best Picture Winners', 'Academy Award winners for Best Picture throughout history', 2, 'awards', TRUE),
('C2', 'Sci-Fi Masterpieces', 'Groundbreaking science fiction films that defined the genre', 4, 'genre', TRUE),
('C3', 'Criterion Collection Essentials', 'Must-watch films from the prestigious Criterion Collection', 4, 'theme', TRUE),
('C4', 'Crime Drama Classics', 'The best films in the crime and drama genres', 3, 'genre', TRUE),
('C5', 'Christopher Nolan Filmography', 'Complete works of director Christopher Nolan', 3, 'director', TRUE),
('C6', 'Studio Ghibli Masterpieces', 'Essential animated films from Studio Ghibli', 1, 'studio', TRUE),
('C7', 'Inactive Collection', 'This collection is no longer maintained', 0, 'theme', FALSE); -- Collection with no movies

-- Insert sample data for Lists (user-curated, including private lists)
INSERT INTO list (list_id, user_id, title, description, is_public, created_date, movie_count, likes_count) VALUES
('L1', 'U1', '2023 Watchlist', 'Movies I plan to watch this year. A mix of classics I missed and new releases.', TRUE, '2023-01-01', 4, 12),
('L2', 'U2', 'Top 10 Thrillers', 'My personal ranking of the best thriller movies that kept me on the edge of my seat.', TRUE, '2023-02-15', 3, 28),
('L3', 'U3', 'Film School Essentials', 'Must-watch films for any cinema student. Covering major movements and techniques.', TRUE, '2023-03-10', 5, 45),
('L4', 'U4', 'Private Watchlist', 'My personal reminders of films recommended by friends. Not ready for public viewing yet.', FALSE, '2023-04-05', 2, 0),
('L5', 'U5', 'Nolan''s Narrative Structures', 'Analyzing Christopher Nolan''s unique approaches to storytelling and time manipulation.', TRUE, '2023-05-20', 3, 33),
('L6', 'U6', 'Underrated Gems', 'Fantastic films that didn''t get the mainstream attention they deserved.', TRUE, '2023-06-15', 3, 27),
('L7', 'U7', 'Horror Through the Decades', 'Essential horror films representing each decade from the 1920s to present.', TRUE, '2023-07-08', 4, 41),
('L8', 'U9', 'Empty List', 'I just created this list but haven''t added any movies yet.', TRUE, '2023-12-01', 0, 0); -- List with no movies

-- Insert sample data for Reviews
INSERT INTO review (review_id, user_id, movie_id, rating, content, review_date, likes_count) VALUES
('R1', 'U1', 'M1', 5.0, 'Absolute masterpiece that gets better with every viewing. Tim Robbins and Morgan Freeman deliver career-best performances. The final scene on the beach still gives me chills.', '2023-01-10', 15),
('R2', 'U2', 'M1', 4.5, 'Brilliant film, though a bit long in some parts. The character development is exceptional, but some scenes could have been tighter. Still, essential viewing.', '2023-01-12', 8),
('R3', 'U1', 'M3', 5.0, 'Heath Ledger''s performance alone makes this worth watching, but everything else is equally perfect. The practical effects, the moral complexity, the pacing - this is superhero cinema at its peak.', '2023-02-05', 22),
('R4', 'U3', 'M4', 4.0, 'Innovative storytelling and sharp social commentary. The way Bong Joon Ho blends genres is masterful. The class critique is both subtle and devastating.', '2023-02-20', 18),
('R5', 'U2', 'M6', 4.5, 'Mind-bending concept executed perfectly. The practical rotating hallway scene alone deserves an award. Nolan makes you question reality itself.', '2023-03-01', 14),
('R6', 'U4', 'M5', 5.0, 'Pure magic. Miyazaki creates a world so rich and detailed that you forget you''re watching animation. Chihiro''s journey resonates with anyone who''s ever felt lost.', '2023-03-15', 19),
('R7', 'U5', 'M8', 4.5, 'Revolutionary when released and still holds up. The philosophical questions about reality are more relevant than ever in our digital age.', '2023-04-02', 11),
('R8', 'U6', 'M10', 5.0, 'The blueprint for ensemble action films. Kurosawa''s direction is flawless, and the character development for seven distinct samurai is astonishing.', '2023-04-18', 7),
('R9', 'U7', 'M11', 4.5, 'Terrifying and brilliant. Anthony Hopkins has maybe 16 minutes of screen time but dominates the entire film. The final night-vision sequence is unforgettable.', '2023-05-05', 13),
('R10', 'U1', 'M2', 4.5, 'The epitome of epic filmmaking. Brando''s performance is legendary, and the wedding sequence is one of the greatest openings in cinema history.', '2023-06-10', 9); -- Additional review to show 1:M

-- Insert sample data for Diary entries
INSERT INTO diary (diary_id, user_id, movie_id, watch_date, location, rating, rewatch_count, notes) VALUES
('D1', 'U1', 'M1', '2023-01-08', 'Home', 5.0, 1, 'Third time watching, still amazing. Noticed new details in the warden''s office scene.'),
('D2', 'U1', 'M3', '2023-02-03', 'Cinema', 5.0, 0, 'IMAX re-release was incredible. The practical effects and sound design are even more impressive on the big screen.'),
('D3', 'U2', 'M1', '2023-01-11', 'Home', 4.5, 0, 'First time watching, lived up to the hype. The prison escape sequence had me holding my breath.'),
('D4', 'U3', 'M4', '2023-02-18', 'Film Club', 4.0, 0, 'Watched with discussion group. Great conversation about class dynamics and the Korean social structure.'),
('D5', 'U4', 'M5', '2023-03-05', 'Home', 4.5, 1, 'Beautiful animation and story. Showing it to my niece for her first Ghibli experience - she loved it!'),
('D6', 'U5', 'M6', '2023-03-12', 'Home Theater', 4.5, 2, 'Third viewing. Finally think I understand the ending. Or do I? That''s the beauty of this film.'),
('D7', 'U6', 'M10', '2023-04-10', 'Cinema', 5.0, 0, 'Restored version in theaters. The black and white cinematography is stunning on the big screen.'),
('D8', 'U7', 'M11', '2023-05-01', 'Home', 4.5, 1, 'Halloween month rewatch. Still terrifying. The basement scene remains one of cinema''s most suspenseful moments.'),
('D9', 'U1', 'M2', '2023-06-15', 'Home', 5.0, 0, 'First time watching the entire trilogy. The baptism scene intercutting is masterful editing.'); -- Additional diary entry

-- Insert sample data for Followers (demonstrating M:M relationships and 0:M - users with no followers)
INSERT INTO follower (follower_id, following_id, follow_date) VALUES
('U2', 'U1', '2023-01-20'),
('U3', 'U1', '2023-01-25'),
('U4', 'U1', '2023-02-10'),
('U5', 'U1', '2023-02-15'),
('U6', 'U1', '2023-03-05'),
('U1', 'U2', '2023-01-22'),
('U3', 'U2', '2023-02-01'),
('U5', 'U2', '2023-02-05'),
('U7', 'U2', '2023-02-20'),
('U1', 'U3', '2023-01-26'),
('U4', 'U3', '2023-02-08'),
('U2', 'U4', '2023-02-12'),
('U6', 'U5', '2023-03-10'),
('U7', 'U6', '2023-04-01'),
('U8', 'U7', '2023-05-15'),
('U9', 'U10', '2023-12-02'), -- U10 has followers but doesn't follow anyone
('U8', 'U10', '2023-12-02');

-- Insert sample data for Viewing Providers
INSERT INTO viewing_provider (provider_id, provider_name, type, website_url, supported_regions, contact_info) VALUES
('VP1', 'Netflix', 'streaming', 'https://netflix.com', 'Global', 'support@netflix.com'),
('VP2', 'AMC Theaters', 'theater', 'https://amctheaters.com', 'USA, Canada', 'contact@amctheaters.com'),
('VP3', 'Amazon Prime', 'streaming', 'https://primevideo.com', 'Global', 'support@amazon.com'),
('VP4', 'Criterion Channel', 'streaming', 'https://criterionchannel.com', 'USA, Canada, UK', 'help@criterion.com'),
('VP5', 'Alamo Drafthouse', 'theater', 'https://drafthouse.com', 'USA', 'info@drafthouse.com'),
('VP6', 'HBO Max', 'streaming', 'https://hbomax.com', 'Americas, Europe', 'support@hbomax.com'),
('VP7', 'Disney+', 'streaming', 'https://disneyplus.com', 'Global', 'support@disneyplus.com'); -- Provider with no viewing sessions

-- Insert sample data for Viewing Sessions (demonstrating 1:M - one movie multiple sessions, one provider multiple sessions)
INSERT INTO viewing_session (session_id, movie_id, provider_id, session_type, start_time, end_time, price, available_seats, quality_format) VALUES
('VS1', 'M1', 'VP1', 'streaming', NULL, NULL, 15.99, NULL, '4K'),
('VS2', 'M3', 'VP2', 'theater', '2023-12-20 19:00:00', '2023-12-20 21:35:00', 12.50, 45, 'IMAX'),
('VS3', 'M4', 'VP1', 'streaming', NULL, NULL, 15.99, NULL, 'HD'),
('VS4', 'M6', 'VP3', 'streaming', NULL, NULL, 8.99, NULL, '4K'),
('VS5', 'M10', 'VP4', 'streaming', NULL, NULL, 10.99, NULL, 'HD'),
('VS6', 'M2', 'VP6', 'streaming', NULL, NULL, 14.99, NULL, 'HD'),
('VS7', 'M5', 'VP1', 'streaming', NULL, NULL, 15.99, NULL, '4K'),
('VS8', 'M8', 'VP3', 'streaming', NULL, NULL, 3.99, NULL, 'HD'),
('VS9', 'M1', 'VP3', 'streaming', NULL, NULL, 4.99, NULL, 'HD'), -- Same movie, different provider
('VS10', 'M3', 'VP1', 'streaming', NULL, NULL, 15.99, NULL, '4K'); -- Same movie, different provider

-- Insert CORRECTED sample data for Movie_Collection (M:M relationships)
INSERT INTO movie_collection (movie_id, collection_id, added_date) VALUES
-- Best Picture Winners (C1)
('M1', 'C1', '2023-01-15'),
('M2', 'C1', '2023-01-15'),
-- Sci-Fi Masterpieces (C2)
('M3', 'C2', '2023-02-01'),
('M6', 'C2', '2023-02-01'),
('M8', 'C2', '2023-02-01'),
('M12', 'C2', '2023-02-01'),
-- Criterion Collection Essentials (C3)
('M2', 'C3', '2023-03-05'),
('M7', 'C3', '2023-03-05'),
('M9', 'C3', '2023-03-05'),
('M10', 'C3', '2023-03-05'),
-- Crime Drama Classics (C4)
('M2', 'C4', '2023-04-12'),
('M9', 'C4', '2023-04-12'),
('M11', 'C4', '2023-04-12'),
-- Christopher Nolan Films (C5)
('M3', 'C5', '2023-05-20'),
('M6', 'C5', '2023-05-20'),
('M12', 'C5', '2023-05-20'),
-- Studio Ghibli Masterpieces (C6)
('M5', 'C6', '2023-06-10');

-- Insert sample data for Movie_List (M:M relationships)
INSERT INTO movie_list (movie_id, list_id, added_date, order_position, notes) VALUES
('M2', 'L1', '2023-01-01', 1, 'Classic to finally watch'),
('M4', 'L1', '2023-01-01', 2, 'Heard great things about the social commentary'),
('M5', 'L1', '2023-01-01', 3, 'Ghibli marathon preparation'),
('M10', 'L1', '2023-01-01', 4, 'Essential world cinema'),
('M3', 'L2', '2023-02-15', 1, 'Best superhero movie ever made'),
('M6', 'L2', '2023-02-15', 2, 'Mind-bending thriller that redefined the genre'),
('M11', 'L2', '2023-02-15', 3, 'Psychological thriller at its finest'),
('M1', 'L3', '2023-03-10', 1, 'Essential American cinema'),
('M2', 'L3', '2023-03-10', 2, 'Mafia classic with incredible performances'),
('M4', 'L3', '2023-03-10', 3, 'Modern masterpiece that broke language barriers'),
('M5', 'L3', '2023-03-10', 4, 'Animation excellence that appeals to all ages'),
('M10', 'L3', '2023-03-10', 5, 'The film that inspired The Magnificent Seven'),
('M3', 'L5', '2023-05-20', 1, 'Non-linear storytelling with dual protagonists'),
('M6', 'L5', '2023-05-20', 2, 'Dream layers as narrative structure'),
('M12', 'L5', '2023-05-20', 3, 'Time dilation as emotional storytelling device'),
('M4', 'L6', '2023-06-15', 1, 'Should have gotten more international recognition earlier'),
('M10', 'L6', '2023-06-15', 2, 'Overshadowed by its American remake'),
('M5', 'L6', '2023-06-15', 3, 'Animation still not taken seriously by some critics'),
('M13', 'L7', '2023-07-08', 1, 'So bad it''s good cult classic'),
('M14', 'L7', '2023-07-08', 2, 'Often considered the greatest film ever made'),
('M1', 'L4', '2023-04-05', 1, 'Friend highly recommended'),
('M8', 'L4', '2023-04-05', 2, 'Want to understand the philosophy');