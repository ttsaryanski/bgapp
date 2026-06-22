#!/bin/bash

export MYSQL_ROOT_PASSWORD="Parolka-12345"
export MANAGER_IP=$1
export LOCAL_REGISTRY_PORT=$2

echo "* Deploy local registry ..."
docker run -d --name registry -p ${LOCAL_REGISTRY_PORT}:5000 --restart always registry:2

echo "* Clone repository ..."
git clone https://github.com/ttsaryanski/bgapp.git
cd bgapp

echo "* Set configuration ..."
cat > web/config.php <<'EOF'
<?php
   $database = "bulgaria";
   $user = "web_user";
   $password = "Password1";
   $host = "db";
?>
EOF

echo "* Build docker images ..."
echo "* Build and push web image ..."
docker build -t ${MANAGER_IP}:${LOCAL_REGISTRY_PORT}/bgapp_web:1.0 -f Dockerfile.web .
docker push ${MANAGER_IP}:${LOCAL_REGISTRY_PORT}/bgapp_web:1.0

echo "* Build and push db image ..."
docker build -t ${MANAGER_IP}:${LOCAL_REGISTRY_PORT}/bgapp_db:1.0 -f Dockerfile.db .
docker push ${MANAGER_IP}:${LOCAL_REGISTRY_PORT}/bgapp_db:1.0

echo "* Deploy app ..."
docker stack deploy -c docker-compose.yaml bgapp
sleep 10

echo "* Set app replicas count ..."
docker service scale bgapp_web=3