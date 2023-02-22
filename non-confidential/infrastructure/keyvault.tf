data "azurerm_client_config" "current" {}

# Create an Azure Key Vault
resource "azurerm_key_vault" "this" {
  name                        = "non-conf-keyvault"
  location                    = data.azurerm_resource_group.this.location
  resource_group_name         = data.azurerm_resource_group.this.name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"

  #Setting access policy for client
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    certificate_permissions = [
      "Create",
      "Delete",
      "DeleteIssuers",
      "Get",
      "GetIssuers",
      "Import",
      "List",
      "ListIssuers",
      "ManageContacts",
      "ManageIssuers",
      "Purge",
      "SetIssuers",
      "Update",
    ]
    key_permissions = [
      "Get",
      "Create",
      "Purge",
      "Sign",
      "Verify"
    ]

    secret_permissions = [
      "Get",
      "Set",
      "Purge",
      "Delete"
    ]

    storage_permissions = [
      "Get",
    ]
  }

  #Setting access policy for mysql server
  #   access_policy {
  #     tenant_id = data.azurerm_client_config.current.tenant_id
  #     object_id = data.azurerm_client_config.current.object_id

  #     key_permissions = [
  #       "Get",
  #     ]

  #     secret_permissions = [
  #       "Get",
  #     ]

  #     storage_permissions = [
  #       "Get",
  #     ]
  #   }
}
# Generate a private key
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# resource "tls_cert_request" "this" {
#   private_key_pem = tls_private_key.this.private_key_pem

#   subject {
#     common_name  = "example.com"
#     organization = "ACME Examples, Inc"
#   }
# }
# Generate a self-signed SSL/TLS certificate
# resource "tls_locally_signed_cert" "this" {

#   cert_request_pem = tls_cert_request.cert_request_pem
#   ca_private_key_pem = tls_private_key.this.private_key_pem
#   ca_cert_pem = tls_private_key.this.private_key_pem
#   allowed_uses = [
#     "key_encipherment",
#     "digital_signature",
#     "server_auth",
#   ]
  
#   validity_period_hours = 8760 # 1 year
# }

resource "tls_self_signed_cert" "this" {
  private_key_pem = tls_private_key.this.private_key_pem

  subject {
    common_name  = "example.com"
    organization = "ACME Examples, Inc"
  }

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

# Store the private key and SSL/TLS certificate in Azure Key Vault
resource "azurerm_key_vault_secret" "non_conf_private_key" {
  name         = "non-conf-private-key"
  value        = tls_private_key.this.private_key_pem
  key_vault_id = azurerm_key_vault.this.id
}

resource "azurerm_key_vault_certificate" "this" {
  name         = "non-conf-certificate"
  key_vault_id = azurerm_key_vault.this.id

  certificate {
    contents = tls_self_signed_cert.this.cert_pem
    password = ""
  }
}

# output "tls_private_key" {
#   value = tls_private_key.this
#   sensitive = false
# }