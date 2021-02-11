# Catalog API

## Install

### Prerequisites

 - Node.js v12.0.0+
 - PostgreSQL v9.6.0+

Install Node.js dependencies

```sh
yarn # or npm i -D
```

Create a PostgreSQL database and import the database (see [db.sql](./db.sql))

```
psql
CREATE DATABASE catalog_api;
\c catalog_api
\i db.sql
```

## Run

```sh
PGUSER=myuser PGPASSWORD=mysecurepassword yarn start:ts
# or PGUSER=myuser PGPASSWORD=mysecurepassword npm run start:ts
```

## Build Docker image

```
docker build -t rigwild/catalog-api .
```

## Run with docker-compose

You need to [Build the Docker image](#build-docker-image) first.

The database is automatically imported and the app starts on http://localhost:5000.

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
