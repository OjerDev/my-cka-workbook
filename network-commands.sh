curl -H "Host: www.example.com" https://<nodeinternalip>:<gatwaynodeport>

kubectl run netshoot --rm -it --image=nicolaka/netshoot --restart=Never -- sh -c "ping -c 4 apache-svc"
diff rent namespace - apache-svc.<namespace>.svc.cluster.local
