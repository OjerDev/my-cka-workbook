####### Helm relates qustions:-


Helm Show Values - show chart values


1. install argo-cd with version 7.7.3 and "no crd" and no need to isntall

kubectl apply -k https://github.com/argoproj/argo-cd/manifests/crds\?ref\=stable

helm search hub --list-repo-url

helm repo add argo https://argoproj.github.io/argo-helm

helm repo update

help repo list

helm search repo argo

helm template argocd argo/argo-cd --version 7.7.3 --namespace argocd --set crds.install=false > ~/argo-helm.yaml

-====================

2. Deploying the new version :- 

helm repo ls

help repo update

helm ls -A

helm upgrade kk-mock1 kk-mock1/nginx --version 18.1.15 -n kk-ns

======================

#helm

helm repo add <name> <repositoryname>
helm install <relaeasename> <chartname>

to check the releases and revision:- helm list

=======================

On the cluster, the team has installed multiple helm charts on a different namespace. By mistake, those deployed resources include one of the vulnerable images called kodekloud/webapp-color:v1. Find out the release name and uninstall it.

In this task, we will use the helm commands and jq tool. Here are the steps: -

1. Run the helm ls command with -A option to list the releases deployed on all the namespaces using helm.

        helm ls -A

2. We will use the jq tool to extract the image name from the deployments.

kubectl get deploy -n <NAMESPACE> <DEPLOYMENT-NAME> -o json | jq -r '.spec.template.spec.containers[].image'

3. Replace <NAMESPACE> with the namespace and <DEPLOYMENT-NAME> with the deployment name, which we get from the previous commands.

After finding the kodekloud/webapp-color:v1 image, use the helm uninstall to remove the deployed chart that are using this vulnerable image.

    helm uninstall <RELEASE-NAME> -n <NAMESPACE>

=======================

One application, webpage-server-01, is deployed on the Kubernetes cluster by the Helm tool. Now, the team wants to deploy a new version of the application by replacing the existing one. A new version of the helm chart is given in the /root/new-version directory on the terminal. Validate the chart before installing it on the Kubernetes cluster. 


Use the helm command to validate and install the chart. After successfully installing the newer version, uninstall the older version. 

helm ls -n default
cd /root/

helm lint ./new-version
helm install --generate-name ./new-version --> We haven't got any release name in the task, so we can generate the random name from the --generate-name option.
helm uninstall webpage-server-01 -n default
==================


