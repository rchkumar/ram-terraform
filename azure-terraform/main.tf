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

  resource_group_name = "ramch-rg1"
  resource_group_location = "southindia"

  network = {
    name                = "ram-vnet"
    address_space       = ["10.0.0.0/16"]
  }

  subnets = [

    {
      name = "SubnetA"
      address_space = ["10.0.1.0/24"]

    },

    {
      name = "SubnetB"
      address_space = ["10.0.2.0/24"]
    }

  ]

  network_interface = {

    name = "app-interface"
  }

}

resource "azurerm_resource_group" "ramchrg1" {
  location = local.resource_group_location
  name     = local.resource_group_name
}

resource "azurerm_virtual_network" "ramvnet" {
  name                = local.network.name
  location            = local.resource_group_location
  resource_group_name = local.resource_group_name
  address_space       = local.network.address_space


}


resource "azurerm_subnet" "subnetA" {
  name                 = local.subnets[0].name
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.network.name
  address_prefixes     = local.subnets[0].address_space

}

resource "azurerm_subnet" "subnetB" {
  name                 = local.subnets[1].name
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.network.name
  address_prefixes     = local.subnets[1].address_space

}

resource "azurerm_network_interface" "appinterface" {
  name                = "app-interface"
  location            = local.resource_group_location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = local.network_interface.name
    subnet_id                     = azurerm_subnet.subnetA.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.apppublicip.id
  }
}

output "SubnetA-ID" {
  value = azurerm_subnet.subnetA.id
}


resource "azurerm_public_ip" "apppublicip" {
  name                    = "app-public-ip"
  location                = local.resource_group_location
  resource_group_name     = local.resource_group_name
  allocation_method       = "Static"

  depends_on = [

    azurerm_resource_group.ramchrg1
  ]

}

output "public-ip" {
  value = azurerm_public_ip.apppublicip.id
}