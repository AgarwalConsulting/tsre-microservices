#!/usr/bin/env bash

set -e

echo "Starting..."

## Create Datadog secret
# echo "> Creating Datadog Secret"
# kubectl create secret generic datadog-secret \
#   --from-literal=api-key=$DD_API_KEY \
#   --from-literal=app-key=$DD_APP_KEY

## Deploy Datadog Agent
# echo "> Deploying Datadog Agent"
# helm install datadog-agent -f ctf/datadog-values.yaml datadog/datadog --set datadog.apiKey=$DD_API_KEY

## Deploy Microservices
echo "> Deploying Microservices"
echo "Applying pre-prepared images"
kubectl apply -f kubernetes-manifests/adservice.yaml
kubectl apply -f kubernetes-manifests/cartservice.yaml
kubectl apply -f kubernetes-manifests/checkoutservice.yaml
kubectl apply -f kubernetes-manifests/currencyservice.yaml
kubectl apply -f kubernetes-manifests/emailservice.yaml
kubectl apply -f kubernetes-manifests/loadgenerator.yaml
kubectl apply -f kubernetes-manifests/paymentdbservice.yaml
kubectl apply -f kubernetes-manifests/productcatalogservice.yaml
kubectl apply -f kubernetes-manifests/recommendationservice.yaml
kubectl apply -f kubernetes-manifests/redis.yaml
kubectl apply -f kubernetes-manifests/shippingservice.yaml

## Skaffold build and run
until [[ $(kubectl get pods --no-headers | wc -l) -gt 17 ]]; do
  skaffold run --platform=linux/amd64
done

## Configure Extras
# echo "> Configuring Extras"
# export AGENT_POD=$(kubectl get pods -l app.kubernetes.io/name=datadog-agent -o jsonpath='{.items[0].metadata.name}')

# Retrieve the Frontend Load Balancer URL (using port-forwarding as Kind does not provide a service URL like Minikube)
# kubectl port-forward service/frontend-lb 8081:80 &
# export FRONTEND_LB="http://localhost:8081"

# ./ctf/microservices/conf_nginx.sh
