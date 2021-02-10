BEGIN;

-- --------------------
-- MAIN TABLES
-- --------------------

CREATE TABLE user
(
  user_id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(128) NOT NULL,
  email VARCHAR(128)NOT NULL,
  age INTEGER NOT NULL,
  created_at timestamp DEFAULT NOW()
);

CREATE TABLE movie
(
  movie_id SERIAL NOT NULL PRIMARY KEY,
  title VARCHAR(256) NOT NULL,
  director BIGINT NOT NULL REFERENCES people(people_id),
  age_rating INTEGER,
  duration_minutes INTEGER NOT NULL REFERENCES people(people_id),
  popularity FLOAT NOT NULL
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

-- --------------------
-- TABLE JOINS
-- --------------------

CREATE TABLE movie_cast
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

CREATE TABLE user_playlist
(
  user_id BIGINT NOT NULL REFERENCES user(user_id),
  movie_id BIGINT NOT NULL REFERENCES movie(movie_id),
  PRIMARY KEY (user_id, movie_id)
);

CREATE TABLE user_suggestions
(
  user_id BIGINT NOT NULL REFERENCES user(user_id),
  movie_id BIGINT NOT NULL REFERENCES movie(movie_id),
  PRIMARY KEY (user_id, movie_id)
);

-- --------------------
-- TEST DATA
-- --------------------

INSERT INTO user (name, email, age) VALUES ('Antoine', 'mail1@example.com', 23);
INSERT INTO user (name, email, age) VALUES ('Adrien', 'mail2@example.com', 47);
INSERT INTO user (name, email, age) VALUES ('Louna', 'mail3@example.com', 19);
INSERT INTO user (name, email, age) VALUES ('Morgane', 'mail4@example.com', 19);

INSERT INTO people (name, roles) VALUES ('Christian Bale', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Humphrey Bogart', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Marlon Brando', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Michael Caine', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Charles Chaplin', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Tom Cruise', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Daniel Day-Lewis', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Robert De Niro', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Leonardo DiCaprio', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Clint Eastwood', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Clark Gable', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Cary Grant', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Tom Hanks', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Charlton Heston', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Dustin Hoffman', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Philip Seymour Hoffman', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Anthony Hopkins', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Paul Newman', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Jack Nicholson', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Peter OToole', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Gary Oldman', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Laurence Olivier', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Al Pacino', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Gregory Peck', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Sean Penn', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Joaquin Phoenix', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Sidney Poitier', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Kevin Spacey', 'actor,director');
INSERT INTO people (name, roles) VALUES ('James Stewart', 'actor,director');
INSERT INTO people (name, roles) VALUES ('Denzel Washington', 'actor,director');

INSERT INTO genre (name) VALUES ('Action');
INSERT INTO genre (name) VALUES ('Fantasy');
INSERT INTO genre (name) VALUES ('Biopic');
INSERT INTO genre (name) VALUES ('Musical');
INSERT INTO genre (name) VALUES ('Dance');
INSERT INTO genre (name) VALUES ('Comedy');
INSERT INTO genre (name) VALUES ('Romance');
INSERT INTO genre (name) VALUES ('Crime');
INSERT INTO genre (name) VALUES ('Gangster');
INSERT INTO genre (name) VALUES ('Science-Fiction');
INSERT INTO genre (name) VALUES ('Superheroes');

INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Bad Boys for Life	Sony', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Sonic the Hedgehog	Paramount', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Tenet	Warner Bros.', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Dolittle	Universal', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Birds of Prey	Warner Bros.', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('The Invisible Man	Universal', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('The Gentlemen	Miramax', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('The Call of the Wild	20th Century Studios', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Onward	Disney', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Mulan	Disney', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Tanhaji	AA Films', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Tolo Tolo	Medusa Film', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('The Grudge	Sony', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Fantasy Island	Sony', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Underwater	Fox', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('The New Mutants	20th Century Studios', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Unhinged	Solstice Studios', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Like a Boss	Paramount', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Bloodshot	Sony', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Emma	Focus Features', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Trolls World Tour	Universal', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Gretel & Hansel	United Artists Releasing', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Scoob!	Warner Bros.', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Brahms: The Boy II	STX Entertainment', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('The Turning	Universal', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('The Way Back	Warner Bros.', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('La Belle Epoque	', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('I Still Believe	', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('The Hunt	', 1, 16, 92.5, 4.8);
INSERT INTO movie (title, director, age_rating, duration_minutes, popularity) VALUES ('Las Pildoras De Mi Novio	', 1, 16, 92.5, 4.8);

INSERT INTO movie_cast (movie_id, people_id) VALUES (1, 2);
INSERT INTO movie_cast (movie_id, people_id) VALUES (10, 11);
INSERT INTO movie_cast (movie_id, people_id) VALUES (11, 27);
INSERT INTO movie_cast (movie_id, people_id) VALUES (12, 8);
INSERT INTO movie_cast (movie_id, people_id) VALUES (12, 9);
INSERT INTO movie_cast (movie_id, people_id) VALUES (13, 27);
INSERT INTO movie_cast (movie_id, people_id) VALUES (14, 15);
INSERT INTO movie_cast (movie_id, people_id) VALUES (14, 29);
INSERT INTO movie_cast (movie_id, people_id) VALUES (15, 13);
INSERT INTO movie_cast (movie_id, people_id) VALUES (15, 8);
INSERT INTO movie_cast (movie_id, people_id) VALUES (18, 2);
INSERT INTO movie_cast (movie_id, people_id) VALUES (18, 24);
INSERT INTO movie_cast (movie_id, people_id) VALUES (18, 29);
INSERT INTO movie_cast (movie_id, people_id) VALUES (2, 3);
INSERT INTO movie_cast (movie_id, people_id) VALUES (21, 24);
INSERT INTO movie_cast (movie_id, people_id) VALUES (22, 1);
INSERT INTO movie_cast (movie_id, people_id) VALUES (22, 22);
INSERT INTO movie_cast (movie_id, people_id) VALUES (22, 5);
INSERT INTO movie_cast (movie_id, people_id) VALUES (23, 15);
INSERT INTO movie_cast (movie_id, people_id) VALUES (24, 14);
INSERT INTO movie_cast (movie_id, people_id) VALUES (24, 16);
INSERT INTO movie_cast (movie_id, people_id) VALUES (25, 10);
INSERT INTO movie_cast (movie_id, people_id) VALUES (28, 3);
INSERT INTO movie_cast (movie_id, people_id) VALUES (29, 26);
INSERT INTO movie_cast (movie_id, people_id) VALUES (5, 10);
INSERT INTO movie_cast (movie_id, people_id) VALUES (5, 2);
INSERT INTO movie_cast (movie_id, people_id) VALUES (6, 30);
INSERT INTO movie_cast (movie_id, people_id) VALUES (6, 6);
INSERT INTO movie_cast (movie_id, people_id) VALUES (7, 21);
INSERT INTO movie_cast (movie_id, people_id) VALUES (7, 5);
INSERT INTO movie_cast (movie_id, people_id) VALUES (8, 30);
INSERT INTO movie_cast (movie_id, people_id) VALUES (8, 4);
INSERT INTO movie_cast (movie_id, people_id) VALUES (9, 14);
INSERT INTO movie_cast (movie_id, people_id) VALUES (9, 6);

INSERT INTO movie_genres (movie_id, genre_id) VALUES (1, 1);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (1, 4);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (1, 6);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (11, 11);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (12, 4);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (14, 3);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (15, 3);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (16, 9);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (17, 6);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (19, 6);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (2, 10);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (2, 6);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (20, 8);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (21, 1);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (21, 5);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (23, 8);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (25, 1);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (25, 6);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (27, 1);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (27, 10);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (28, 4);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (29, 10);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (29, 11);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (3, 10);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (4, 4);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (5, 1);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (5, 1);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (5, 5);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (6, 2);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (6, 7);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (7, 10);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (7, 7);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (8, 1);
INSERT INTO movie_genres (movie_id, genre_id) VALUES (9, 4);

INSERT INTO user_playlist (user_id, movie_id) VALUES (1, 10);
INSERT INTO user_playlist (user_id, movie_id) VALUES (1, 12);
INSERT INTO user_playlist (user_id, movie_id) VALUES (1, 13);
INSERT INTO user_playlist (user_id, movie_id) VALUES (1, 13);
INSERT INTO user_playlist (user_id, movie_id) VALUES (1, 13);
INSERT INTO user_playlist (user_id, movie_id) VALUES (1, 26);
INSERT INTO user_playlist (user_id, movie_id) VALUES (1, 26);
INSERT INTO user_playlist (user_id, movie_id) VALUES (1, 28);
INSERT INTO user_playlist (user_id, movie_id) VALUES (1, 28);
INSERT INTO user_playlist (user_id, movie_id) VALUES (1, 7);
INSERT INTO user_playlist (user_id, movie_id) VALUES (1, 7);
INSERT INTO user_playlist (user_id, movie_id) VALUES (1, 7);
INSERT INTO user_playlist (user_id, movie_id) VALUES (2, 10);
INSERT INTO user_playlist (user_id, movie_id) VALUES (2, 14);
INSERT INTO user_playlist (user_id, movie_id) VALUES (2, 15);
INSERT INTO user_playlist (user_id, movie_id) VALUES (2, 17);
INSERT INTO user_playlist (user_id, movie_id) VALUES (2, 20);
INSERT INTO user_playlist (user_id, movie_id) VALUES (2, 21);
INSERT INTO user_playlist (user_id, movie_id) VALUES (2, 5);
INSERT INTO user_playlist (user_id, movie_id) VALUES (3, 12);
INSERT INTO user_playlist (user_id, movie_id) VALUES (3, 13);
INSERT INTO user_playlist (user_id, movie_id) VALUES (3, 15);
INSERT INTO user_playlist (user_id, movie_id) VALUES (3, 20);
INSERT INTO user_playlist (user_id, movie_id) VALUES (3, 21);
INSERT INTO user_playlist (user_id, movie_id) VALUES (3, 22);
INSERT INTO user_playlist (user_id, movie_id) VALUES (3, 29);
INSERT INTO user_playlist (user_id, movie_id) VALUES (4, 11);
INSERT INTO user_playlist (user_id, movie_id) VALUES (4, 18);
INSERT INTO user_playlist (user_id, movie_id) VALUES (4, 18);
INSERT INTO user_playlist (user_id, movie_id) VALUES (4, 2);
INSERT INTO user_playlist (user_id, movie_id) VALUES (4, 22);
INSERT INTO user_playlist (user_id, movie_id) VALUES (4, 29);
INSERT INTO user_playlist (user_id, movie_id) VALUES (4, 4);
INSERT INTO user_playlist (user_id, movie_id) VALUES (4, 5);
INSERT INTO user_playlist (user_id, movie_id) VALUES (4, 7);
INSERT INTO user_playlist (user_id, movie_id) VALUES (4, 9);

INSERT INTO user_suggestions (user_id, movie_id) VALUES (1, 10);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (1, 17);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (1, 22);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (1, 28);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (1, 3);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (1, 4);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (1, 5);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (2, 1);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (2, 1);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (2, 14);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (2, 16);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (2, 22);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (2, 26);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (2, 30);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (2, 6);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (2, 9);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (2, 9);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (3, 1);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (3, 1);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (3, 15);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (3, 16);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (3, 25);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (3, 26);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (3, 26);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (3, 29);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (3, 29);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (3, 30);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (4, 1);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (4, 11);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (4, 13);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (4, 16);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (4, 22);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (4, 23);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (4, 24);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (4, 28);
INSERT INTO user_suggestions (user_id, movie_id) VALUES (4, 3);

COMMIT;
