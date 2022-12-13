#!/bin/bash

#kind create cluster

# https://gist.github.com/developer-guy/173347e71f92a61abbc017deb518b6cb

cat <<EOF | kind create cluster --name cluster01 --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  podSubnet: "10.110.0.0/16"
  serviceSubnet: "10.115.0.0/16"
nodes:
- role: control-plane
- role: worker
- role: worker
EOF

# List the cluster
kubectl get nodes -o wide
