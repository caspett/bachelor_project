
resource "azurerm_mssql_server" "example" {
  name                         = "non-confidential-sqlserver"
  resource_group_name          = var.target_resource_group
  location                     = data.azurerm_resource_group.this.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_mssql_database" "test" {
  name           = "acctest-db-d"
  server_id      = azurerm_mssql_server.example.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false
  storage_account_type = "Local"
  tags = {
    foo = "bar"
  }
}