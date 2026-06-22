#!/bin/bash

MANAGER_IP=$1
LOCAL_REGISTRY_PORT=$2

echo "* Make manager ip trusted for docker ..."
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "insecure-registries": ["${MANAGER_IP}:${LOCAL_REGISTRY_PORT}"]
}
EOF

sudo systemctl restart docker