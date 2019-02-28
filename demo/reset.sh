#!/bin/bash
cd /opt/infra/demo
/usr/bin/docker-compose down || exit 1
rm -rf /mailu
/usr/bin/docker-compose up -d || exit 1
sleep 30
/usr/bin/docker-compose exec admin flask mailu admin admin test.mailu.io letmein || exit 1
