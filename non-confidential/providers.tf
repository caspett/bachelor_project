terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.41.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
  }
  backend "azurerm" {}
}
provider "azurerm" {
  features {}
}

provider "kubernetes" {
  config_path = var.config_path
}