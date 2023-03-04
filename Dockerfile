FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates usbmuxd libimobiledevice6 libimobiledevice-utils libavahi-compat-libdnssd-dev curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/ && \
    mkdir app

WORKDIR /app/

COPY . .

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN ./get-altserver.sh

ENTRYPOINT ["./docker-entrypoint.sh"]
