
resource "azurerm_mssql_server" "this" {
  name                         = "non-confidential-sqlserver"
  resource_group_name          = var.target_resource_group
  location                     = data.azurerm_resource_group.this.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = var.administrator_login_password
}

resource "azurerm_mssql_database" "this" {
  name           = "acctest-db-d"
  server_id      = azurerm_mssql_server.this.id
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

# Create a file with a SQL script to insert test data
# resource "local_file" "test_data_script" {
#   content = <<EOF
#     CREATE TABLE [dbo].[number_table2](id INT IDENTITY PRIMARY KEY, number INT)
#     GO
#   EOF
#   filename = "test_data.sql"
# }

# SQL queries supplying testdata

#     CREATE TABLE [dbo].[number_table](id INT IDENTITY PRIMARY KEY, number INT)
#     INSERT INTO number_table (number)
# VALUES 
#   (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
#   (11), (12), (13), (14), (15), (16), (17), (18), (19), (20),
#   (21), (22), (23), (24), (25), (26), (27), (28), (29), (30),
#   (31), (32), (33), (34), (35), (36), (37), (38), (39), (40),
#   (41), (42), (43), (44), (45), (46), (47), (48), (49), (50),
#   (51), (52), (53), (54), (55), (56), (57), (58), (59), (60),
#   (61), (62), (63), (64), (65), (66), (67), (68), (69), (70),
#   (71), (72), (73), (74), (75), (76), (77), (78), (79), (80),
#   (81), (82), (83), (84), (85), (86), (87), (88), (89), (90),
#   (91), (92), (93), (94), (95), (96), (97), (98), (99), (100);


# Execute the SQL script to insert test data
# resource "null_resource" "insert_test_data" { 
#   provisioner "local-exec" {
#     command = "sqlcmd -S ${azurerm_mssql_server.this.name}.database.windows.net -U ${azurerm_mssql_server.this.administrator_login} -P ${azurerm_mssql_server.this.administrator_login_password} -d ${azurerm_mssql_database.this.name}; CREATE TABLE [dbo].[number_table2](id INT IDENTITY PRIMARY KEY, number INT); GO"
#     interpreter = [
#       "PowerShell", "-Command"
#     ]
#   }
  # depends_on = [
  #   azurerm_mssql_database.this,
  # ]
#   triggers = {
#     server_hostname = azurerm_mssql_server.this.name
#     database_name  = azurerm_mssql_database.this.name
#   }
# }