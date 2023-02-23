# data "azurerm_client_config" "current" {}

# # Create an Azure Key Vault
# resource "azurerm_key_vault" "this" {
#   name                        = "non-conf-keyvault"
#   location                    = data.azurerm_resource_group.this.location
#   resource_group_name         = data.azurerm_resource_group.this.name
#   enabled_for_disk_encryption = false
#   tenant_id                   = data.azurerm_client_config.current.tenant_id
#   soft_delete_retention_days  = 7
#   purge_protection_enabled    = false
#   sku_name                    = "standard"

#   #Setting access policy for client
#   access_policy {
#     tenant_id = data.azurerm_client_config.current.tenant_id
#     object_id = data.azurerm_client_config.current.object_id

#     certificate_permissions = [
#       "Create",
#       "Delete",
#       "DeleteIssuers",
#       "Get",
#       "GetIssuers",
#       "Import",
#       "List",
#       "ListIssuers",
#       "ManageContacts",
#       "ManageIssuers",
#       "Purge",
#       "SetIssuers",
#       "Update",
#     ]
#     key_permissions = [
#       "Get",
#       "Create",
#       "Purge",
#       "Sign",
#       "Verify"
#     ]

#     secret_permissions = [
#       "Get",
#       "Set",
#       "Purge",
#       "Delete"
#     ]

#     storage_permissions = [
#       "Get",
#     ]
#   }
# }
# # Generate a private key
# resource "tls_private_key" "this" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "tls_self_signed_cert" "this" {
#   private_key_pem = tls_private_key.this.private_key_pem

#   subject {
#     common_name  = "example.com"
#     organization = "ACME Examples, Inc"
#   }

#   validity_period_hours = 8760

#   allowed_uses = [
#     "key_encipherment",
#     "digital_signature",
#     "server_auth",
#   ]
# }

# # Store the private key and SSL/TLS certificate in Azure Key Vault
# resource "azurerm_key_vault_secret" "non_conf_private_key" {
#   name         = "non-conf-private-key"
#   value        = tls_private_key.this.private_key_pem
#   key_vault_id = azurerm_key_vault.this.id
# }

# resource "azurerm_key_vault_certificate" "this" {
#   name         = "non-conf-certificate"
#   key_vault_id = azurerm_key_vault.this.id

#   export = true

#  certificate_policy {
#     issuer_parameters {
#       name = "Self"
#     }

#     key_properties {
#       exportable = true
#       key_size   = 2048
#       key_type   = "RSA"
#       reuse_key  = true
#     }

#     lifetime_action {
#       action {
#         action_type = "AutoRenew"
#       }

#       trigger {
#         days_before_expiry = 30
#       }
#     }

#     secret_properties {
#       content_type = "application/x-pkcs12"
#     }

#     x509_certificate_properties {
#       # Server Authentication = 1.3.6.1.5.5.7.3.1
#       # Client Authentication = 1.3.6.1.5.5.7.3.2
#       extended_key_usage = ["1.3.6.1.5.5.7.3.1"]

#       key_usage = [
#         "cRLSign",
#         "dataEncipherment",
#         "digitalSignature",
#         "keyAgreement",
#         "keyCertSign",
#         "keyEncipherment",
#       ]

#       subject_alternative_names {
#         dns_names = ["internal.contoso.com", "domain.hello.world"]
#       }

#       subject            = "CN=hello-world"
#       validity_in_months = 12
#     }
#   }
# }
# # output "tls_private_key" {
# #   value = tls_private_key.this
# #   sensitive = false
# # }