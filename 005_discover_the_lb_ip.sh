#!/bin/bash

LB_IP=$(kubectl get svc/color-service -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo
echo MetalLB ip from the pool is $LB_IP


# should output foo and bar on separate lines 
echo Hitting the LB ten times to see if we are hitting different pods
for _ in {1..10}; do
	curl ${LB_IP}:5678
done
