#!/bin/bash
rm -rf /mailu
cd /opt/infra/demo
/usr/bin/docker compose down || exit 1
rm -rf /mailu
/usr/bin/docker compose up -d || exit 1
