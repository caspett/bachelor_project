terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.44.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
     tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
  }
  backend "azurerm" {}
}
provider "azurerm" {
  features {}
}

# provider "kubernetes" {
#   config_path = var.config_path
# }

provider "kubernetes" {
  host = data.azurerm_kubernetes_cluster.this.kube_config.0.host
  username = data.azurerm_kubernetes_cluster.this.kube_config.0.username
  password = data.azurerm_kubernetes_cluster.this.kube_config.0.password
  client_certificate = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.client_certificate)
  client_key = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.cluster_ca_certificate)
}