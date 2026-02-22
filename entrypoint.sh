#!/bin/bash
cd /home/container

# Fix QEMU temp write
export TMPDIR=/home/container/tmp
mkdir -p $TMPDIR

VNC_PORT=5901
WS_PORT=${SERVER_PORT:-8443}

echo "[+] QEMU VNC     : localhost:${VNC_PORT}"
echo "[+] KasmVNC Web  : ${WS_PORT}"

MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
eval ${MODIFIED_STARTUP} &

sleep 2

# Start KasmVNC as VNC proxy
kasmvncserver \
  --vnc-host localhost \
  --vnc-port ${VNC_PORT} \
  --listen 0.0.0.0 \
  --port ${WS_PORT} \
  --no-desktop \
  --cert none
