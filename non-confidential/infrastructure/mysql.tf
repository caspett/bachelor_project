resource "azurerm_mysql_server" "this" {
  name                = "non-conf-mysqlserver"
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

