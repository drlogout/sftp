FROM debian:9.5
 
ARG SSH_MASTER_USER
ARG SSH_MASTER_PASS
 
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    nano \
    sudo \
    openssh-server
 
COPY ssh_config /etc/ssh/ssh_config
COPY sshd_config /etc/ssh/sshd_config

RUN echo 'www-data:www-data' | chpasswd && \
    /bin/bash -c 'usermod -s /bin/bash www-data'

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
 
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
 
CMD tail -f /dev/null