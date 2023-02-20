data "azurerm_resource_group" "this" {
  name = var.target_resource_group
}
data "azurerm_kubernetes_cluster" "this" {
  name = var.cluster_name
}

data "azurerm_mssql_server" "this" {
  name = var.mssql_server_name
}

data "azurerm_mssql_database" "this" {
  name = var.mssql_database_name
}

