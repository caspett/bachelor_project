resource "azurerm_mysql_server" "this" {
  name                = "conf-mysqlserver"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  administrator_login          = "mysqladminunen"
  administrator_login_password = var.mysql_passwd

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = false
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "this" {
  name                = "mydb"
  resource_group_name = data.azurerm_resource_group.this.name
  server_name         = azurerm_mysql_server.this.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# Fetching host ip address
data "http" "my_ip" {
  url = "https://ifconfig.co"
  request_headers = {
    "Accept" = "text/plain"
  }
}

#Creating a firewall rule that allows terraform to connect to database
resource "azurerm_mysql_firewall_rule" "host" {
  name                = "AllowHost"
  resource_group_name = data.azurerm_resource_group.this.name
  server_name         = azurerm_mysql_server.this.name
  start_ip_address = trim(data.http.my_ip.body, "\n")
  end_ip_address   =  trim(data.http.my_ip.body, "\n")
}
# Filling database with test data
resource "null_resource" "mysql" {
  provisioner "local-exec" {
    command = "mysql -h ${azurerm_mysql_server.this.fqdn} -u ${azurerm_mysql_server.this.administrator_login}@${azurerm_mysql_server.this.name} -p${var.mysql_passwd} < ../../mysql_docker/yourfile.sql"
  }
  depends_on = [
    azurerm_mysql_server.this, azurerm_mysql_database.this, azurerm_mysql_firewall_rule.host
  ]
}