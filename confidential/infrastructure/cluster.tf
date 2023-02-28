# Hent eksisterende resurssgruppe
data "azurerm_resource_group" "this" {
  name = var.target_resource_group
}



#Opprett et kubernetes cluster
resource "azurerm_kubernetes_cluster" "this" {
  name                = "arck-web-cluster"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  dns_prefix          = "exampleaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DC2as_v5"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

resource "null_resource" "enable_addons" {
  provisioner "local-exec" {
    command = "az aks enable-addons --addons confcom --name ${azurerm_kubernetes_cluster.this.name} --resource-group ${var.target_resource_group}"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.this.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.this.kube_config_raw

  sensitive = true
}


