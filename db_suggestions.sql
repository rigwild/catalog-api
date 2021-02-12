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
DROP TYPE IF EXISTS people_job CASCADE;

-- --------------------
-- MAIN TABLES
-- --------------------

-- --------------------
-- TABLE JOINS
-- --------------------

CREATE TABLE account_suggestions
(
  account_id BIGINT NOT NULL,
  movie_id BIGINT NOT NULL,
  PRIMARY KEY (account_id, movie_id)
);

-- --------------------
-- TABLE VIEWS
-- --------------------

-- --------------------
-- TEST DATA
-- --------------------

INSERT INTO account_suggestions (account_id, movie_id) VALUES
  (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10),
  (1, 11), (1, 12), (1, 13), (1, 14), (1, 15), (1, 16), (1, 17), (1, 18), (1, 19), (1, 20),
  (1, 21), (1, 22), (1, 23), (1, 24), (1, 25), (1, 26), (1, 27), (1, 28), (1, 29), (1, 30),

  (2, 10), (2, 14), (2, 15), (2, 17), (2, 20), (2, 21), (2, 5), (3, 12), (3, 13), (3, 15), (3, 20), (3, 21),
  (3, 22), (3, 29), (4, 11), (4, 18), (4, 19), (4, 2), (4, 22), (4, 29), (4, 4), (4, 5), (4, 7), (4, 9)
;

COMMIT;
