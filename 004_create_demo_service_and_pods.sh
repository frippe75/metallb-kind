#!/bin/bash

echo
echo Creating http-echo Pods and Service via MetalLB loadbalancer ...
cat <<EOF | kubectl apply -f -

kind: Pod
apiVersion: v1
metadata:
  name: red-app
  labels:
    app: color-app
spec:
  containers:
  - name: red-app
    image: hashicorp/http-echo:0.2.3
    args:
    - "-text=red"
---
kind: Pod
apiVersion: v1
metadata:
  name: green-app
  labels:
    app: color-app
spec:
  containers:
  - name: green-app
    image: hashicorp/http-echo:0.2.3
    args:
    - "-text=green"
---
kind: Pod
apiVersion: v1
metadata:
  name: blue-app
  labels:
    app: color-app
spec:
  containers:
  - name: blue-app
    image: hashicorp/http-echo:0.2.3
    args:
    - "-text=blue"
---
kind: Service
apiVersion: v1
metadata:
  name: color-service
spec:
  type: LoadBalancer
  selector:
    app: color-app
  ports:
  # Default port used by the image
  - port: 5678
EOF

