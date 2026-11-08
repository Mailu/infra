#!/bin/bash
set -eux

rm -rf /mailu
cd /opt/infra/demo
/usr/bin/docker compose down
rm -rf /mailu
/usr/bin/docker compose up -d
echo "Waiting for Mailu admin to become healthy..."

timeout 120 bash -c '
    until [ "$(docker inspect -f "{{.State.Health.Status}}" mailu-admin-1 2>/dev/null)" = "healthy" ]; do
        sleep 2
    done
' || {
    echo "ERROR: Mailu admin did not become healthy within 120 seconds" >&2
    exit 1
}

echo "Mailu admin is healthy"
/usr/bin/docker compose exec -T admin /bin/sh -c "flask mailu config-import -u" <<'EOT'
domain:
  - name: test.mailu.io
    domain_accesses: []

user:
  - email: admin@test.mailu.io
    passkeys: []
    password: $bcrypt-sha256$v=2,t=2b,r=8$jcrz4CvyJoCoei5TRDHaZu$nQ/UPbNzvNZ6ZV0DKkJoEn8gSEHP4Im
    global_admin: true
    spam_threshold: 80
    owned_aliases: []
    domain_accesses: []

EOT
