You are an administrator preparing your environment to deploy a Kubernetes cluster using kubeadm. Adjust the following network parameters on the system to the following values, and make sure your changes persist reboots:

net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-iptables = 1


Create a nginx pod called nginx-resolver using image nginx, expose it internally with a service called nginx-resolver-service. 
Test that you are able to look up the service and pod names from within the cluster. 
Use the image: busybox:1.28 for dns lookup. Record results in /root/CKA/nginx.svc and /root/CKA/nginx.pod


#Use the command kubectl run and create a nginx pod and busybox pod. Resolve it, nginx service and its pod name from busybox pod.

To create a pod nginx-resolver and expose it internally:

kubectl run nginx-resolver --image=nginx
kubectl expose pod nginx-resolver --name=nginx-resolver-service --port=80 --target-port=80 --type=ClusterIP

#To create a pod test-nslookup. Test that you are able to look up the service and pod names from within the cluster:

kubectl run test-nslookup --image=busybox:1.28 --rm -it --restart=Never -- nslookup nginx-resolver-service
kubectl run test-nslookup --image=busybox:1.28 --rm -it --restart=Never -- nslookup nginx-resolver-service > /root/CKA/nginx.svc

#Get the IP of the nginx-resolver pod and replace the dots(.) with hyphon(-) which will be used below.

kubectl get pod nginx-resolver -o wide
kubectl run test-nslookup --image=busybox:1.28 --rm -it --restart=Never -- nslookup <P-O-D-I-P.default.pod> > /root/CKA/nginx.pod



apiVersion:
kind:
metadata: 
    name: ksslkc
    namespace: djskc
spec:
    targetRef:
        apiVersion
        kind
        name:
    resourcePolicy:
        containerPolicies:
            - containerName: test
              controlledResources: ["cpu" , "memry"]
              maxAllowed: 
                cpu: 1Gi
                memory: 500Mi
              minAllowed:
                cpu: 1Gi
                memory: 500Mi
             mode: "Auto"
    updatePolicy:
        updateMode: "Initial"
