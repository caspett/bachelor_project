data "azurerm_resource_group" "this" {
  name = var.target_resource_group
}
data "azurerm_kubernetes_cluster" "this" {
  name = var.cluster_name
  resource_group_name = var.target_resource_group
}

data "azurerm_mssql_server" "this" {
  name = var.mssql_server_name
  resource_group_name = var.target_resource_group

}

data "azurerm_mssql_database" "this" {
  name = var.mssql_database_name
  server_id = data.azurerm_mssql_server.this.id
}

data "azurerm_mysql_server" "this" {
  name = var.mysql_server_name
  resource_group_name = var.target_resource_group
}

data "azurerm_mysql_database" "this" {
  name = var.mysql_database_name
  server_id = data.azurerm_mysql_server.this.id
}

