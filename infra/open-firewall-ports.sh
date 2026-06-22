#!/bin/bash

echo "* Firewall - swarm - open ports ..."
firewall-cmd --add-port=2377/tcp --permanent
firewall-cmd --add-port=4789/udp --permanent
firewall-cmd --add-port=7946/tcp --permanent
firewall-cmd --add-port=7946/udp --permanent

echo "* Firewall - app - open port 8080 ..."
firewall-cmd --add-port=8080/tcp --permanent
firewall-cmd --reload
