# https://istio.io/latest/docs/setup/install/helm/
#
# Helm was chosen due to this text on Istio pages
#   Use of the operator for new Istio installations is discouraged in favor of the Istioctl and Helm installation methods. 
#   While the operator will continue to be supported, new feature requests will not be prioritized.

ISTIO_NS=istio-system

# Add Helm repos
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

# Create a namespace to hold the installation
kubectl create namespace $ISTIO_NS

# Install using defaults
helm install istio-base istio/base -n $ISTIO_NS --set defaultRevision=default

# Install the Istio discovery chart which deploys the istiod service
helm install istiod istio/istiod -n istio-system --wait

# Validate the CRD installation and the istiod with the helm 
echo
helm ls -n istio-system





