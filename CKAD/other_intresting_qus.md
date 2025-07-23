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

In the ckad14-sa-projected namespace, configure the ckad14-api-pod Pod to include a projected volume named vault-token.

Mount the service account token to the container at /var/run/secrets/tokens, with an expiration time of 7000 seconds.

Additionally, set the intended audience for the token to vault and path to vault-token.

```
   volumeMounts:                              # Added
    - mountPath: /var/run/secrets/tokens       # Added
      name: vault-token                        # Added
.
  serviceAccount: ckad14-sa
  serviceAccountName: ckad14-sa
  volumes:
  - name: vault-token                   # Added
    projected:                          # Added
      sources:                          # Added
      - serviceAccountToken:            # Added
          path: vault-token             # Added
          expirationSeconds: 7000       # Added
          audience: vault               # Added
```
