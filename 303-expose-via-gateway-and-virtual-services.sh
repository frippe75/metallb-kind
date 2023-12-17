kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/bookinfo/networking/bookinfo-gateway.yaml

# The create gateway
kubectl get gateway
echo

# The create virtual services
kubectl get vs bookinfo  -o yaml | grep spec: -A5000
