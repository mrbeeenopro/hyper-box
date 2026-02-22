#!/bin/bash

export HOME=/home/container
mkdir -p $HOME/.vnc $HOME/tmp
chmod 700 $HOME/.vnc

export TMPDIR=$HOME/tmp

VNC_PORT=5901
WS_PORT=${SERVER_PORT:-8443}

echo "[+] User: $(id -u)"
echo "[+] HOME: $HOME"

MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
eval ${MODIFIED_STARTUP} &

sleep 2

kasmvncserver \
  --vnc-host localhost \
  --vnc-port ${VNC_PORT} \
  --listen 0.0.0.0 \
  --port ${WS_PORT} \
  --no-desktop \
  --cert none
