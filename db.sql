BEGIN;

-- --------------------
-- CLEANUP
-- --------------------

DROP TABLE IF EXISTS account CASCADE;
DROP TABLE IF EXISTS people CASCADE;
DROP TABLE IF EXISTS genre CASCADE;
DROP TABLE IF EXISTS movie CASCADE;
DROP TABLE IF EXISTS movie_casting CASCADE;
DROP TABLE IF EXISTS movie_genres CASCADE;
DROP TABLE IF EXISTS account_playlist CASCADE;
DROP TABLE IF EXISTS account_suggestions CASCADE;

-- --------------------
-- MAIN TABLES
-- --------------------

CREATE TABLE account
(
  account_id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(128) NOT NULL,
  email VARCHAR(128)NOT NULL,
  age INTEGER NOT NULL,
  created_at timestamp DEFAULT NOW()
);

CREATE TABLE people
(
  people_id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(128) NOT NULL,
  roles VARCHAR(128) NOT NULL
);

CREATE TABLE genre
(
  genre_id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(128) NOT NULL
);

CREATE TABLE movie
(
  movie_id SERIAL NOT NULL PRIMARY KEY,
  title VARCHAR(256) NOT NULL,
  director BIGINT NOT NULL REFERENCES people(people_id),
  age_rating INTEGER,
  duration_minutes INTEGER NOT NULL,
  popularity FLOAT NOT NULL
);

-- --------------------
-- TABLE JOINS
-- --------------------

CREATE TABLE movie_casting
(
  movie_id BIGINT NOT NULL REFERENCES movie(movie_id),
  people_id BIGINT NOT NULL REFERENCES people(people_id),
  PRIMARY KEY (movie_id, people_id)
);

CREATE TABLE movie_genres
(
  movie_id BIGINT NOT NULL REFERENCES movie(movie_id),
  genre_id BIGINT NOT NULL REFERENCES genre(genre_id),
  PRIMARY KEY (movie_id, genre_id)
);

CREATE TABLE account_playlist
(
  account_id BIGINT NOT NULL REFERENCES account(account_id),
  movie_id BIGINT NOT NULL REFERENCES movie(movie_id),
  PRIMARY KEY (account_id, movie_id)
);

CREATE TABLE account_suggestions
(
  account_id BIGINT NOT NULL REFERENCES account(account_id),
  movie_id BIGINT NOT NULL REFERENCES movie(movie_id),
  PRIMARY KEY (account_id, movie_id)
);

-- --------------------
-- TABLE VIEWS
-- --------------------

CREATE OR REPLACE VIEW view_movie_full AS
  SELECT
    movie.movie_id,
    movie.title,
    movie.age_rating,
    movie.duration_minutes,
    movie.popularity,
    to_json(people_director.*) AS director,
    json_agg(DISTINCT people_casting.*) AS casting,
    json_agg(DISTINCT genre.*) AS genres
  FROM movie
  INNER JOIN movie_casting ON movie_casting.movie_id = movie.movie_id
  INNER JOIN people AS people_director ON people_director.people_id = movie.director
  INNER JOIN people AS people_casting ON people_casting.people_id = movie_casting.people_id
  INNER JOIN movie_genres ON movie_genres.movie_id = movie.movie_id
  INNER JOIN genre ON genre.genre_id = movie_genres.genre_id
  GROUP BY movie.movie_id, people_director.people_id
  ORDER BY movie_id;

CREATE OR REPLACE VIEW view_account_full AS
  SELECT 
    account.*,
    json_agg(movie_playlist.* ORDER BY movie_playlist.movie_id) AS playlist,
    json_agg(movie_suggestions.* ORDER BY movie_suggestions.movie_id) AS suggestions
  FROM account
  INNER JOIN account_playlist on account_playlist.account_id = account.account_id
  INNER JOIN movie AS movie_playlist on movie_playlist.movie_id = account_playlist.movie_id
  INNER JOIN movie AS movie_suggestions on movie_suggestions.movie_id = account_playlist.movie_id
  GROUP BY account.account_id
  ORDER BY account.account_id;

CREATE OR REPLACE VIEW view_account_playlist_full AS
  SELECT view_movie_full.*, account_id FROM account_playlist
  INNER JOIN view_movie_full on view_movie_full.movie_id = account_playlist.movie_id
  ORDER BY view_movie_full.movie_id;

