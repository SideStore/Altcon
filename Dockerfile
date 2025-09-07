FROM debian:trixie-slim

ENV ALTSERVER_ANISETTE_SERVER="https://ani.sidestore.io/"

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates usbmuxd libimobiledevice-1.0-6 libimobiledevice-utils curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/ && \
    mkdir app

WORKDIR /app/

COPY get-latest-files.sh .

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN ./get-latest-files.sh && \
    rm get-latest-files.sh

COPY docker-entrypoint.sh .

ENTRYPOINT ["./docker-entrypoint.sh"]
