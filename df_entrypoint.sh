#!/bin/sh

# Wait for the database to be ready
# We use NetCat to check if the port is open and listening
echo "Waiting for database..."
while ! nc -z "$POSTGRES_HOST" "$POSTGRES_PORT"; do
  sleep 1
done

# Run migrations
echo "Running migrations..."
python manage.py migrate --noinput

exec "$@"
