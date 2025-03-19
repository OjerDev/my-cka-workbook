

alias k=kubectl

kubectl api-resources


#create deployment and expose deployment
kubectl create deployment nginx --image=nginx --port=80
kubectl expose deployment nginx --port=80  --name=nginx --type=ClusterIP
kubectl expose deployment nginx --port=80  --target-port=80 --name=nginx --type=NodePort

also :- kubectl expose deploy nginx

#also for recording :- 
kubectl create deployment nginx --image=nginx:1.16
kubectl set image deployment nginx imagename=nginx:1.17 --record
kubectl history rollout history deployment nginx 

kubectl run secret-1401 -n admin1401 --image=busybox --command -- sleep 4800

#scale the deployment
kubectl scale deployment nginx --current-replicas=2 --replicas=3

#independently creating the deployment and service
kubectl create deployment nginx --image=nginx --port=80
kubectl create service clusterip nginx --tcp=8080:80


#hpa 

kubectl autoscale deployment nginx  --cpu-percent=85 --min=10 --max=20 


#vpa
kubectl explain vpa

kubectl explain vpa.spec --recursive=true

--------

#writing the logs from many container on deployment AND POD

kubectl logs <podname>

kubectl describe pod  <podname>

kubectl logs <podname> | grep -i unable-to-access-website

kubectl -n management logs deploy/collect-data -c nginx >> /root/logs.log

kubectl -n management logs deploy/collect-data -c httpd >> /root/logs.log

Or:

kubectl -n management logs --all-containers deploy/collect-data > /root/logs.l

--------

#Check to see how many nodes are ready (not including nodes tainted NoSchedule)and write the number to file.txt.

k get nodes | grep -i ready | grep -v  NoSchedule | wc -l > file.txt


#kubernetes cluster installation using kubeadm

###check container run time already installed or not CRI 

sudo apt-get update

sudo apt-get install -y apt-transport-https ca-certificates curl

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

# To see the new version labels
sudo apt-cache madison kubeadm

sudo apt-get install -y kubelet=1.32.0-1.1 kubeadm=1.32.0-1.1 kubectl=1.32.0-1.1

sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable --now kubelet


kubeadm init --apiserver-cert-extra-sans=controlplane --apiserver-advertise-address 192.133.43.3 --pod-network-cidr=10.244.0.0/16

if nodes are not ready, then you need to install the cni pluign like flannel. 

------------


#cluster version upgrade

kubectl drain controlplane --ignore-daemonsets

vim /etc/apt/sources.list.d/kubernetes.list

sudo apt update

apt-cache madison kubeadm

sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.32.0-1.1' && \
sudo apt-mark hold kubeadm


sudo kubeadm upgrade plan

kubeadm upgrade apply v1.32.0

#for kubelet && kubectl :-

sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet='1.32.0-1.1' kubectl='1.32.0-1.1' && \
sudo apt-mark hold kubelet kubectl

sudo systemctl daemon-reload && sudo systemctl restart kubelet

kubectl uncordon controlplane

for worker node :- 

kubectl drain node01

after instling kubeadm :- kubeadm upgrade node

--------

#check control plane pod goes wrong :- 

# seems like the kubelet can't even create the apiserver pod/container
/var/log/pods # nothing
crictl logs # nothing

# syslogs:
tail -f /var/log/syslog | grep apiserver

# or:
journalctl | grep apiserver


-------



# debugging worker node 

## check the kubelet
grep kubelet /var/log/syslog 
journalctl -u kubelet
ps -aux | grep kubelet

to check the kubelet file - > 
/var/lib/kubelet/config.yaml
/etc/kubernetes/kubelet.conf
/var/lib/kubelet/kubeadm-arg.env




openssl x509 -in /var/lib/kubelet/pki/kubelet-client-current.pem -text


# check kube-proxy :- 

  check the daemonset first and identify the config map:-

  spec:
    containers:
    - command:
        - /usr/local/bin/kube-proxy
        - --config=/var/lib/kube-proxy/config.conf
        - --hostname-override=$(NODE_NAME)

---------

# important command
cat <<EOF | kubectl apply -f -

EOF

-------
kubectl get nodes --show-labels
kubectl label nodes <your-node-name> disktype=ssd

k create configmap --from-literal=key:value

kubectl create secret tls webhook-server-tls --cert="/root/keys/webhook-server-tls.crt" --key="/root/keys/webhook-server-tls.key"


-------

#RBAC
k create clusterrolebinding michelle-node-access --clusterrole=node-viewer --user=michelle
k create clusterrolebinding michellerolebinding --user=michelle --clusterole=michellerole




k create clusterrole storage-admin --verb=get,list,watch,create,update,delete --resource=persistentvolumes,storageclasses
kubectl create clusterrolebinding michelle-storage-admin --clusterrole=storage-admin --user=michelle 



ETCDCTL_API=3 etcdctl --endpoints localhost:2379 \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  snapshot save /opt/etcd-backup.db


k auth can-i get pv --as=system:serviceaccount:default:pvviewer

kubectl auth can-i list pods --as=system:serviceaccount:default:my-service-account



