# Catalog API

## Available microservices

 - [movies](./src/microservices/movies)
 - [stats](./src/microservices/stats)
 - [suggestions](./src/microservices/suggestions)
 - [users](./src/microservices/users)

## Run on system

### Install

#### Prerequisites

 - Node.js v12.0.0+
 - PostgreSQL v9.6.0+

Install Node.js dependencies

```sh
yarn # or npm i -D
```

Create PostgreSQL databases and import them:
 - See [db_movies.sql](./db_movies.sql)
 - See [db_suggestions.sql](./db_suggestions.sql)
 - See [db_users.sql](./db_users.sql)

```
psql

CREATE DATABASE db_movies;
\c db_movies
\i db_movies.sql

CREATE DATABASE db_suggestions;
\c db_suggestions
\i db_suggestions.sql

CREATE DATABASE db_users;
\c db_users
\i db_users.sql
```

### Start microservices

```sh
PGUSER=myuser PGPASSWORD=mysecurepassword yarn start:movies:ts
PGUSER=myuser PGPASSWORD=mysecurepassword yarn start:stats:ts
PGUSER=myuser PGPASSWORD=mysecurepassword yarn start:suggestions:ts
PGUSER=myuser PGPASSWORD=mysecurepassword yarn start:users:ts
```

## Run with Docker

### Build Docker images

This process shouldn't take too long as the Node.js dependencies installation image layer is cached by Docker.

```
docker build -t rigwild/app_movies -f app.movies.Dockerfile .
docker build -t rigwild/app_stats -f app.stats.Dockerfile .
docker build -t rigwild/app_suggestions -f app.suggestions.Dockerfile .
docker build -t rigwild/app_users -f app.users.Dockerfile .
```

### Start with docker-compose

You need to [Build the Docker images](#build-docker-images) first.

```
docker-compose up
```

## API routes

### `/users`

 - `GET /users`
 - `POST /users`
 - `GET /users/:id`
 - `GET /users/:id/playlist`
 - `GET /users/:id/suggestions`
 - `PUT /users/:id/playlist`
 - `PUT /users/:id/suggestions`
 - `GET /users/:id/playlist`

### `/movies`

 - `GET /movies`
 - `POST /movies`
 - `GET /movies/:id`
 - `PUT /movies/:id`

### `/genres`

 - `GET /genres`
 - `POST /genres`
 - `GET /genres/:id`
 - `PUT /genres/:id`

### `/people`

 - `GET /people`
 - `POST /people`
 - `GET /people/:id`
 - `PUT /people/:id`

## Postman Collection

See [Catalog_API.postman_collection.json](./Catalog_API.postman_collection.json)

## License

[The MIT License](./LICENSE)
