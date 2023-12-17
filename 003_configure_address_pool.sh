#!/bin/bash

source .env

echo
echo Check Docker networking for kind subnet
if [ "$(type podman)" ]
then
        echo Using Podman
        subnet=$(docker network inspect -f '{{ json . }}' kind| jq -r .[0].subnets[1].subnet | cut -f 1 -d /)
else
        echo Using Docker
        subnet=$(docker network inspect -f '{{json .IPAM.Config}}' kind  | jq -r '.[].Subnet' | head -1 | cut -f 1 -d /)
fi
echo Subnet is $subnet
first_ip=$(echo $subnet | cut -f 1-3 -d . | awk '{print $1 ".100"}')
last_ip=$(echo $subnet | cut -f 1-3 -d . | awk '{print $1 ".200"}')
echo Range is $first_ip - $last_ip

echo
echo Creating IPAddressPool and L2Advertisement ...

cat <<EOF | kubectl apply -f -

apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: first-pool
  namespace: $METALLB_NS
spec:
  addresses:
  - $first_ip-$last_ip
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: pool
  namespace: $METALLB_NS
spec:
  ipAddressPools:
    - first-pool

EOF

# List it (not using first-pool
echo
echo Get all pools:
kubectl get ipaddresspools.metallb.io -A

echo
echo Get l2advertisements
kubectl get l2advertisements.metallb.io --namespace=$METALLB_NS


