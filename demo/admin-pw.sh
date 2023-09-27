#!/bin/bash
cd /opt/infra/demo
/usr/bin/docker compose exec admin flask mailu admin --mode update admin test.mailu.io MailuDemo >/dev/null
