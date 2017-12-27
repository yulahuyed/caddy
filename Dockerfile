FROM alpine:3.2

RUN apk add --update openssh-client git tar

RUN wget -O "caddy.tar.gz" "https://caddyserver.com/download/linux/amd64"
RUN tar zxvf caddy.tar.gz
RUN mv caddy /usr/bin/
RUN rm -rf ./init

RUN chmod +x /usr/bin/caddy && /usr/bin/caddy -version

EXPOSE 8080 8443
WORKDIR /srv

ADD Caddyfile /etc/Caddyfile
ADD public/ /srv/public/
ADD publics/ /srv/publics/
ADD certs/ /srv/certs

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile"]
