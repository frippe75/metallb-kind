#!/bin/bash

LB_IP=$(kubectl get svc/color-service -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
LB_PORT=$(kubectl get svc/color-service -o=jsonpath='{.spec.ports[0].port}')
echo
echo MetalLB IP from the pool is $LB_IP

resolved=$(getent hosts $LB_IP | awk '{print $2}')
if [ "$resolved" != "" ]
then
        echo
        echo IP $LB_IP resolves to $resolved
        echo
        endpoint=$resolved
else
        endpoint=$LB_IP
fi



# should output foo and bar on separate lines
echo Hitting the LB endpoint http://${endpoint}:${LB_PORT} ten times to see if we are hitting different pods
for _ in {1..10}; do
        curl ${LB_IP}:${LB_PORT}
done
