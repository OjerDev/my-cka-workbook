###### Json related qustions :- 

 kubectl get crd certificates.cert-manager.io -o jsonpath={.spec.versions[*].schema.openAPIV3Schema.properties.spec.properties.subject}

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












3. kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' > /root/CKA/node_ips

4. kubectl get svc redis-service -o jsonpath='{.spec.ports[0].targetPort}'

5. 


