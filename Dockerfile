# syntax=docker/dockerfile:1
ARG CADDY_VERSION=2.6.2

FROM caddy:${CADDY_VERSION}-builder AS builder

RUN --mount=type=cache,target=/go/pkg/mod --mount=type=cache,target=/root/.cache/go-build \
  xcaddy build \
  --with github.com/caddy-dns/cloudflare

FROM caddy:${CADDY_VERSION}

LABEL org.opencontainers.image.description="Caddy with dns.providers.cloudflare module"

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
