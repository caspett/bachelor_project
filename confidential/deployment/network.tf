# Get public ip of cluster
data "azurerm_public_ip" "cluster" {
  name                = [for r in data.azurerm_resources.this.resources : r if r.type == "Microsoft.Network/publicIPAddresses"][0].name
  resource_group_name = data.azurerm_kubernetes_cluster.this.node_resource_group

  depends_on = [
    data.azurerm_resources.this
  ]
}

#Setting firewall rule for azure mysql server
resource "azurerm_mysql_firewall_rule" "example" {
  name                = "AllowCluster"
  resource_group_name = data.azurerm_resource_group.this.name
  server_name         = data.azurerm_mysql_server.this.name
  start_ip_address = data.azurerm_public_ip.cluster.ip_address
  end_ip_address   =  data.azurerm_public_ip.cluster.ip_address

  depends_on = [
    data.azurerm_resources.this
  ]
}

#Getting information about all resources in specified resource group
data "azurerm_resources" "this" {
  resource_group_name = data.azurerm_kubernetes_cluster.this.node_resource_group
}

#Role assigment for allowing cluster to pull image from container registry
resource "azurerm_role_assignment" "this" {
  principal_id                     = data.azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.this.id
  skip_service_principal_aad_check = true
}

# What public endpoint is used by the cluster to connect to the database 
output "public_ip" {
  value = data.azurerm_public_ip.cluster.ip_address
}

# output "test" {
#   value = data.azurerm_resources.this.resources
# }