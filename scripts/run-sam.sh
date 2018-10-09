#!/bin/sh
set -e

until ls -l /var/opt/dist/vehicle; do
  >&2 echo "Waiting for build to complete. - sleeping for 2 seconds"
  sleep 2
done

>&2 echo "Build complete - Running SAM now..."
env | sort
sam local start-api --docker-volume-basedir "${VOLUME}/" --host 0.0.0.0 --template template.yml
