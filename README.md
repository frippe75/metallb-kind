# Metallb-kind
Simple scripts to deploy MetalLB on Kind K8S cluster

## Description
A few simple script to try out MetalLB using minimum effort
<br>
<br>

Output from running the examples 
```
$ ./run-all.sh 

Creating K8S cluster ...
NAME                      STATUS   ROLES                  AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE       KERNEL-VERSION      CONTAINER-RUNTIME
cluster01-control-plane   Ready    control-plane,master   9h    v1.21.1   172.18.0.3    <none>        Ubuntu 21.04   5.15.0-56-generic   containerd://1.5.2
cluster01-worker          Ready    <none>                 9h    v1.21.1   172.18.0.5    <none>        Ubuntu 21.04   5.15.0-56-generic   containerd://1.5.2
cluster01-worker2         Ready    <none>                 9h    v1.21.1   172.18.0.4    <none>        Ubuntu 21.04   5.15.0-56-generic   containerd://1.5.2

Installing MetalLB into namespace metallb-system ...
namespace/metallb-system unchanged
customresourcedefinition.apiextensions.k8s.io/addresspools.metallb.io configured
customresourcedefinition.apiextensions.k8s.io/bfdprofiles.metallb.io configured
customresourcedefinition.apiextensions.k8s.io/bgpadvertisements.metallb.io configured
customresourcedefinition.apiextensions.k8s.io/bgppeers.metallb.io configured
customresourcedefinition.apiextensions.k8s.io/communities.metallb.io configured
customresourcedefinition.apiextensions.k8s.io/ipaddresspools.metallb.io configured
customresourcedefinition.apiextensions.k8s.io/l2advertisements.metallb.io configured
serviceaccount/controller unchanged
serviceaccount/speaker unchanged
role.rbac.authorization.k8s.io/controller unchanged
role.rbac.authorization.k8s.io/pod-lister unchanged
clusterrole.rbac.authorization.k8s.io/metallb-system:controller unchanged
clusterrole.rbac.authorization.k8s.io/metallb-system:speaker unchanged
rolebinding.rbac.authorization.k8s.io/controller unchanged
rolebinding.rbac.authorization.k8s.io/pod-lister unchanged
clusterrolebinding.rbac.authorization.k8s.io/metallb-system:controller unchanged
clusterrolebinding.rbac.authorization.k8s.io/metallb-system:speaker unchanged
secret/webhook-server-cert unchanged
service/webhook-service unchanged
deployment.apps/controller unchanged
daemonset.apps/speaker unchanged
validatingwebhookconfiguration.admissionregistration.k8s.io/metallb-webhook-configuration configured

Waiting to complete deploy ...
pod/controller-54b4fd6944-gkddw condition met
pod/speaker-czgvn condition met
pod/speaker-p8tpf condition met
pod/speaker-z5j9f condition met

Check Docker networking ...
[{172.18.0.0/16  172.18.0.1 map[]} {fc00:f853:ccd:e793::/64  fc00:f853:ccd:e793::1 map[]}]

Creating IPAddressPool and L2Advertisement ...
ipaddresspool.metallb.io/first-pool unchanged
l2advertisement.metallb.io/pool unchanged

Get all pools:
NAMESPACE        NAME         AUTO ASSIGN   AVOID BUGGY IPS   ADDRESSES
metallb-system   first-pool   true          false             ["172.18.0.100-172.18.0.200"]

Get l2advertisements
NAME         IPADDRESSPOOLS   IPADDRESSPOOL SELECTORS   INTERFACES
empty                                                   
first-pool                                              
pool         ["first-pool"]                             

Creating http-echo Pods and Service via MetalLB loadbalancer ...
pod/red-app unchanged
pod/green-app unchanged
pod/blue-app unchanged
service/color-service unchanged

MetalLB ip from the pool is 172.18.0.101
Hitting the LB ten times to see if we are hitting different pods
red
blue
blue
red
red
blue
green
blue
red
green
```