CREATE OR REPLACE VIEW view_account_suggestions_full AS
  SELECT view_movie_full.*, account_id FROM account_suggestions
  INNER JOIN view_movie_full on view_movie_full.movie_id = account_suggestions.movie_id
  ORDER BY view_movie_full.movie_id;

-- --------------------
-- TEST DATA
-- --------------------

INSERT INTO account (name, email, age) VALUES
  ('Antoine', 'mail1@example.com', 23),
  ('Adrien', 'mail2@example.com', 47),
  ('Louna', 'mail3@example.com', 19),
  ('Morgane', 'mail4@example.com', 19)
;

INSERT INTO people (name, roles) VALUES
  ('Christian Bale', 'director'), ('Humphrey Bogart', 'director'), ('Marlon Brando', 'director'), ('Michael Caine', 'director'),
  ('Charles Chaplin', 'director'), ('Tom Cruise', 'director'), ('Daniel Day-Lewis', 'director'), ('Robert De Niro', 'director'),
  ('Leonardo DiCaprio', 'director'), ('Clint Eastwood', 'director'), ('Clark Gable', 'actor'), ('Cary Grant', 'actor'), ('Tom Hanks', 'actor'),
  ('Charlton Heston', 'actor'), ('Dustin Hoffman', 'actor'), ('Philip Seymour Hoffman', 'actor'), ('Anthony Hopkins', 'actor'), ('Paul Newman', 'actor'),
  ('Jack Nicholson', 'actor'), ('Peter OToole', 'actor'), ('Gary Oldman', 'actor,director'), ('Laurence Olivier', 'actor,director'),
  ('Al Pacino', 'actor,director'), ('Gregory Peck', 'actor,director'), ('Sean Penn', 'actor,director'), ('Joaquin Phoenix', 'actor,director'),
  ('Sidney Poitier', 'actor,director'), ('Kevin Spacey', 'actor,director'), ('James Stewart', 'actor,director'), ('Denzel Washington', 'actor,director')
;

INSERT INTO genre (name) VALUES
  ('Action'), ('Fantasy'), ('Biopic'), ('Musical'), ('Dance'), ('Comedy'), ('Romance'), ('Crime'), ('Gangster'), ('Science-Fiction'), ('Superheroes')
;

INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES
  ('Bad Boys for Life Sony', 1, 16, 92.5, 4.8),
  ('Sonic the Hedgehog Paramount', 1, 16, 92.5, 4.8),
  ('Tenet Warner Bros.', 1, 16, 92.5, 4.8),
  ('Dolittle Universal', 1, 16, 92.5, 4.8),
  ('Birds of Prey Warner Bros.', 1, 16, 92.5, 4.8),
  ('The Invisible Man Universal', 1, 16, 92.5, 4.8),
  ('The Gentlemen Miramax', 1, 16, 92.5, 4.8),
  ('The Call of the Wild 20th Century Studios', 1, 16, 92.5, 4.8),
  ('Onward Disney', 1, 16, 92.5, 4.8),
  ('Mulan Disney', 1, 16, 92.5, 4.8),
  ('Tanhaji AA Films', 1, 16, 92.5, 4.8),
  ('Tolo Tolo Medusa Film', 1, 16, 92.5, 4.8),
  ('The Grudge Sony', 1, 16, 92.5, 4.8),
  ('Fantasy Island Sony', 1, 16, 92.5, 4.8),
  ('Underwater Fox', 1, 16, 92.5, 4.8),
  ('The New Mutants 20th Century Studios', 1, 16, 92.5, 4.8),
  ('Unhinged Solstice Studios', 1, 16, 92.5, 4.8),
  ('Like a Boss Paramount', 1, 16, 92.5, 4.8),
  ('Bloodshot Sony', 1, 16, 92.5, 4.8),
  ('Emma Focus Features', 1, 16, 92.5, 4.8),
  ('Trolls World Tour Universal', 1, 16, 92.5, 4.8),
  ('Gretel & Hansel United Artists Releasing', 1, 16, 92.5, 4.8),
  ('Scoob! Warner Bros.', 1, 16, 92.5, 4.8),
  ('Brahms: The Boy II STX Entertainment', 1, 16, 92.5, 4.8),
  ('The Turning Universal', 1, 16, 92.5, 4.8),
  ('The Way Back Warner Bros.', 1, 16, 92.5, 4.8),
  ('La Belle Epoque ', 1, 16, 92.5, 4.8),
  ('I Still Believe ', 1, 16, 92.5, 4.8),
  ('The Hunt ', 1, 16, 92.5, 4.8),
  ('Las Pildoras De Mi Novio ', 1, 16, 92.5, 4.8)
