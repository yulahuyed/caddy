FROM alpine:3.2

LABEL caddy_version="0.8.2" architecture="amd64"

RUN apk add --update openssh-client git tar

ADD caddy /usr/bin/

RUN chmod 0755 /usr/bin/caddy \
 && /usr/bin/caddy -version

EXPOSE 8080 8443
VOLUME /srv
WORKDIR /srv

ADD Caddyfile /etc/Caddyfile
ADD public/index.html /srv/public/index.html
ADD publics/index.html /srv/publics/index.html
ADD certs/ /srv/certs

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile"]
