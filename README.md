# Mailu Infra server

This document explains the layout of the Mailu websites server, which is running Docker to host the web projects around Mailu. Like documentation, demo and setup.

## Services

In this section the running services are explained. There is a `crontab` file which is a copy of the one used on the server.
It currently has two tasks:

1. Run `./demo/admin-pw.sh` for frequent admin password reset of the demo server. We had bullies changing the admin user password from time to time. Ths roles it back to the usual `letmein` password.
2. Run `update.sh`, which updates the images of all services, should there any available.

### Reverse proxy

Treafik is used as reverse proxy and takes care of (sub) domain web routing.

- `https://mailu.io/<ver>`: Documentation
- `https://setup.mailu.io/<ver>`: Setup
- `https://test.mailu.io:` Demo server

The compose file and configuration can be found in the `./traefik` directory

### Documentation

The documentation docker-compose file is located in the `./docs` directory. It defines a service for every release version of Mailu since `1.5`, including master.

### Setup server

The setup docker-compose file is located in the `./setup` directory. It defines a service for every release version of Mailu since `1.7`, including master.

### Demo server

The demo service docker-compose file is located in the `./demo` directory. It is a customized version which takes care of resource limiting. It uses the `certdumper` service to extract TLS certificates from Treafik.

The `default` network is set to `internal`. Remainning services that need internet access use the `web` network.
The `front` service is bound to the usual ports, except `80` and `443`, as these web ports are routed through traefik.
This means that the demo server can:

 1. Recieve SMTP e-mail (both incomming in authenticated)
 2. Serve authenticated IMAP and POP3 connections from clients
 3. Provide access to the webmail and admin interfaces
 4. Have fully functional virusscanner, downloading the appropiate definitions

However, the demo server cannot send any SMTP mail to external hosts. Those mails will remain stuck in the queueu forever.

## The server

The server is running Ubuntu 18.04.5 LTS, with Docker latest stable from the Docker official APT repositories. `ufw` firewall is enabled and only allows access to ssh port 22. Other ports for services are configured by Docker.

### SSH access

Members of the "Contributors" team can gain access by posting their public keys in `./ssh/<username>`. One line per key. The filenames reflect the Github usernames in all lower-case. The users that currently have a file in this repositories, already have a username associated on the system. If additional users must be added, please first send a PR so that the user can be created first, on the server.

Users are in priciple unprivelidged. For example, they are not member of the `docker` group. It is a small security measure to prevent priviledged access should a private key get compromised. All users are member of the `sudo` group. On first login an user password must be set by the `passwd` command.

Keys that are added must use `rsa` (>= 2048), `ecds` (>=256) or `ed25519`. We also request to make sure the private key is password protected.

A copy of applicable `sshd_config` options can be found in `./ssh/sshd_config`.

### Infra project files

This `Mailu/infra` repository is cloned in `/opt/infra`. Write access is only by root/sudo.

### Rules of conduct

 1. Don't use / abuse the server for anything else then Mailu.
 2. If there is an issue and you need to get in, please announce it on the `Matrix` channel or on a related issue on Github. This way we prevent multiple people interfering at the same time.
 3. If you need to make changes to `/opt/infra` (using `sudo`), it is fine for testing. However, you can't commit from there back to Github. Please clone the repository locally (your own PC), apply any changes, commit and push. Always leave the state of `/opt/infra` clean. (`git checkout -- *` before you log out!)
 4. If `origin/master` is ahead, please pull before doing anything.
 5. If you loose access to a previously added ssh key. Or you have the slightest suspission it got compromised, please remove it from your key file in this repository!
 