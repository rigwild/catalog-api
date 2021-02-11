#!/bin/bash
PGUSER=postgres \
PGHOST=127.0.0.1 \
PGDATABASE=catalog \
PGPASSWORD=secretpassword \
yarn start:ts
