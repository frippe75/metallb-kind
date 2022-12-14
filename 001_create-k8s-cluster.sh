#!/bin/bash


CLUSTER_NAME=cluster01

# Rquires kind binary is installed as well as jq package
type jq >/dev/null 2>&1 && type kind >/dev/null 2>&1 || { echo >&2 "kind binary and jq is required."; exit 1; }

cl=$(kind get clusters | grep $CLUSTER_NAME | wc -l)

if [ "$cl" -eq 0 ]
then
	cat <<EOF | kind create cluster --name $CLUSTER_NAME --config=-
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

fi

# List the cluster
kubectl get nodes -o wide
