#!/bin/bash
cd /opt/infra/demo
/usr/local/bin/docker-compose exec admin flask mailu admin --mode update admin test.mailu.io letmein >/dev/null
