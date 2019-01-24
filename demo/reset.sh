#!/bin/bash
cd /opt/infra/demo
docker-compose down || exit 1
rm -rf /mailu
docker-compose up -d || exit 1
sleep 30
docker-compose exec admin flask mailu admin admin test.mailu.io letmein || exit 1
