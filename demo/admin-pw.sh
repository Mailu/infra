#!/bin/bash
cd /opt/infra/demo
/usr/local/bin/docker-compose exec -d admin flask mailu password admin test.mailu.io letmein