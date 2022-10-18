terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.26.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "9ea687dd-8c83-4b91-8591-34cb80a6d220"
  tenant_id = "b9f52012-b5d7-4ab4-bfaa-2d31507ba0fe"
  client_id = "e83e3be5-8ea7-4d7c-9ecf-48c070d2e749"
  client_secret = "n_88Q~RbPn7.DWtiLLEHuCiKC~7vqhO5U3dOJaqU"

}

resource "azurerm_resource_group" "ramchrg1" {
  location = "southindia"
  name     = "ramch-rg1"
}