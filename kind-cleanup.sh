#!/usr/bin/env bash

cp /opt/homebrew/etc/nginx/nginx.conf.default /opt/homebrew/etc/nginx/nginx.conf
sudo nginx -t

kind delete cluster --name my-cluster
