# Create Dashboard using helm if it exists

if [[ $(type helm 2>1) ]] 
then
	# https://medium.com/@munza/local-kubernetes-with-kind-helm-dashboard-41152e4b3b3d
        helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
	helm install dashboard kubernetes-dashboard/kubernetes-dashboard -n kubernetes-dashboard --create-namespace
else
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

fi

# Create a ServiceAccount and ClusterRoleBinding to provide admin access to the newly created cluster
kubectl create serviceaccount -n kubernetes-dashboard admin-user
kubectl create clusterrolebinding -n kubernetes-dashboard admin-user --clusterrole cluster-admin --serviceaccount=kubernetes-dashboard:admin-user
	
# Grab token
token=$(kubectl -n kubernetes-dashboard create token admin-user)
echo $token

echo
echo http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:dashboard-kubernetes-dashboard:https/proxy/#/login
echo
kubectl proxy | sed s'#127#http://127#'





