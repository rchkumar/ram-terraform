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



locals {
 
    resource_group_name = "ramcheekoti-rg"
    location = "southindia"
 
     virtual_network = {
 
        name = "ram-vnet"
        address_space = ["10.0.0.0/16"]
 
    }
    subnets = [
 
        {
            subnet1_name = "subnet1"
            subnet1_address_prefix = "10.0.0.0/24"
 
        },
        {
             subnet2_name = "subnet2"
             subnet2_address_prefix = "10.0.1.0/24"
 

        }
    ] 
 
}
 
resource "azurerm_resource_group" "ramrg" {
 
    name = local.resource_group_name
    location = local.location
 
  
}
 
resource "azurerm_virtual_network" "example" {
  name                = local.virtual_network.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = local.virtual_network.address_space
 

  subnet {
    name           = local.subnets[0].subnet1_name
    address_prefix = local.subnets[0].subnet1_address_prefix
  }
 
  subnet {
    name           = local.subnets[1].subnet2_name
    address_prefix = local.subnets[1].subnet2_address_prefix
  }
 
    depends_on = [
      azurerm_resource_group.ramrg
    ]
 

}
