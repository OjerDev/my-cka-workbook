###### Json related qustions :- 

#imp commands:-

kubectl get nodes -o json | jq -c 'paths'   ----< #it will show the paths exactly



1. Print the names of all deployments in the admin2406 namespace in the following format:

DEPLOYMENT   CONTAINER_IMAGE   READY_REPLICAS   NAMESPACE

<deployment name>   <container image used>   <ready replica count>   <Namespace>
. The data should be sorted by the increasing order of the deployment name.


Example:

DEPLOYMENT   CONTAINER_IMAGE   READY_REPLICAS   NAMESPACE
deploy0     nginx:alpine              1         admin2406

Write the result to the file /opt/admin2406_data.



ANS:- 

Solution: kubectl -n admin2406 get deployment -o custom-columns=DEPLOYMENT:.metadata.name,CONTAINER_IMAGE:.spec.template.spec.containers[].image,READY_REPLICAS:.status.readyReplicas,NAMESPACE:.metadata.namespace --sort-by=.metadata.name > /opt/admin2406_data

kubectl get pods -A -o custom-columns='IP_ADDRESS:.status.podIP'
=====================


2. List the InternalIP of all nodes of the cluster. Save the result to a file /root/CKA/node_ips.

Answer should be in the format: InternalIP of controlplane<space>InternalIP of node01 (in a single line)

Explore the jsonpath loop.


k get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}'












kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' > /root/CKA/node_ips



apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: alpine-pod
  name: alpine-pod
spec:
  containers:
  - image: alpine:latest
    name: alpine-container
    command: ["/bin/sh", "-c"]
    args: ["tail -f /config/log.txt"]
    resources: {}
    volumeMounts:
      - name: config-volume
        mountPath: /config
  dnsPolicy: ClusterFirst
  volumes:
    - name: config-volume
      configMap:
        name: log-configmap
  restartPolicy: Never
status: {}

Create a Kubernetes Pod configuration to facilitate real-time monitoring of a log file. Specifically, you need to set up a Pod named alpine-pod-pod that runs an Alpine Linux container.

Requirements:

Name the Pod alpine-pod-pod
Use alpine:latest image
Container name alpine-container
Configure the container to execute the tail -f /config/log.txt command(using args ) with /bin/sh (using command ) to continuously monitor and display the contents of a log file.
Set up a volume named config-volume that maps to a ConfigMap named log-configmap , this log-configmap already available.
Ensure the Pod has a restart policy of Never .