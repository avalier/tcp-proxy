FROM alpine:latest AS runtime

LABEL org.opencontainers.image.source=https://github.com/avalier/tcp-proxy

WORKDIR /app
ENV HOME=/app

ENV PROXIES='[ { "source": "6000", "target": "127.0.0.1:5000" } ]'

RUN apk add bash socat jq \
    && addgroup -S app && adduser -S -G app --home "/app" --no-create-home --disabled-password app \
    && mkdir -p /app && chown app:app /app && chmod 755 /app

COPY --chown=app:app main.sh /app/
RUN chmod 755 /app/main.sh

USER app

ENTRYPOINT /app/main.sh

