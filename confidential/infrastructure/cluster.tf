# Hent eksisterende resurssgruppe
data "azurerm_resource_group" "this" {
  name = var.target_resource_group
}



#Opprett et kubernetes cluster
resource "azurerm_kubernetes_cluster" "this" {
  name                = "conf-arck-web-cluster"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DC2ds_v3"
    # vm_size    = "Standard_DC4s_v2"

  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

#Sources:
# https://learn.microsoft.com/en-us/azure/confidential-computing/confidential-enclave-nodes-aks-get-started
# https://learn.microsoft.com/en-us/azure/confidential-computing/confidential-nodes-aks-overview#confidential-computing-add-on-for-aks
resource "null_resource" "enable_addons" {
  provisioner "local-exec" {
    command = "az aks enable-addons --addons confcom --name ${azurerm_kubernetes_cluster.this.name} --resource-group ${var.target_resource_group}"
  }
}

# Get containter registry information
data "azurerm_container_registry" "this" {
  name                = "KubDocker"
  resource_group_name = "rg-non-confidential-dev"
}

#Role assigment for allowing cluster to pull image from container registry
resource "azurerm_role_assignment" "this" {
  principal_id                     = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.this.id
  skip_service_principal_aad_check = true
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.this.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.this.kube_config_raw

  sensitive = true
}


