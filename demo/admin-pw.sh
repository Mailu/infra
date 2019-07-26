#!/bin/bash
cd /opt/infra/demo
/usr/bin/docker-compose exec -d admin flask mailu password admin test.mailu.io letmein