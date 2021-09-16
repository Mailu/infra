#!/bin/bash
rm -rf /mailu
cd /opt/infra/demo
/usr/local/bin/docker-compose down || exit 1
rm -rf /mailu
/usr/local/bin/docker-compose up -d || exit 1
