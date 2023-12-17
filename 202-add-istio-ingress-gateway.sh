kubectl create namespace istio-ingress
helm install istio-ingress istio/gateway -n istio-ingress --wait

