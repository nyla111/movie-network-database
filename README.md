# Movie Social Network Database

## Project Overview
A complete Letterboxd-inspired movie social network database system for Database Systems course. This database allows movie enthusiasts to track films, write reviews, create lists, follow other users, and discover where movies are available to watch.

## Database Design
**Inspired by:** [Letterboxd](https://letterboxd.com/)

**Core Features Modeled:**
- Personal film tracking with viewing diaries
- Social interactions (following, reviews)
- Content curation (lists, collections)
- Movie discovery across streaming services
- User profiles with activity statistics

## Repository Structure
```bash
movie-network-database/
├── README.md                
├── set-up/
│   ├── create_tables.sql     # Creates all database tables
│   ├── create_views.sql      # Creates analytical views
│   └── insert_data.sql       # Inserts comprehensive sample data
├── test-queries/
│   ├── sample_queries.sql    # Example queries from project documentation 
│   ├── check_integrity.sql   # Demonstrates CHECK constraints & CASCADE
│   └── views_queries.sql     # Tests and demonstrates views
└── ERD.png                   # Complete ER Diagram
└── Report_slide.pdf          # Full project report
```

## Installation Instructions

### Prerequisites
- **PostgreSQL 12+** (tested on PostgreSQL 15)
- **psql command-line tool** or **pgAdmin 4**

### Step-by-Step Setup

1. **Create a new PostgreSQL database:**
```bash
createdb movie_social
```
2. **Connect to this database:**
```bash
psql -d movie_social
```
3. **Run SQL files in EXACT SEQUENTIAL ORDER (due to dependencies):**
```bash
-- 1. First: Create all tables
\i sql/create_tables.sql

-- 2. Second: Insert sample data (depends on tables)
\i sql/insert_data.sql

-- 3. Third: Create views (depends on tables and data)
\i sql/create_views.sql

-- 4. Optional: Test constraint demonstrations
\i sql/check_integrity.sql

-- 5. Optional: Test views functionality
\i sql/views_queries.sql

-- 6. Optional: Run example queries
\i sql/sample_queries.sql
```

## Database Schema Overview

### Core Entities (11 Tables)

| Table | Description | Key Features |
|-------|-------------|--------------|
| **users** | User profiles | Social stats, join dates, bios |
| **movie** | Movie catalog | Ratings, genres, runtime, plots |
| **review** | User reviews | Star ratings, content, likes |
| **list** | User-curated lists | Public/private, movie counts |
| **diary** | Viewing diary | Watch dates, locations, rewatches |
| **follower** | Social follows | Mutual follows, follow dates |
| **collection** | Platform collections | Categories, active status |
| **viewing_provider** | Streaming services | Netflix, theaters, etc. |
| **viewing_session** | Availability | Prices, formats, time slots |
| **movie_list** (M:M) | Lists ↔ Movies | Order positions, notes |
| **movie_collection** (M:M) | Collections ↔ Movies | Added dates |

### Analytical Views (2 Views)

1. **user_activity_summary** - Comprehensive user engagement metrics
2. **movie_availability** - Movies available to watch under $10

### Key Relationships

- **One-to-Many**: User → Reviews, User → Lists, User → Diary entries
- **Many-to-Many**: User ↔ User (via Follower), Movie ↔ List, Movie ↔ Collection
- **Self-Referential**: User follows other Users

## Sample Data Statistics

The database includes realistic sample data demonstrating all features:

- **10 users** with varying activity levels
- **14 movies** across different genres and eras
- **10 reviews** with detailed content
- **8 lists** (including private lists)
- **7 collections** platform-curated
- **17 follow relationships** (including mutual follows)
- **9 diary entries** with viewing logs
- **7 viewing providers** (Netflix, theaters, etc.)
- **10 viewing sessions** with availability info

## SQL Files Description

### 1. `create_tables.sql`
- Creates all 11 tables with proper data types
- Implements PRIMARY KEY, FOREIGN KEY constraints
- Includes CHECK constraints for data validation
- Sets up CASCADE DELETE for referential integrity
- Creates necessary indexes

### 2. `insert_data.sql`
- Inserts comprehensive sample data
- Data follows realistic patterns and relationships
- Includes edge cases (users with no followers, movies with no reviews)
- Demonstrates all relationship types (1:M, M:M, self-referential)

### 3. `create_views.sql`
- Creates `user_activity_summary` view for user analytics
- Creates `movie_availability` view for discovery features
- Views automatically update when underlying data changes

### 4. `check_integrity.sql`
- **Demonstrates CHECK constraint violations** (expected to fail)
- Shows FOREIGN KEY constraint enforcement
- Tests CASCADE DELETE functionality
- Validates UNIQUE constraints
- **Educational purpose**: Shows what happens when constraints are violated

### 5. `views_queries.sql`
- Tests view functionality
- Compares complex queries vs. simple view usage
- Demonstrates view auto-update feature
- Shows practical applications of views

### 6. `sample_queries.sql`
- **Complete implementation of project query requirements**
- Query 1: Simple single table query (2023 users)
- Query 2: Natural join query (public lists)
- Query 3: Cross product equivalent
- Query 4: GROUP BY with HAVING (genres with avg rating > 6)
- Query 5: Subquery (users who reviewed long movies)
- Query 6: Self join (mutual follows)
- Additional demonstration queries

## Key Technical Features

### Data Integrity
- **CHECK constraints** on ratings (0.5-5.0 in 0.5 increments)
- **Date validation** (release years 1888-current+5)
- **Non-negative counts** (followers, likes, etc.)
- **No self-follows** constraint
- **Valid time ranges** for viewing sessions

### Referential Integrity
- **CASCADE DELETE** on all foreign keys
- Users deleted → their reviews, lists, follows automatically removed
- **Prevents orphaned records**
- **Maintains database consistency**

### Performance Considerations
- Appropriate data types (VARCHAR lengths optimized)
- Foreign keys indexed automatically
- Views optimize complex query patterns
- Sample data volume appropriate for testing
