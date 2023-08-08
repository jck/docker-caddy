# syntax=docker/dockerfile:1
ARG CADDY_VERSION=2.7.2

FROM caddy:${CADDY_VERSION}-builder AS builder

# https://github.com/caddyserver/caddy-docker/issues/307#issuecomment-1670301042
RUN --mount=type=cache,target=/go/pkg/mod --mount=type=cache,target=/root/.cache/go-build \
  xcaddy build v2.7.3 \
  --with github.com/caddy-dns/cloudflare \
  --with github.com/lucaslorentz/caddy-docker-proxy/v2

FROM caddy:${CADDY_VERSION}

LABEL org.opencontainers.image.description="Caddy with dns.providers.cloudflare module"

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
