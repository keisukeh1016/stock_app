#!/bin/bash

set -e

until PGPASSWORD="$POSTGRES_PASSWORD" psql -h "$POSTGRES_HOST" -U "$POSTGRES_USERNAME" -c '\l'; do
  echo "Postgres is sleeping"
  sleep 1
done

echo "Postgres is up"

bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails assets:precompile