;

INSERT INTO movie_casting (movie_id, people_id) VALUES
  (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1), (10, 1), (11, 1), (12, 1), (13, 1), (14, 1), (15, 1),
  (16, 1), (17, 1), (18, 1), (19, 1), (20, 1), (21, 1), (22, 1), (23, 1), (24, 1), (25, 1), (26, 1), (27, 1), (28, 1), (29, 1), (30, 1),

  (1, 2), (10, 11), (11, 27), (12, 8), (12, 9), (13, 27), (14, 15), (14, 29), (15, 13), (15, 8), (18, 2), (18, 24), (18, 29),
  (2, 3), (21, 24), (22, 2), (22, 22), (22, 5), (23, 15), (24, 14), (24, 16), (25, 10), (28, 3), (29, 26), (5, 10), (5, 2),
  (6, 30), (6, 6), (7, 21), (7, 5), (8, 30), (8, 4), (9, 14), (9, 6)
;

INSERT INTO movie_genres (movie_id, genre_id) VALUES
  (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1), (10, 1), (11, 1), (12, 1), (13, 1), (14, 1), (15, 1),
  (16, 1), (17, 1), (18, 1), (19, 1), (20, 1), (21, 1), (22, 1), (23, 1), (24, 1), (25, 1), (26, 1), (27, 1), (28, 1), (29, 1), (30, 1),

  (1, 2), (2, 9), (3, 4), (4, 10), (5, 8), (6, 5), (7, 4), (8, 10), (9, 9), (10, 10), (11, 2), (12, 10), (13, 2), (14, 9), (15, 8),
  (16, 9), (17, 4), (18, 6), (19, 6), (20, 4), (21, 2), (22, 6), (23, 4), (24, 9), (25, 6), (26, 10), (27, 4), (28, 4), (29, 2), (30, 11),
  (1, 6), (2, 4), (3, 2), (4, 8), (5, 6), (6, 2), (7, 5), (8, 2), (9, 3), (10, 11), (11, 10), (12, 9), (13, 4), (14, 4), (15, 2),
  (16, 8), (17, 2), (18, 7), (19, 5), (20, 2), (21, 10), (22, 9), (23, 3), (24, 10), (25, 2), (26, 2), (27, 3), (28, 2), (29, 9), (30, 7)
;

INSERT INTO account_playlist (account_id, movie_id) VALUES
  (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
  (1, 11), (1, 12), (1, 13), (1, 14), (1, 15), (1, 16), (1, 17), (1, 18), (1, 19), (1, 20),
  (1, 21), (1, 22), (1, 23), (1, 24), (1, 25), (1, 26), (1, 27), (1, 28), (1, 29), (1, 30),

  (2, 10), (2, 14), (2, 15), (2, 17), (2, 20), (2, 21), (2, 5), (3, 12), (3, 13), (3, 15), (3, 20), (3, 21),
  (3, 22), (3, 29), (4, 11), (4, 18), (4, 19), (4, 2), (4, 22), (4, 29), (4, 4), (4, 5), (4, 7), (4, 9)
;

INSERT INTO account_suggestions (account_id, movie_id) VALUES
  (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
  (1, 11), (1, 12), (1, 13), (1, 14), (1, 15), (1, 16), (1, 17), (1, 18), (1, 19), (1, 20),
  (1, 21), (1, 22), (1, 23), (1, 24), (1, 25), (1, 26), (1, 27), (1, 28), (1, 29), (1, 30),

  (2, 10), (2, 14), (2, 15), (2, 17), (2, 20), (2, 21), (2, 5), (3, 12), (3, 13), (3, 15), (3, 20), (3, 21),
  (3, 22), (3, 29), (4, 11), (4, 18), (4, 19), (4, 2), (4, 22), (4, 29), (4, 4), (4, 5), (4, 7), (4, 9)
;

COMMIT;
