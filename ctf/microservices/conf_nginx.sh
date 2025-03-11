#!/bin/bash

gsed -e "s~FRONTEND_LB~${FRONTEND_LB}~" ./ctf/microservices/nginx.conf > /opt/homebrew/etc/nginx/nginx.conf

# mkdir -p /opt/homebrew/Cellar/nginx/1.27.4/logs/
# touch /opt/homebrew/Cellar/nginx/1.27.4/logs/host.access.log

echo "restarting nginx"
nginx -t
