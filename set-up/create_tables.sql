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

DROP TABLE IF EXISTS viewing_session CASCADE;
DROP TABLE IF EXISTS movie_collection CASCADE;
DROP TABLE IF EXISTS movie_list CASCADE;
DROP TABLE IF EXISTS diary CASCADE;
DROP TABLE IF EXISTS review CASCADE;
DROP TABLE IF EXISTS follower CASCADE;
DROP TABLE IF EXISTS list CASCADE;
DROP TABLE IF EXISTS collection CASCADE;
DROP TABLE IF EXISTS viewing_provider CASCADE;
DROP TABLE IF EXISTS movie CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Create Users table
CREATE TABLE users (
    user_id VARCHAR(20) PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    bio TEXT,
    avatar_URL VARCHAR(255),
    join_date DATE NOT NULL DEFAULT CURRENT_DATE,
    follower_count INTEGER DEFAULT 0 CHECK (follower_count >= 0),
    following_count INTEGER DEFAULT 0 CHECK (following_count >= 0)
);

-- Create Movie table
CREATE TABLE movie (
    movie_id VARCHAR(20) PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    release_year INTEGER NOT NULL CHECK (release_year >= 1888 AND release_year <= EXTRACT(YEAR FROM CURRENT_DATE) + 5),
    director VARCHAR(100),
    country VARCHAR(50),
    rating DECIMAL(3,1) CHECK (rating >= 0 AND rating <= 10),
    genre VARCHAR(100),
    plot_summary TEXT,
    runtime INTEGER CHECK (runtime > 0 AND runtime <= 600),
    poster_url VARCHAR(255)
);

-- Create Collection table (platform-curated)
CREATE TABLE collection (
    collection_id VARCHAR(20) PRIMARY KEY,
    collection_name VARCHAR(100) NOT NULL,
    description TEXT,
    total_movies INTEGER DEFAULT 0 CHECK (total_movies >= 0),
    category VARCHAR(50) CHECK (category IN ('awards', 'franchise', 'genre', 'director', 'era', 'theme', 'studio')),
    is_active BOOLEAN DEFAULT TRUE
);

-- Create List table (user-curated)
CREATE TABLE list (
    list_id VARCHAR(20) PRIMARY KEY,
    user_id VARCHAR(20) NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    is_public BOOLEAN DEFAULT TRUE,
    created_date DATE NOT NULL DEFAULT CURRENT_DATE,
    movie_count INTEGER DEFAULT 0 CHECK (movie_count >= 0),
    likes_count INTEGER DEFAULT 0 CHECK (likes_count >= 0),
    CONSTRAINT fk_list_owner
        FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
);

-- Create Review table
CREATE TABLE review (
    review_id VARCHAR(20) PRIMARY KEY,
    user_id VARCHAR(20) NOT NULL,
    movie_id VARCHAR(20) NOT NULL,
    rating DECIMAL(2,1) NOT NULL CHECK (rating >= 0.5 AND rating <= 5.0 AND rating % 0.5 = 0),
    content TEXT,
    review_date DATE NOT NULL DEFAULT CURRENT_DATE,
    likes_count INTEGER DEFAULT 0 CHECK (likes_count >= 0),
    CONSTRAINT fk_review_author
        FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_review_movie
        FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
        ON DELETE CASCADE,
    CONSTRAINT unique_user_movie_review UNIQUE (user_id, movie_id)
);

-- Create Diary table
CREATE TABLE diary (
    diary_id VARCHAR(20) PRIMARY KEY,
    user_id VARCHAR(20) NOT NULL,
    movie_id VARCHAR(20) NOT NULL,
    watch_date DATE NOT NULL,
    location VARCHAR(100),
    rating DECIMAL(2,1) CHECK (rating >= 0.5 AND rating <= 5.0 AND rating % 0.5 = 0),
    rewatch_count INTEGER DEFAULT 0 CHECK (rewatch_count >= 0),
    notes TEXT,
    CONSTRAINT fk_diary_user
        FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_diary_movie
        FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
        ON DELETE CASCADE
);

-- Create Follower table
CREATE TABLE follower (
    follower_id VARCHAR(20) NOT NULL,
    following_id VARCHAR(20) NOT NULL,
    follow_date DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (follower_id, following_id),
    CONSTRAINT fk_follower_user
        FOREIGN KEY (follower_id) REFERENCES users(user_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_following_user
        FOREIGN KEY (following_id) REFERENCES users(user_id)
        ON DELETE CASCADE,
    CONSTRAINT no_self_follow CHECK (follower_id != following_id)
);

-- Create Viewing_Provider table
CREATE TABLE viewing_provider (
    provider_id VARCHAR(20) PRIMARY KEY,
    provider_name VARCHAR(100) NOT NULL,
    type VARCHAR(50) CHECK (type IN ('streaming', 'rental', 'theater', 'purchase')),
    website_url VARCHAR(255),
    supported_regions TEXT,
    contact_info VARCHAR(255)
);

-- Create Viewing_Session table
CREATE TABLE viewing_session (
    session_id VARCHAR(20) PRIMARY KEY,
    movie_id VARCHAR(20) NOT NULL,
    provider_id VARCHAR(20) NOT NULL,
    session_type VARCHAR(50) CHECK (session_type IN ('streaming', 'rental', 'theater', 'purchase')),
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    price DECIMAL(8,2) CHECK (price >= 0),
    available_seats INTEGER CHECK (available_seats >= 0),
    quality_format VARCHAR(50),
    CONSTRAINT fk_session_movie
        FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_session_provider
        FOREIGN KEY (provider_id) REFERENCES viewing_provider(provider_id)
        ON DELETE CASCADE,
    CONSTRAINT valid_time_range CHECK (end_time IS NULL OR start_time IS NULL OR end_time > start_time)
);

-- Create Movie_Collection table (M:M relationship between Movie and Collection)
CREATE TABLE movie_collection (
    movie_id VARCHAR(20) NOT NULL,
    collection_id VARCHAR(20) NOT NULL,
    added_date DATE NOT NULL DEFAULT CURRENT_DATE,
    PRIMARY KEY (movie_id, collection_id),
    CONSTRAINT fk_mc_movie
        FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_mc_collection
        FOREIGN KEY (collection_id) REFERENCES collection(collection_id)
        ON DELETE CASCADE
);

-- Create Movie_List table (M:M relationship between Movie and List)
CREATE TABLE movie_list (
    movie_id VARCHAR(20) NOT NULL,
    list_id VARCHAR(20) NOT NULL,
    added_date DATE NOT NULL DEFAULT CURRENT_DATE,
    order_position INTEGER CHECK (order_position >= 0),
    notes TEXT,
    PRIMARY KEY (movie_id, list_id),
    CONSTRAINT fk_ml_movie
        FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_ml_list
        FOREIGN KEY (list_id) REFERENCES list(list_id)
        ON DELETE CASCADE
);
