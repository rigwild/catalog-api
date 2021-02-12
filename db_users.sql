BEGIN;

-- --------------------
-- CLEANUP
-- --------------------

DROP TABLE IF EXISTS account CASCADE;
DROP TABLE IF EXISTS account_playlist CASCADE;

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

-- --------------------
-- TABLE JOINS
-- --------------------

CREATE TABLE account_playlist
(
  account_id BIGINT NOT NULL REFERENCES account(account_id),
  movie_id BIGINT NOT NULL REFERENCES movie(movie_id),
  PRIMARY KEY (account_id, movie_id)
);

-- --------------------
-- TABLE VIEWS
-- --------------------

CREATE OR REPLACE VIEW view_account_full AS
  SELECT 
    account.*,
    json_agg(movie_playlist.* ORDER BY movie_playlist.movie_id) AS playlist,
    json_agg(movie_suggestions.* ORDER BY movie_suggestions.movie_id) AS suggestions
  FROM account
  INNER JOIN account_playlist on account_playlist.account_id = account.account_id
  GROUP BY account.account_id
  ORDER BY account.account_id;

-- --------------------
-- TEST DATA
-- --------------------

INSERT INTO account (name, email, age) VALUES
  ('Antoine', 'mail1@example.com', 23),
  ('Adrien', 'mail2@example.com', 47),
  ('Louna', 'mail3@example.com', 19),
  ('Morgane', 'mail4@example.com', 19)
;

INSERT INTO account_playlist (account_id, movie_id) VALUES
  (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
  (1, 11), (1, 12), (1, 13), (1, 14), (1, 15), (1, 16), (1, 17), (1, 18), (1, 19), (1, 20),
  (1, 21), (1, 22), (1, 23), (1, 24), (1, 25), (1, 26), (1, 27), (1, 28), (1, 29), (1, 30),

  (2, 10), (2, 14), (2, 15), (2, 17), (2, 20), (2, 21), (2, 5), (3, 12), (3, 13), (3, 15), (3, 20), (3, 21),
  (3, 22), (3, 29), (4, 11), (4, 18), (4, 19), (4, 2), (4, 22), (4, 29), (4, 4), (4, 5), (4, 7), (4, 9)
;

COMMIT;
