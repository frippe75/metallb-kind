#!/bin/bash

echo
echo Installing MetalLB into namespace metallb-system
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml

echo
echo Waiting to complete deploy
kubectl wait --namespace metallb-system \
                --for=condition=ready pod \
                --selector=app=metallb \
                --timeout=90s


echo
echo Check Docker networking
docker network inspect -f '{{.IPAM.Config}}' kind



