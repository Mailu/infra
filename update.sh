#!/bin/bash

# This scripts simply tries to pull newer version for all compose projects.
# It can be run on a regular basis. If no newer images are available,
# containers won't be restarted.

set -e

for service in demo docs setup traefik ; do (
        pushd /opt/infra/$service/
        docker-compose pull
        docker-compose up -d
        popd
        )
done
