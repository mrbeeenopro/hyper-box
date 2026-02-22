FROM debian:bookworm-slim

RUN apt update && apt install -y \
    qemu-system-x86 \
    qemu-utils \
    iproute2 \
    net-tools \
    curl \
    ca-certificates \
    python3 \
    git \
    python3-numpy \
    dbus-x11 \
    xauth \
    xvfb \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt update && apt install -y wget gnupg \
 && wget -O kasmvnc.deb https://github.com/kasmtech/KasmVNC/releases/latest/download/kasmvncserver_bookworm_amd64.deb \
 && apt install -y ./kasmvnc.deb \
 && rm kasmvnc.deb

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN useradd -m -d /home/container container
USER container

WORKDIR /home/container
CMD ["/bin/bash", "/entrypoint.sh"]
