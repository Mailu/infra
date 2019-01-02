FROM debian:stretch-slim

RUN apt-get update && apt-get install -y openssh-server && rm -rf rm -rf /var/lib/apt/lists/*

COPY start.sh /start.sh
COPY sshd_config /etc/ssh/sshd_config
RUN mkdir -p /run/sshd /key /cache

VOLUME ['/key']
VOLUME ['/cache']
EXPOSE 22/tcp

CMD /start.sh
