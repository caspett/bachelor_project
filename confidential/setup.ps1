## Set up an SGX-capable cluster using the following commands:

# Create a resource group
az group create --name rg-confidential-dev --location northeurope

# Create an SGX capable cluster with a Confidential Computing addon
az aks create -l northeurope -g rg-confidential-dev -n conf-arck-web-cluster --vm-set-type VirtualMachineScaleSets --network-plugin azure --node-count 1 --node-vm-size Standard_DC2as_v5 --aks-custom-headers usegen2vm=true --enable-sgxquotehelper --enable-addon confcom --generate-ssh-keys

# Get the Kubernetes credentials. This will store the credentials in your .kube/config file
az aks get-credentials --admin --name conf-arck-web-cluster --resource-group rg-confidential-dev --overwrite-existing


## Use the following commands to verify that the nodes are created properly and the SGX-related DaemonSets are running on DCsv2 node pools.
kubectl get nodes -o wide
kubectl get pods --all-namespaces

## Retrieve the join token for your Fortanix CCM account from the CCM UI and store it as a Kubernetes secret in your cluster.
# Navigate to the COMPUTE NODES tab in the CCM UI and click + ENROLL NODE to bring up the token dialog. Copy the token into the following variable

$token = ""
# Use the following command to store the token as a Kubernetes secret for the cluster (Replace <token> value with your token)
kubectl create secret generic em-token --from-literal=token=$token

## Deploy the node agent DaemonSet using the CCM node agent YAML file below

# Fortanix CCM node agent YAML file:
See own yaml file

# Deploy the node agent DaemonSet
kubectl create -f agent-daemonset.yaml

## The CCM node agent DaemonSets are now deployed. Validate that the node agent pod is up and running using the command
kubectl get pods --all-namespaces