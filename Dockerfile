ARG CADDY_VERSION=2.6.2

FROM caddy:2.6.4-builder AS builder

RUN --mount=type=cache,target=/go/pkg xcaddy build \
  --with github.com/caddy-dns/cloudflare

FROM caddy:2.6.4

LABEL org.opencontainers.image.description="Caddy with dns.providers.cloudflare module"

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
