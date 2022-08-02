ARG CADDY_VERSION=2.5.2

FROM caddy:${CADDY_VERSION}-builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare

FROM caddy:${CADDY_VERSION}

LABEL org.opencontainers.image.description="Caddy with dns.providers.cloudflare module"

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
