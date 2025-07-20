**Create a ResourceQuota called ckad16-rqc in the namespace ckad16-rqc-ns and enforce a limit of one ResourceQuota for the namespace.**

```
student-node ~ ➜  kubectl config use-context cluster2
Switched to context "cluster2".

student-node ~ ➜  kubectl create namespace ckad16-rqc-ns
namespace/ckad16-rqc-ns created

student-node ~ ➜  cat << EOF | kubectl apply -f -
apiVersion: v1
kind: ResourceQuota
metadata:
  name: ckad16-rqc
  namespace: ckad16-rqc-ns
spec:
  hard:
    resourcequotas: "1"
EOF

resourcequota/ckad16-rqc created

student-node ~ ➜  k get resourcequotas -n ckad16-rqc-ns
NAME              AGE   REQUEST               LIMIT
ckad16-rqc   20s   resourcequotas: 1/1  

```
=====

**In the ckad-pod-design namespace, create a pod named privileged-pod that runs the nginx:1.17 image, and the container should be run in privileged mode.**

`kubectl run privileged-pod --image=nginx:1.17 --privileged=true -n ckad-pod-design`

=====