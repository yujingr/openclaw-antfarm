#!/bin/bash
set -e

chown -R openclaw:openclaw /data
chmod 700 /data

if [ ! -d /data/.linuxbrew ]; then
  cp -a /home/linuxbrew/.linuxbrew /data/.linuxbrew
fi

rm -rf /home/linuxbrew/.linuxbrew
ln -sfn /data/.linuxbrew /home/linuxbrew/.linuxbrew

mkdir -p /data/.openclaw
chown openclaw:openclaw /data/.openclaw
ln -sfn /data/.openclaw /home/openclaw/.openclaw

chown -R openclaw:openclaw /opt/antfarm
mkdir -p /home/openclaw/.local/bin
ln -sfn /opt/antfarm/dist/cli/cli.js /home/openclaw/.local/bin/antfarm
chmod +x /opt/antfarm/dist/cli/cli.js

gosu openclaw node /opt/antfarm/dist/server/daemon.js 3333 &

exec gosu openclaw node src/server.js
