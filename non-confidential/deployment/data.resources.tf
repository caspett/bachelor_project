data "azurerm_resource_group" "this" {
  name = var.target_resource_group
}
data "azurerm_kubernetes_cluster" "this" {
  name = var.cluster_name
  resource_group_name = var.target_resource_group
}

data "azurerm_mysql_server" "this" {
  name = var.mysql_server_name
  resource_group_name = var.target_resource_group
}

# Get containter registry information
data "azurerm_container_registry" "this" {
  name                = "KubDocker"
  resource_group_name = var.target_resource_group
}

