

#Get cluster credentials
az aks get-credentials --resource-group rg-confidential-dev --name conf-arck-web-cluster

## Retrieve the join token for your Fortanix CCM account from the CCM UI and store it as a Kubernetes secret in your cluster.
# Navigate to the COMPUTE NODES tab in the CCM UI and click + ENROLL NODE to bring up the token dialog. Copy the token into the following variable

$token = "MX1emNUDwnpWNXpjf0ZEVVJfkwtq67Vj9M6nhC8M4Xqs31Tizkcynnhz74uXttEPI1CPAhKaMpsIguraFle4fg"
# Use the following command to store the token as a Kubernetes secret for the cluster (Replace <token> value with your token)
kubectl create secret generic em-token --from-literal=token=$token

# Deploy the node agent DaemonSet
kubectl create -f agent-daemonset.yaml

## The CCM node agent DaemonSets are now deployed. Validate that the node agent pod is up and running using the command
kubectl get pods --all-namespaces

#Deploy application and load balancer:
kubectl apply -f conf-webserver.yaml

#Check application logs:
kubectl logs -l app=sgx-test

#Print logs to file
kubectl logs sgx-test-l44k6 > log2.txt


#Cleanup

#Destroy load balancer
kubectl delete service sgx-test-lb  

#Destroy application
kubectl delete job sgx-test