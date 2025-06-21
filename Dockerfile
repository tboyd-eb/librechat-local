FROM ghcr.io/danny-avila/librechat-dev
USER root
RUN apk add docker-cli
USER node
