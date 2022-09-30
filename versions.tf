terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.24.0"
    }
  }
  required_version = "~> 1.3.1"
}

provider "azurerm" {
  features {}

  subscription_id = "3a0d8172-633d-4556-9014-57c355f8ec90"
  client_id       = "24c5a9a5-3165-4e19-a281-2c72ba9dc98f"
  client_secret   = var.arm_secret
  tenantenant_id  = "54ff7139-ea65-43af-82bc-d85b0117b458"
}