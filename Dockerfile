FROM debian:unstable-slim

# Debug armv7 build
RUN uname -m

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates usbmuxd libimobiledevice6 libimobiledevice-utils libavahi-compat-libdnssd-dev curl wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/ && \
    mkdir app

WORKDIR /app/

COPY . .

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN ./downloader.sh && \
    mv AltServer-* AltServer && \
    chmod +x AltServer && \
    curl -s https://api.github.com/repos/SideStore/SideStore/releases/latest | grep "browser_download_url.*ipa*" | cut -d : -f 2,3 | tr -d \" | wget -qi -

ENTRYPOINT ["./docker-entrypoint.sh"]

