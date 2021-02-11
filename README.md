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

```sh
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

## Postman Collection

See [Catalog_API.postman_collection.json](./Catalog_API.postman_collection.json)

## LICENSE

[The MIT License](./LICENSE)
