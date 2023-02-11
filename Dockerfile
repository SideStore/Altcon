FROM debian:unstable-slim

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates usbmuxd libimobiledevice6 libimobiledevice-utils libavahi-compat-libdnssd-dev curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/ && \
    mkdir app

WORKDIR /app/

COPY . .

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN ./get-altserver-linux.sh && \
    curl -L -o SideStore.ipa $(curl -s https://api.github.com/repos/SideStore/SideStore/releases/latest | grep "browser_download_url.*SideStore*" | cut -d : -f 2,3 | tr -d \")

ENTRYPOINT ["./docker-entrypoint.sh"]

