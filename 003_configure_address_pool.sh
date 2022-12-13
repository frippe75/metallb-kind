#!/bin/bash

echo
echo Creating IPAddressPool and L2Advertisement ...

cat <<EOF | kubectl apply -f -

apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: first-pool
  namespace: metallb-system
spec:
  addresses:
  - 172.18.0.100-172.18.0.200
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: pool
  namespace: metallb-system
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
kubectl get l2advertisements.metallb.io --namespace=metallb-system


