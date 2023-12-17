source .env 

# Create a namespace to hold the bookinfo app
kubectl create namespace $BOOKINFO_NS

# Automatically injet the Istio sidecar proxy container
kubectl label namespace $BOOKINFO_NS istio-injection=enabled

# Create a new context and switch to it
kubectl config set-context kind-$BOOKINFO_NS --namespace=$BOOKINFO_NS --cluster kind-$CLUSTER_NAME --user kind-$CLUSTER_NAME
kubectl config use-context kind-$BOOKINFO_NS

# Deploy the app
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.20/samples/bookinfo/platform/kube/bookinfo.yaml --wait

