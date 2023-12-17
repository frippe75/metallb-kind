#!/bin/bash

source .env

echo
echo Installing MetalLB into namespace $METALLB_NS
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml

echo
echo Waiting to complete deploy
kubectl wait --namespace $METALLB_NS \
                --for=condition=ready pod \
                --selector=app=metallb \
                --timeout=90s


