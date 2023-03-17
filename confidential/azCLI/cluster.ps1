
az aks create -g rg-confidential-dev --name myAKSCluster --generate-ssh-keys --enable-addons confcom

az aks nodepool add --cluster-name myAKSCluster --name confcompool1 --resource-group rg-confidential-dev --node-vm-size Standard_DC2ds_v3 --node-count 1

az aks get-credentials --resource-group rg-confidential-dev --name myAKSCluster

kubectl get pods --all-namespaces

kubectl apply -f hello-world-enclave.yaml

kubectl get jobs -l app=sgx-test

kubectl get pods -l app=sgx-test

kubectl logs -l app=sgx-test

###########

az aks get-credentials --resource-group rg-confidential-dev --name conf-arck-web-cluster

az aks nodepool add --cluster-name conf-arck-web-cluster --name confcompool1 --resource-group rg-confidential-dev --node-vm-size Standard_DC2ds_v3 --node-count 1

az aks enable-addons --addons confcom --name conf-arck-web-cluster --resource-group rg-confidential-dev

az aks nodepool list --cluster-name conf-arck-web-cluster --resource-group rg-confidential-dev


kubectl get nodes

kubectl get pods --all-namespaces


