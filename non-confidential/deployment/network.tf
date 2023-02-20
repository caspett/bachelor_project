#Setting firewall rule for Microsoft SQL server
# resource "azurerm_mssql_firewall_rule" "example" {
#   name             = "FirewallRule1"
#   server_id        = data.azurerm_mssql_server.this.id
#   start_ip_address = cidrhost(data.azurerm_kubernetes_cluster.this.network_profile[0].pod_cidr,1)
#   end_ip_address   = cidrhost(data.azurerm_kubernetes_cluster.this.network_profile[0].pod_cidr,65535)
# }

#Setting firewall rule for azure mysql server

resource "azurerm_mysql_firewall_rule" "example" {
  name                = "AllowCluster"
  resource_group_name = data.azurerm_resource_group.this.name
  server_name         = data.azurerm_mysql_server.this.name
  start_ip_address = cidrhost(data.azurerm_kubernetes_cluster.this.network_profile[0].pod_cidr,1)
  end_ip_address   = cidrhost(data.azurerm_kubernetes_cluster.this.network_profile[0].pod_cidr,65535)
}
data "azurerm_resources" "this" {
  resource_group_name = data.azurerm_kubernetes_cluster.this.node_resource_group
}

output "vnet_cidr" {
  value = [for r in data.azurerm_resources.this.resources : r if r.type == "Microsoft.Network/virtualNetworks"][0].name
}