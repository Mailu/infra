#!/bin/sh

if [ -z $PASSWD ]; then
    echo '$PASSWD empty, aborting'
    exit 2
fi

useradd -d /cache cache
echo "cache:$PASSWD" | chpasswd

key="/key/ssh_host_ecdsa_key"
if ! [ -f $key ]; then
    ssh-keygen -f $key -N '' -t ecdsa || exit 2
fi
chmod 600 $key

exec /usr/sbin/sshd -D -e -h /key/ssh_host_ecdsa_key
