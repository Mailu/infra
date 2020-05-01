#!/bin/bash
cd /opt/infra/demo
/usr/local/bin/docker-compose down || exit 1
rm -rf /mailu
/usr/local/bin/docker-compose up -d || exit 1
sleep 30
/usr/local/bin/docker-compose exec -d admin flask mailu admin admin test.mailu.io letmein || exit 1
