curl -H "Host: www.example.com" https://<nodeinternalip>:<gatwaynodeport>

kubectl run netshoot --rm -it --image=nicolaka/netshoot --restart=Never -- sh -c "ping -c 4 apache-svc"
diff rent namespace - apache-svc.<namespace>.svc.cluster.local


modify cluster dns :-
1. chnage ip range on kube-apiserver.yaml
2. chnage ip in dns-svc in kubesystem ns
3. chnage cluster dns value in kubelet confg.ymal
4. chnage config ma passociate to kubelet
5. reastart kubelet 
6. verify by create pod and excute te cat /etc.resol.conf - more in fo see killershell last chard is the author
